package org.as3commons.collections.framework.core;

import org.as3commons.collections.framework.IDataProvider;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.IList;

class AbstractList implements IList implements IDataProvider {
    public var array(never, set) : Array<Dynamic>;
    public var first(get, never) : Dynamic;
    public var last(get, never) : Dynamic;
    public var size(get, never) : Int;
    private var array_internal(get, never) : Array<Dynamic>;

    private var _array : Array<Dynamic>;

    public function new() {
        _array = new Array<Dynamic>();
    }

    private function set_array(array : Array<Dynamic>) : Array<Dynamic> {
        _array = array.copy();
        return array;
    }

    public function add(item : Dynamic) : Int {
        _array.push(item);
        return as3hx.Compat.parseInt(_array.length - 1);
    }

    public function count(item : Dynamic) : Int {
        var count : Int = 0;
        var size : Int = _array.length;
        for (i in 0...size) {
            if (_array[i] == item) {
                count++;
            }
        }
        return count;
    }

    public function firstIndexOf(item : Dynamic) : Int {
        return Lambda.indexOf(_array, item);
    }

    public function lastIndexOf(item : Dynamic) : Int {
        var i : Int = as3hx.Compat.parseInt(_array.length - 1);
        while (i >= 0) {
            if (item == _array[i]) {
                return i;
            }
            i--;
        }
        return -1;
    }

    private function get_first() : Dynamic {
        return _array[0];
    }

    private function get_last() : Dynamic {
        return _array[_array.length - 1];
    }

    public function itemAt(index : Int) : Dynamic {
        return _array[index];
    }

    public function removeFirst() : Dynamic {
        return _array.shift();
    }

    public function removeLast() : Dynamic {
        return _array.pop();
    }

    public function removeAt(index : Int) : Dynamic {
        return _array.splice(index, 1)[0];
    }

    public function removeAllAt(index : Int, numItems : Int) : Array<Dynamic> {
        return _array.splice(index, numItems);
    }

    public function removeAll(item : Dynamic) : Int {
        var numItems : Int = _array.length;
        for (i in 0...numItems) {
            if (_array[i] == item) {
                _array.splice(i, 1);
                
                itemRemoved(i, item);  // notify subclasses  
                
                i--;
            }
        }
        return as3hx.Compat.parseInt(numItems - _array.length);
    }

    private function get_size() : Int {
        return _array.length;
    }

    public function has(item : Dynamic) : Bool {
        return firstIndexOf(item) > -1;
    }

    public function toArray() : Array<Dynamic> {
        return _array.copy();
    }

    public function remove(item : Dynamic) : Bool {
        var index : Int = Lambda.indexOf(_array, item);
        if (index == -1) {
            return false;
        }
        _array.splice(index, 1);
        
        itemRemoved(index, item);  // notify subclasses  
        
        return true;
    }

    public function clear() : Bool {
        if (!_array.length) {
            return false;
        }
        _array = new Array<Dynamic>();
        return true;
    }

    public function iterator(cursor : Dynamic = null) : IIterator {
        var index : Int = (Std.is(cursor, Int)) ? cursor : 0;
        return new AbstractListIterator(this, index);
    }

    private function get_array_internal() : Array<Dynamic> {
        return _array;
    }

    private function itemRemoved(index : Int, item : Dynamic) : Void {  // hook  
        
    }
}