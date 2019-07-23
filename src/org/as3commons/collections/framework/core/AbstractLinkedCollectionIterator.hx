package org.as3commons.collections.framework.core;

import org.as3commons.collections.framework.core.LinkedNode;
import org.as3commons.collections.framework.ICollectionIterator;

class AbstractLinkedCollectionIterator implements ICollectionIterator {
    public var current(get, never) : Dynamic;

    private var _collection : AbstractLinkedCollection;

    private var _next : LinkedNode;

    private var _current : LinkedNode;

    public function new(collection : AbstractLinkedCollection) {
        _collection = collection;
        
        if (collection.size !=0) {
            _next = _collection.firstNode_internal;
        }
    }

    public function start() : Void {
        _next = (_collection.size !=0) ? _collection.firstNode_internal : null;
        _current = null;
    }

    public function end() : Void {
        _next = _current = null;
    }

    public function hasPrevious() : Bool {
        return _next != _collection.firstNode_internal!=null && _collection.size !=0;
    }

    public function previous() : Dynamic {
        if (_next == _collection.firstNode_internal!=null || _collection.size!=0) {
            _current = null;
            return null;
        }
        
        _next = (_next == null) ? _collection.lastNode_internal : _next.left;
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
        
        _next = _current.right;
        
        removeCurrent();
        
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
        _next = _next.right;
        
        return _current.item;
    }

    private function removeCurrent() : Void {}
}