package org.as3commons.collections.framework.core;

import org.as3commons.collections.framework.ICollectionIterator;

class AbstractSortedCollectionIterator implements ICollectionIterator {
    public var current(get, never) : Dynamic;

    private var _collection : AbstractSortedCollection;

    private var _next : SortedNode;

    private var _current : SortedNode;

    public function new(collection : AbstractSortedCollection, next : SortedNode = null) {
        _collection = collection;
        
        if (next != null) {
            _next = next;
        }
        else if (collection.size) {
            _next = _collection.mostLeftNode_internal();
        }
    }

    public function start() : Void {
        _next = (_collection.size) ? _collection.mostLeftNode_internal() : null;
        _current = null;
    }

    public function end() : Void {
        _next = _current = null;
    }

    public function hasPrevious() : Bool {
        return _next != _collection.mostLeftNode_internal() && _collection.size;
    }

    public function previous() : Dynamic {
        if (_next == _collection.mostLeftNode_internal() || !_collection.size) {
            _current = null;
            return null;
        }
        
        _next = (_next == null) ? _collection.mostRightNode_internal() : _collection.previousNode_internal(_next);
        _current = _next;
        
        return _current.item;
    }

    private function get_current() : Dynamic {
        if (_current == null) {
            return null;
        }
        return _current.item;
    }

    public function remove() : Bool {
        if (_current == null) {
            return false;
        }
        
        _next = _collection.nextNode_internal(_current);
        _collection.removeNode_internal(_current);
        _current = null;
        return true;
    }

    public function hasNext() : Bool {
        return _next != null;
    }

    public function next() : Dynamic {
        if (_next == null) {
            _current = null;
            return null;
        }
        
        _current = _next;
        _next = _collection.nextNode_internal(_next);
        
        return _current.item;
    }
}