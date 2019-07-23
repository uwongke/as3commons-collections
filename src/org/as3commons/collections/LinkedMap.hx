
package org.as3commons.collections;

import flash.utils.Dictionary;
import org.as3commons.collections.framework.core.AbstractLinkedDuplicatesCollection;
import org.as3commons.collections.framework.core.LinkedMapIterator;
import org.as3commons.collections.framework.core.LinkedMapNode;
import org.as3commons.collections.framework.core.LinkedNode;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.IOrderedMap;

class LinkedMap extends AbstractLinkedDuplicatesCollection implements IOrderedMap {
    public var firstKey(get, never) : Dynamic;
    public var lastKey(get, never) : Dynamic;

    private var _keys : Dictionary;

    private var _items : Dictionary;

    private var _stringMap : Dynamic;

    public function new() {
        super();
        _items = new Dictionary();
        _keys = new Dictionary();
        _stringMap = {};
    }

    public function addFirst(key : Dynamic, item : Dynamic) : Bool {
        var node : LinkedMapNode = add_private(key, item);
        if (node != null) {
            addNodeFirst(node);
            return true;
        }
        else {
            return false;
        }
    }

    public function addLast(key : Dynamic, item : Dynamic) : Bool {
        var node : LinkedMapNode = add_private(key, item);
        if (node != null) {
            addNodeLast(node);
            return true;
        }
        else {
            return false;
        }
    }

    public function addBefore(nextKey : Dynamic, key : Dynamic, item : Dynamic) : Bool {
        var nextNode : LinkedMapNode;
        
        if (Std.is(nextKey, String)) {
            nextNode = Reflect.field(_stringMap, Std.string(nextKey));
        }
        else {
            nextNode = Reflect.field(_items, Std.string(nextKey));
        }
        if (nextNode == null) {
            return false;
        }
        
        var node : LinkedMapNode = add_private(key, item);
        if (node == null) {
            return false;
        }
        
        addNodeBefore(nextNode, node);
        return true;
    }

    public function addAfter(previousKey : Dynamic, key : Dynamic, item : Dynamic) : Bool {
        var previousNode : LinkedMapNode;
        
        if (Std.is(previousKey, String)) {
            previousNode = Reflect.field(_stringMap, Std.string(previousKey));
        }
        else {
            previousNode = Reflect.field(_items, Std.string(previousKey));
        }
        if (previousNode == null) {
            return false;
        }
        
        var node : LinkedMapNode = add_private(key, item);
        
        if (node == null) {
            return false;
        }
        
        addNodeAfter(previousNode, node);
        return true;
    }

    private function get_firstKey() : Dynamic {
        if (_first) {
            return cast((_first), LinkedMapNode).key;
        }
        return null;
    }

    private function get_lastKey() : Dynamic {
        if (_last) {
            return cast((_last), LinkedMapNode).key;
        }
        return null;
    }

    public function nextKey(key : Dynamic) : Dynamic {
        var node : LinkedNode = getNode(key);
        if (node != null && node.right) {
            return cast((node.right), LinkedMapNode).key;
        }
        return null;
    }

    public function previousKey(key : Dynamic) : Dynamic {
        var node : LinkedNode = getNode(key);
        if (node != null && node.left) {
            return cast((node.left), LinkedMapNode).key;
        }
        return null;
    }

    override public function removeFirst() : Dynamic {
        if (_size == 0) {
            return null;
        }
        removeKey_private(cast((_first), LinkedMapNode).key);
        return super.removeFirst();
    }

    override public function removeLast() : Dynamic {
        if (_size == 0) {
            return null;
        }
        removeKey_private(cast((_last), LinkedMapNode).key);
        return super.removeLast();
    }

    public function add(key : Dynamic, item : Dynamic) : Bool {
        var node : LinkedMapNode = add_private(key, item);
        if (node != null) {
            addNodeLast(node);
            return true;
        }
        else {
            return false;
        }
    }

    public function replaceFor(key : Dynamic, item : Dynamic) : Bool {
        var node : LinkedMapNode;
        if (Std.is(key, String)) {
            node = Reflect.field(_stringMap, Std.string(key));
        }
        else {
            node = Reflect.field(_items, Std.string(key));
        }
        if (node != null && node.item != item) {
            node.item = item;
            return true;
        }
        return false;
    }

    public function hasKey(key : Dynamic) : Bool {
        return (Std.is(key, String)) ? Reflect.field(_stringMap, Std.string(key)) != null : Reflect.field(_keys, Std.string(key)) != null;
    }

    public function itemFor(key : Dynamic) : Dynamic {
        var node : LinkedMapNode;
        if (Std.is(key, String)) {
            node = Reflect.field(_stringMap, Std.string(key));
        }
        else {
            node = Reflect.field(_items, Std.string(key));
        }
        return (node != null) ? node.item : null;
    }

    public function keysToArray() : Array<Dynamic> {
        var node : LinkedNode = _first;
        var keys : Array<Dynamic> = new Array<Dynamic>();
        while (node) {
            keys.push(cast((node), LinkedMapNode).key);
            node = node.right;
        }
        return keys;
    }

    public function keyIterator() : IIterator {
        return new KeyIterator(this);
    }

    public function removeKey(key : Dynamic) : Dynamic {
        var node : LinkedNode;
        
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
        var node : LinkedMapNode;
        if (Std.is(cursor, String)) {
            node = Reflect.field(_stringMap, Std.string(cursor));
        }
        else {
            node = Reflect.field(_items, Std.string(cursor));
        }
        return new LinkedMapIterator(this, node);
    }

    private function getNode(key : Dynamic) : LinkedMapNode {
        if (Std.is(key, String)) {
            return Reflect.field(_stringMap, Std.string(key));
        }
        return Reflect.field(_items, Std.string(key));
    }

    override private function removeNode(node : LinkedNode) : Void {
        super.removeNode(node);
        removeKey_private(cast((node), LinkedMapNode).key);
    }

    private function add_private(key : Dynamic, item : Dynamic) : LinkedMapNode {
        var node : LinkedMapNode;
        
        if (Std.is(key, String)) {
            if (Reflect.field(_stringMap, Std.string(key)) != null) {
                return null;
            }
            node = new LinkedMapNode(key, item);
            Reflect.setField(_stringMap, Std.string(key), node);
        }
        else {
            if (Reflect.field(_keys, Std.string(key)) != null) {
                return null;
            }
            node = new LinkedMapNode(key, item);
            Reflect.setField(_keys, Std.string(key), key);
            Reflect.setField(_items, Std.string(key), node);
        }
        
        return node;
    }

    private function removeKey_private(key : Dynamic) : Void {
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
    private var _next : LinkedNode;
    
    @:allow(org.as3commons.collections)
    private function new(map : LinkedMap) {
        _next = map.firstNode_internal;
    }
    
    public function hasNext() : Bool {
        return _next != null;
    }
    
    public function next() : Dynamic {
        if (_next == null) {
            return null;
        }
        var next : LinkedNode = _next;
        _next = _next.right;
        return cast((next), LinkedMapNode).key;
    }
}
