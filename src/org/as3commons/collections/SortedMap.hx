
package org.as3commons.collections;

import flash.utils.Dictionary;
import org.as3commons.collections.framework.core.AbstractSortedDuplicatesCollection;
import org.as3commons.collections.framework.core.SortedMapIterator;
import org.as3commons.collections.framework.core.SortedMapNode;
import org.as3commons.collections.framework.core.SortedNode;
import org.as3commons.collections.framework.IComparator;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.ISortedMap;

class SortedMap extends AbstractSortedDuplicatesCollection implements ISortedMap {
    public var firstKey(get, never) : Dynamic;
    public var lastKey(get, never) : Dynamic;

    private var _keys : Dictionary;

    private var _items : Dictionary;

    private var _stringMap : Dynamic;

    public function new(comparator : IComparator = null) {
        super(comparator);
        
        _items = new Dictionary();
        _keys = new Dictionary();
        _stringMap = {};
    }

    private function get_firstKey() : Dynamic {
        if (_root == null) {
            return null;
        }
        return cast((mostLeftNode_internal()), SortedMapNode).key;
    }

    private function get_lastKey() : Dynamic {
        if (_root == null) {
            return null;
        }
        return cast((mostRightNode_internal()), SortedMapNode).key;
    }

    public function nextKey(key : Dynamic) : Dynamic {
        var node : SortedMapNode = getNode(key);
        if (node != null) {
            node = try cast(nextNode_internal(node), SortedMapNode) catch(e:Dynamic) null;
            if (node != null) {
                return node.key;
            }
        }
        return null;
    }

    public function previousKey(key : Dynamic) : Dynamic {
        var node : SortedMapNode = getNode(key);
        if (node != null) {
            node = try cast(previousNode_internal(node), SortedMapNode) catch(e:Dynamic) null;
            if (node != null) {
                return node.key;
            }
        }
        return null;
    }

    public function lesserKey(item : Dynamic) : Dynamic {
        var node : SortedMapNode = try cast(lesserNode(item), SortedMapNode) catch(e:Dynamic) null;
        if (node == null) {
            return null;
        }
        return node.key;
    }

    public function higherKey(item : Dynamic) : Dynamic {
        var node : SortedMapNode = try cast(higherNode(item), SortedMapNode) catch(e:Dynamic) null;
        if (node == null) {
            return null;
        }
        return node.key;
    }

    public function equalKeys(item : Dynamic) : Array<Dynamic> {
        var equalKeys : Array<Dynamic> = new Array<Dynamic>();
        var node : SortedNode = firstEqualNode(item);
        if (node == null) {
            return equalKeys;
        }
        
        while (node) {
            if (_comparator.compare(item, node.item)) {
                break;
            }
            equalKeys.push(cast((node), SortedMapNode).key);
            node = nextNode_internal(node);
        }
        
        return equalKeys;
    }

    public function add(key : Dynamic, item : Dynamic) : Bool {
        if (Std.is(key, String)) {
            if (Reflect.field(_stringMap, Std.string(key)) != null) {
                return false;
            }
        }
        else if (Reflect.field(_keys, Std.string(key)) != null) {
            return false;
        }
        addNode(new SortedMapNode(key, item));
        
        return true;
    }

    public function replaceFor(key : Dynamic, item : Dynamic) : Bool {
        var node : SortedMapNode;
        if (Std.is(key, String)) {
            node = Reflect.field(_stringMap, Std.string(key));
        }
        else {
            node = Reflect.field(_items, Std.string(key));
        }
        
        if (node != null && node.item != item) {
            removeNode(node);
            node.item = item;
            addNode(node);
            return true;
        }
        
        return false;
    }

    public function hasKey(key : Dynamic) : Bool {
        return (Std.is(key, String)) ? Reflect.field(_stringMap, Std.string(key)) != null : Reflect.field(_keys, Std.string(key)) != null;
    }

    public function itemFor(key : Dynamic) : Dynamic {
        var node : SortedMapNode;
        if (Std.is(key, String)) {
            node = Reflect.field(_stringMap, Std.string(key));
        }
        else {
            node = Reflect.field(_items, Std.string(key));
        }
        return (node != null) ? node.item : null;
    }

    public function keysToArray() : Array<Dynamic> {
        var node : SortedNode = mostLeftNode_internal();
        var keys : Array<Dynamic> = new Array<Dynamic>();
        while (node) {
            keys.push(cast((node), SortedMapNode).key);
            node = nextNode_internal(node);
        }
        return keys;
    }

    public function keyIterator() : IIterator {
        return new KeyIterator(this);
    }

    public function removeKey(key : Dynamic) : Dynamic {
        var node : SortedMapNode;
        
        if (Std.is(key, String)) {
            if (Reflect.field(_stringMap, Std.string(key)) == null) {
                return null;
            }
            node = Reflect.field(_stringMap, Std.string(key));
        }
        else {
            if (Reflect.field(_keys, Std.string(key)) == null) {
                return null;
            }
            node = Reflect.field(_items, Std.string(key));
        }
        
        removeNode(node);
        return node.item;
    }

    override public function clear() : Bool {
        if (_size == 0) {
            return false;
        }
        
        _keys = new Dictionary();
        _items = new Dictionary();
        _stringMap = {};
        
        super.clear();
        return true;
    }

    override public function iterator(cursor : Dynamic = null) : IIterator {
        var node : SortedMapNode;
        if (Std.is(cursor, String)) {
            node = Reflect.field(_stringMap, Std.string(cursor));
        }
        else {
            node = Reflect.field(_items, Std.string(cursor));
        }
        return new SortedMapIterator(this, node);
    }

    private function getNode(key : Dynamic) : SortedMapNode {
        if (Std.is(key, String)) {
            return Reflect.field(_stringMap, Std.string(key));
        }
        return Reflect.field(_items, Std.string(key));
    }

    override private function addNode(node : SortedNode) : Void {
        super.addNode(node);
        
        var key : Dynamic = cast((node), SortedMapNode).key;
        
        if (Std.is(key, String)) {
            Reflect.setField(_stringMap, Std.string(key), node);
        }
        else {
            Reflect.setField(_keys, Std.string(key), key);
            Reflect.setField(_items, Std.string(key), node);
        }
    }

    override private function removeNode(node : SortedNode) : Void {
        super.removeNode(node);
        
        var key : Dynamic = cast((node), SortedMapNode).key;
        
        if (Std.is(key, String)) {
            Reflect.deleteField(_stringMap, Std.string(key));
        }
        else {
            //This is an intentional compilation error. See the README for handling the delete keyword
            //delete _keys[key];
            //This is an intentional compilation error. See the README for handling the delete keyword
            //delete _items[key];
        }
    }
}


class KeyIterator implements IIterator {
    private var _map : SortedMap;
    private var _next : SortedNode;
    
    @:allow(org.as3commons.collections)
    private function new(map : SortedMap) {
        _map = map;
        _next = map.mostLeftNode_internal();
    }
    
    public function hasNext() : Bool {
        return _next != null;
    }
    
    public function next() : Dynamic {
        if (_next == null) {
            return null;
        }
        var next : SortedNode = _next;
        _next = _map.nextNode_internal(_next);
        return cast((next), SortedMapNode).key;
    }
}