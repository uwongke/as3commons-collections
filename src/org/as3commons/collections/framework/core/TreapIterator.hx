package org.as3commons.collections.framework.core;

import org.as3commons.collections.framework.IBinarySearchTreeIterator;

class TreapIterator implements IBinarySearchTreeIterator {
    public var previousItem(get, never) : Dynamic;
    public var nextItem(get, never) : Dynamic;
    public var current(get, never) : Dynamic;

    private var _treap : Treap;

    private var _next : TreapNode;

    private var _current : TreapNode;

    public function new(treap : Treap, next : TreapNode) {
        _treap = treap;
        
        if (next != null) {
            _next = next;
        }
        else if (treap.size) {
            _next = _treap.mostLeftNode_internal();
        }
    }

    private function get_previousItem() : Dynamic {
        if (_next != null) {
            var previous : TreapNode = _treap.previousNode_internal(_next);
            return (previous != null) ? previous.item : null;
        }
        else {
            return (_treap.size) ? _treap.mostRightNode_internal().item : null;
        }
    }

    private function get_nextItem() : Dynamic {
        return (_next != null) ? _next.item : null;
    }

    public function start() : Void {
        _next = (_treap.size) ? _treap.mostLeftNode_internal() : null;
        _current = null;
    }

    public function end() : Void {
        _next = _current = null;
    }

    public function hasPrevious() : Bool {
        return _next != _treap.mostLeftNode_internal() && _treap.size;
    }

    public function previous() : Dynamic {
        if (_next == _treap.mostLeftNode_internal() || !_treap.size) {
            _current = null;
            return null;
        }
        
        _next = (_next == null) ? _treap.mostRightNode_internal() : _treap.previousNode_internal(_next);
        _current = _next;
        
        return (_current != null) ? _current.item : null;
    }

    private function get_current() : Dynamic {
        return (_current != null) ? _current.item : null;
    }

    public function remove() : Bool {
        if (_current == null) {
            return false;
        }
        
        _next = _treap.nextNode_internal(_current);
        _treap.removeNode_internal(_current);
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
        _next = _treap.nextNode_internal(_next);
        
        return (_current != null) ? _current.item : null;
    }
}