package org.as3commons.collections.framework.core;

import org.as3commons.collections.framework.core.AbstractSortedCollectionIterator;
import org.as3commons.collections.framework.IMapIterator;

class SortedMapIterator extends AbstractSortedCollectionIterator implements IMapIterator {
    public var previousKey(get, never) : Dynamic;
    public var nextKey(get, never) : Dynamic;
    public var key(get, never) : Dynamic;

    public function new(sortedMap : SortedMap, next : SortedMapNode) {
        super(sortedMap, next);
    }

    private function get_previousKey() : Dynamic {
        if (_next != null) {
            var previous : SortedMapNode = try cast(_collection.previousNode_internal(_next), SortedMapNode) catch(e:Dynamic) null;
            return (previous != null) ? previous.key : null;
        }
        else {
            return (_collection.size) ? cast((_collection.mostRightNode_internal()), SortedMapNode).key : null;
        }
    }

    private function get_nextKey() : Dynamic {
        return (_next != null) ? cast((_next), SortedMapNode).key : null;
    }

    private function get_key() : Dynamic {
        return (_current != null) ? cast((_current), SortedMapNode).key : null;
    }
}