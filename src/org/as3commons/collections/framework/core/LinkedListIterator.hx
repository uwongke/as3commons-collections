package org.as3commons.collections.framework.core;

import org.as3commons.collections.framework.core.AbstractLinkedCollectionIterator;
import org.as3commons.collections.framework.core.LinkedNode;
import org.as3commons.collections.framework.ILinkedListIterator;

class LinkedListIterator extends AbstractLinkedCollectionIterator implements ILinkedListIterator {
    public var previousItem(get, never) : Dynamic;
    public var nextItem(get, never) : Dynamic;

    public function new(list : LinkedList) {
        super(list);
    }

    private function get_previousItem() : Dynamic {
        return (_next != null) ? (_next.left !=null) ? _next.left.item : null : (_collection.size !=0) ? _collection.lastNode_internal.item : null;
    }

    private function get_nextItem() : Dynamic {
        return (_next != null) ? _next.item : null;
    }

    public function addBefore(item : Dynamic) : Void {
        _current = null;
        cast((_collection), LinkedList).addNodeBefore_internal(_next, new LinkedNode(item));
    }

    public function addAfter(item : Dynamic) : Void {
        _current = null;
        
        if (_next != null){
            
            cast((_collection), LinkedList).addNodeBefore_internal(_next, new LinkedNode(item));
            _next = _next.left;
        }
        // at end or empty list
        else {
            
            cast((_collection), LinkedList).addNodeBefore_internal(null, new LinkedNode(item));
            _next = _collection.lastNode_internal;
        }
    }

    public function replace(item : Dynamic) : Bool {
        if (_current == null) {
            return false;
        }
        
        if (_current.item == item) {
            return false;
        }
        _current.item = item;
        return true;
    }

    override private function removeCurrent() : Void {
        cast((_collection), LinkedList).removeNode_internal(_current);
    }
}

