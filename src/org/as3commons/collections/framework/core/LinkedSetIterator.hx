package org.as3commons.collections.framework.core;

import org.as3commons.collections.framework.core.AbstractLinkedCollectionIterator;
import org.as3commons.collections.framework.core.LinkedNode;
import org.as3commons.collections.framework.IOrderedSetIterator;

class LinkedSetIterator extends AbstractLinkedCollectionIterator implements IOrderedSetIterator {
    public var previousItem(get, never) : Dynamic;
    public var nextItem(get, never) : Dynamic;

    public function new(orderedSet : LinkedSet, next : LinkedNode = null) {
        super(orderedSet);
        
        if (next != null) {
            _next = next;
        }
    }

    public function addBefore(item : Dynamic) : Bool {
        if (_next != null) {
            if (!cast((_collection), LinkedSet).addBefore(_next.item, item)) {
                return false;
            }
        }
        else if (!cast((_collection), LinkedSet).addLast(item)) {
            return false;
        }
        _current = null;
        return true;
    }

    public function addAfter(item : Dynamic) : Bool {
        if (_next != null) {
            if (!cast((_collection), LinkedSet).addBefore(_next.item, item)) {
                return false;
            }
            _next = _next.left;
        }
        else {
            if (!cast((_collection), LinkedSet).add(item)) {
                return false;
            }
            _next = _collection.lastNode_internal;
        }
        _current = null;
        return true;
    }

    public function replace(item : Dynamic) : Bool {
        if (_current == null) {
            return false;
        }
        
        var oldCurrent : LinkedNode = _current;
        var previousNode : LinkedNode = _current.left;
        
        if (!cast((_collection), LinkedSet).replace(oldCurrent.item, item)) {
            return false;
        }
        //if (!LinkedSet(_collection).replaceNode_internal(_current, item)) return false;
        _current = (previousNode != null) ? previousNode.right : _collection.firstNode_internal;
        
        if (oldCurrent == _next) {
            _next = _current;
        }
        
        return true;
    }

    private function get_previousItem() : Dynamic {
        return (_next != null) ? (_next.left) ? _next.left.item : null : (_collection.size) ? _collection.lastNode_internal.item : null;
    }

    private function get_nextItem() : Dynamic {
        return (_next != null) ? _next.item : null;
    }

    override private function removeCurrent() : Void {
        cast((_collection), LinkedSet).remove(_current.item);
    }
}