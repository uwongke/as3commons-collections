
package org.as3commons.collections;

import openfl.utils.Dictionary;
import org.as3commons.collections.framework.core.AbstractSortedCollection;
import org.as3commons.collections.framework.core.SortedNode;
import org.as3commons.collections.framework.core.SortedSetIterator;
import org.as3commons.collections.framework.IComparator;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.ISortedSet;

class SortedSet extends AbstractSortedCollection implements ISortedSet {
    private var _items : Dictionary<Dynamic, Dynamic>;

    private var _stringItems : Dynamic;

    public function new(comparator : IComparator = null) {
        super(comparator);
        
        _items = new Dictionary();
        _stringItems = {};
    }

    public function next(item : Dynamic) : Dynamic {
        var node : SortedNode = getNode(item);
        if (node != null) {
            node = nextNode_internal(node);
            if (node != null) {
                return node.item;
            }
        }
        return null;
    }

    public function previous(item : Dynamic) : Dynamic {
        var node : SortedNode = getNode(item);
        if (node != null) {
            node = previousNode_internal(node);
            if (node != null) {
                return node.item;
            }
        }
        return null;
    }

    public function lesser(item : Dynamic) : Dynamic {
        var node : SortedNode = lesserNode(item);
        if (node == null) {
            return null;
        }
        return node.item;
    }

    public function higher(item : Dynamic) : Dynamic {
        var node : SortedNode = higherNode(item);
        if (node == null) {
            return null;
        }
        return node.item;
    }

    public function equalItems(item : Dynamic) : Array<Dynamic> {
        var equalItems : Array<Dynamic> = new Array<Dynamic>();
        var node : SortedNode = firstEqualNode(item);
        if (node == null) {
            return equalItems;
        }
        
        while (node) {
            if (_comparator.compare(item, node.item)) {
                break;
            }
            equalItems.push(node.item);
            node = nextNode_internal(node);
        }
        
        return equalItems;
    }

    public function add(item : Dynamic) : Bool {
        var node : SortedNode;
        
        if (Std.is(item, String)) {
            if (Reflect.field(_stringItems, Std.string(item)) != null) {
                return false;
            }
            node = new SortedNode(item);
            addNode(node);
            Reflect.setField(_stringItems, Std.string(item), node);
        }
        else {
            if (Reflect.field(_items, Std.string(item)) != null) {
                return false;
            }
            node = new SortedNode(item);
            addNode(node);
            Reflect.setField(_items, Std.string(item), node);
        }
        return true;
    }

    override public function has(item : Dynamic) : Bool {
        if (Std.is(item, String)) {
            return Reflect.field(_stringItems, Std.string(item)) != null;
        }
        return Reflect.field(_items, Std.string(item)) != null;
    }

    override public function remove(item : Dynamic) : Bool {
        var node : SortedNode;
        
        if (Std.is(item, String)) {
            node = Reflect.field(_stringItems, Std.string(item));
            if (node == null) {
                return false;
            }
        }
        else {
            node = Reflect.field(_items, Std.string(item));
            if (node == null) {
                return false;
            }
        }
        
        removeNode(node);
        return true;
    }

    override public function clear() : Bool {
        if (_size == 0) {
            return false;
        }
        
        _items = new Dictionary();
        _stringItems = {};
        
        super.clear();
        return true;
    }

    override public function iterator(cursor : Dynamic = null) : IIterator {
        var node : SortedNode;
        if (Std.is(cursor, String)) {
            node = Reflect.field(_stringItems, Std.string(cursor));
        }
        else {
            node = Reflect.field(_items, Std.string(cursor));
        }
        return new SortedSetIterator(this, node);
    }

    private function getNode(item : Dynamic) : SortedNode {
        if (Std.is(item, String)) {
            return Reflect.field(_stringItems, Std.string(item));
        }
        return Reflect.field(_items, Std.string(item));
    }

    override private function removeNode(node : SortedNode) : Void {
        super.removeNode(node);
        
        if (Std.is(node.item, String)) {
            Reflect.deleteField(_stringItems, node.item);
        }
        else {
            //This is an intentional compilation error. See the README for handling the delete keyword
            //delete _items[null];
        }
    }
}