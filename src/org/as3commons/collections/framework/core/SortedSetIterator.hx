package org.as3commons.collections.framework.core;

import org.as3commons.collections.framework.core.AbstractSortedCollectionIterator;
import org.as3commons.collections.framework.core.SortedNode;
import org.as3commons.collections.framework.ISetIterator;

class SortedSetIterator extends AbstractSortedCollectionIterator implements ISetIterator {
    public var previousItem(get, never) : Dynamic;
    public var nextItem(get, never) : Dynamic;

    public function new(sortedSet : SortedSet, next : SortedNode = null) {
        super(sortedSet, next);
    }

    private function get_previousItem() : Dynamic {
        if (_next != null) {
            var previous : SortedNode = _collection.previousNode_internal(_next);
            return (previous != null) ? previous.item : null;
        }
        else {
            return (_collection.size) ? _collection.mostRightNode_internal().item : null;
        }
    }

    private function get_nextItem() : Dynamic {
        return (_next != null) ? _next.item : null;
    }
}