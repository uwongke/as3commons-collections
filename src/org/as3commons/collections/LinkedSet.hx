
package org.as3commons.collections;

import org.as3commons.collections.framework.core.LinkedSetIterator;
import org.as3commons.collections.framework.IIterator;
import flash.utils.Dictionary;
import org.as3commons.collections.framework.core.AbstractLinkedCollection;
import org.as3commons.collections.framework.core.LinkedNode;
import org.as3commons.collections.framework.IOrderedSet;

class LinkedSet extends AbstractLinkedCollection implements IOrderedSet {

    private var _items : Dictionary;

    private var _stringItems : Dynamic;

    public function new() {
        super();
        _items = new Dictionary();
        _stringItems = {};
    }

    public function addFirst(item : Dynamic) : Bool {
        var node : LinkedNode = add_private(item);
        if (node != null) {
            addNodeFirst(node);
            return true;
        }
        else {
            return false;
        }
    }

    public function addLast(item : Dynamic) : Bool {
        var node : LinkedNode = add_private(item);
        if (node != null) {
            addNodeLast(node);
            return true;
        }
        else {
            return false;
        }
    }

    public function addBefore(nextItem : Dynamic, item : Dynamic) : Bool {
        var nextNode : LinkedNode;
        
        if (Std.is(nextItem, String)) {
            nextNode = Reflect.field(_stringItems, Std.string(nextItem));
        }
        else {
            nextNode = Reflect.field(_items, Std.string(nextItem));
        }
        if (nextNode == null) {
            return false;
        }
        
        var node : LinkedNode = add_private(item);
        if (node == null) {
            return false;
        }
        
        addNodeBefore(nextNode, node);
        return true;
    }

    public function addAfter(previousItem : Dynamic, item : Dynamic) : Bool {
        var previousNode : LinkedNode;
        
        if (Std.is(previousItem, String)) {
            previousNode = Reflect.field(_stringItems, Std.string(previousItem));
        }
        else {
            previousNode = Reflect.field(_items, Std.string(previousItem));
        }
        if (previousNode == null) {
            return false;
        }
        
        var node : LinkedNode = add_private(item);
        if (node == null) {
            return false;
        }
        
        addNodeAfter(previousNode, node);
        return true;
    }

    public function replace(oldItem : Dynamic, item : Dynamic) : Bool {
        
        if (Std.is(item, String) && Reflect.field(_stringItems, Std.string(item)) != null) {
            return false;
        }
        else if (Reflect.field(_items, Std.string(item)) != null) {
            return false;
        }
        
        // test old item if it is contained
        var node : LinkedNode;
        if (Std.is(oldItem, String)) {
            if (Reflect.field(_stringItems, Std.string(oldItem)) != null) {
                node = Reflect.field(_stringItems, Std.string(oldItem));
                node.item = item;
                Reflect.setField(_stringItems, Std.string(item), node);
                Reflect.deleteField(_stringItems, Std.string(oldItem));
                return true;
            }
        }
        else if (Reflect.field(_items, Std.string(oldItem)) != null) {
            node = Reflect.field(_items, Std.string(oldItem));
            node.item = item;
            Reflect.setField(_items, Std.string(item), node);
            //This is an intentional compilation error. See the README for handling the delete keyword
            //delete _items[oldItem];
            return true;
        }
        
        return false;
    }

    public function next(item : Dynamic) : Dynamic {
        var node : LinkedNode = getNode(item);
        if (node != null && node.right) {
            return node.right.item;
        }
        return null;
    }

    public function previous(item : Dynamic) : Dynamic {
        var node : LinkedNode = getNode(item);
        if (node != null && node.left) {
            return node.left.item;
        }
        return null;
    }

    override public function removeFirst() : Dynamic {
        if (_size == 0) {
            return null;
        }
        remove_private(_first.item);
        return super.removeFirst();
    }

    override public function removeLast() : Dynamic {
        if (_size == 0) {
            return null;
        }
        remove_private(_last.item);
        return super.removeLast();
    }

    public function add(item : Dynamic) : Bool {
        var node : LinkedNode = add_private(item);
        if (node != null) {
            addNodeLast(node);
            return true;
        }
        else {
            return false;
        }
    }

    override public function has(item : Dynamic) : Bool {
        return (Std.is(item, String)) ? Reflect.field(_stringItems, Std.string(item)) != null : Reflect.field(_items, Std.string(item)) != null;
    }

    override public function remove(item : Dynamic) : Bool {
        var node : LinkedNode;
        
        if (Std.is(item, String)) {
            if (Reflect.field(_stringItems, Std.string(item)) == null) {
                return false;
            }
            node = Reflect.field(_stringItems, Std.string(item));
        }
        else {
            if (Reflect.field(_items, Std.string(item)) == null) {
                return false;
            }
            node = Reflect.field(_items, Std.string(item));
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
        var node : LinkedNode;
        if (Std.is(cursor, String)) {
            node = Reflect.field(_stringItems, Std.string(cursor));
        }
        else {
            node = Reflect.field(_items, Std.string(cursor));
        }
        return new LinkedSetIterator(this, node);
    }

    override private function removeNode(node : LinkedNode) : Void {
        remove_private(node.item);
        super.removeNode(node);
    }

    private function getNode(item : Dynamic) : LinkedNode {
        if (Std.is(item, String)) {
            return Reflect.field(_stringItems, Std.string(item));
        }
        return Reflect.field(_items, Std.string(item));
    }
    

    private function add_private(item : Dynamic) : LinkedNode {
        var node : LinkedNode;
        
        if (Std.is(item, String)) {
            if (Reflect.field(_stringItems, Std.string(item)) != null) {
                return null;
            }
            node = new LinkedNode(item);
            Reflect.setField(_stringItems, Std.string(item), node);
        }
        else {
            if (Reflect.field(_items, Std.string(item)) != null) {
                return null;
            }
            node = new LinkedNode(item);
            Reflect.setField(_items, Std.string(item), node);
        }
        
        return node;
    }

    private function remove_private(item : Dynamic) : Void {
        if (Std.is(item, String)) {
            Reflect.deleteField(_stringItems, Std.string(item));
        }
        else {
            //This is an intentional compilation error. See the README for handling the delete keyword
            //delete _items[item];
        }
    }
}

