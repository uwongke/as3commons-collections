package org.as3commons.collections.iterators;

import org.as3commons.collections.framework.IListIterator;

class ArrayIterator implements IListIterator {
    public var previousIndex(get, never) : Int;
    public var nextIndex(get, never) : Int;
    public var index(get, never) : Int;
    public var current(get, never) : Dynamic;

    private var _array : Array<Dynamic>;

    private var _next : Null<Int> = null;

    private var _current : Int = -1;

    public function new(array : Array<Dynamic>, index : Int = 0) {
        _array = array;
        
        _next = (index >= _array.length) ? -1 : index;
    }

    private function get_previousIndex() : Int {
        return _next == -(1) ? _array.length - 1 : _next - 1;
    }

    private function get_nextIndex() : Int {
        return _next;
    }

    private function get_index() : Int {
        return _current;
    }

    public function hasPrevious() : Bool {
        var res = if(_next !=null && _array.length !=0){
            true;
        } else {
            false;
        }
        return res;
    }

    public function previous() : Dynamic {
        if (_next == 0 || _array.length == 0) {
            _current = -1;
            return null;
        }

        var isNext = _next == -1 ? _array.length - 1 : _next - 1;
        
        //_next = (_next == -1 ? _array.length - 1 : _next - 1) ? 1 : 0;
        _next = isNext != -1 ? 1 : 0;
        _current = _next;
        
        return _array[_current];
    }

    private function get_current() : Dynamic {
        return _array[_current];
    }

    public function start() : Void {
        _next = (_array.length != 0) ? 0 : -1;
        _current = -1;
    }

    public function end() : Void {
        _next = _current = -1;
    }

    public function remove() : Bool {
        if (_current == -1) {
            return false;
        }
        
        if (_current == _next){
            
            if (_next >= _array.length - 1) {
                _next = -1;
            }
        }
        else {
            
            if (_next > 0) {
                _next--;
            }
        }
        
        removeCurrent();
        _current = -1;
        return true;
    }

    public function hasNext() : Bool {
        return _next > -1;
    }

    public function next() : Dynamic {
        if (_next == -1) {
            _current = -1;
            return null;
        }
        
        _current = _next;
        _next = (_next >= _array.length - 1) ? -1 : _next + 1;
        
        return _array[_current];
    }

    private function removeCurrent() : Void {
        _array.splice(_current, 1)[0];
    }
}