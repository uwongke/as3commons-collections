package org.as3commons.collections.framework.core;

import org.as3commons.collections.framework.core.AbstractLinkedCollectionIterator;
import org.as3commons.collections.framework.IOrderedMapIterator;

class LinkedMapIterator extends AbstractLinkedCollectionIterator implements IOrderedMapIterator {
    public var previousKey(get, never) : Dynamic;
    public var nextKey(get, never) : Dynamic;
    public var key(get, never) : Dynamic;

    public function new(orderedMap : LinkedMap, next : LinkedMapNode = null) {
        super(orderedMap);
        
        if (next != null) {
            _next = next;
        }
    }

    public function addBefore(key : Dynamic, item : Dynamic) : Bool {
        if (_next != null) {
            if (!cast((_collection), LinkedMap).addBefore(cast((_next), LinkedMapNode).key, key, item)) {
                return false;
            }
        }
        else if (!cast((_collection), LinkedMap).addLast(key, item)) {
            return false;
        }
        _current = null;
        return true;
    }

    public function addAfter(key : Dynamic, item : Dynamic) : Bool {
        if (_next != null) {
            if (!cast((_collection), LinkedMap).addBefore(cast((_next), LinkedMapNode).key, key, item)) {
                return false;
            }
            _next = _next.left;
        }
        else {
            if (!cast((_collection), LinkedMap).add(key, item)) {
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
        
        return cast((_collection), LinkedMap).replaceFor(cast((_current), LinkedMapNode).key, item);
    }

    private function get_previousKey() : Dynamic {
        return (_next != null) ? (_next.left) ? cast((_next.left), LinkedMapNode).key : null : (_collection.size) ? cast((_collection.lastNode_internal), LinkedMapNode).key : null;
    }

    private function get_nextKey() : Dynamic {
        return (_next != null) ? cast((_next), LinkedMapNode).key : null;
    }

    private function get_key() : Dynamic {
        return (_current != null) ? cast((_current), LinkedMapNode).key : null;
    }

    override private function removeCurrent() : Void {
        cast((_collection), LinkedMap).removeKey(cast((_current), LinkedMapNode).key);
    }
}

