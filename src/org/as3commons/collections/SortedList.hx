
package org.as3commons.collections;

import org.as3commons.collections.utils.ArrayUtils;
import openfl.errors.ArgumentError;
import org.as3commons.collections.framework.core.AbstractList;
import org.as3commons.collections.framework.IComparator;
import org.as3commons.collections.framework.ISortedList;
import org.as3commons.collections.utils.NullComparator;

class SortedList extends AbstractList implements ISortedList {

    public var comparator(get, set) : IComparator;

    private var _comparator : IComparator;

    public function new(comparator : IComparator = null) {
        super();
        _comparator = (comparator != null) ? comparator : new NullComparator();
    }

    public function lesserIndex(item : Dynamic) : Int {
        var index : Int = firstIndexOfEqual(item);
        
        if (index > -1) {
            
            return (index != 0) ? index - 1 : -1;
        }
        else if (index == -1) {
            
            return -1;
        }
        // first equal item should be added after start
        else {
            
            return as3hx.Compat.parseInt((-index - 1) - 1);
        }
    }

    public function higherIndex(item : Dynamic) : Int {
        var index : Int = lastIndexOfEqual(item);
        
        if (index > -1) {
            
            index++;
        }
        // last equal item should be added there
        else {
            
            index = as3hx.Compat.parseInt(-index - 1);
        }
        
        return (index == _array.length) ? -1 : index;
    }

    public function equalIndices(item : Dynamic) : Array<Dynamic> {
        var indices : Array<Dynamic> = new Array<Dynamic>();
        var firstIndex : Int = firstIndexOfEqual(item);
        if (firstIndex < 0) {
            return indices;
        }
        
        indices.push(firstIndex);
        var size : Int = _array.length;
        for (i in firstIndex + 1...size) {
            if (_comparator.compare(item, _array[i])) {
                break;
            }
            indices.push(i);
        }
        return indices;
    }

    private function set_comparator(comparator : IComparator) : IComparator {
        if (_array.length) {
            throw new ArgumentError("You cannot set a comparator to a collection with size > 0");
        }
        _comparator = comparator;
        return comparator;
    }

    private function get_comparator() : IComparator {
        return _comparator;
    }

    public function hasEqual(item : Dynamic) : Bool {
        if (firstIndexOfEqual(item) < 0) {
            return false;
        }
        return true;
    }

    override private function set_array(array : Array<Dynamic>) : Array<Dynamic> {
        _array = array.copy();
        ArrayUtils.mergeSort(_array, _comparator);
        return array;
    }

    override public function add(item : Dynamic) : Int {
        if (!_array.length) {
            _comparator.compare(item, item);
        }  // type check, should throw an error if not passed  
        
        var index : Int = lastIndexOfEqual(item);
        if (index > -1) {
            index++;
        }
        else {
            index = as3hx.Compat.parseInt(-index - 1);
        }
        _array.splice(index, 0, item);
        return index;
    }

    override public function count(item : Dynamic) : Int {
        var count : Int = 0;
        var firstIndex : Int = firstIndexOfEqual(item);
        if (firstIndex < 0) {
            return 0;
        }
        
        var i : Int;
        var size : Int = _array.length;
        for (i in firstIndex...size) {
            if (_comparator.compare(item, _array[i])) {
                break;
            }
            if (item == _array[i]) {
                count++;
            }
        }
        return count;
    }

    override public function firstIndexOf(item : Dynamic) : Int {
        var firstIndex : Int = firstIndexOfEqual(item);
        if (firstIndex < 0) {
            return -1;
        }
        
        if (item == _array[firstIndex]) {
            return firstIndex;
        }
        var size : Int = _array.length;
        for (i in firstIndex + 1...size) {
            if (_comparator.compare(item, _array[i])) {
                break;
            }
            if (item == _array[i]) {
                return i;
            }
        }
        return -1;
    }

    override public function lastIndexOf(item : Dynamic) : Int {
        var lastIndex : Int = lastIndexOfEqual(item);
        if (lastIndex < 0) {
            return -1;
        }
        
        if (item == _array[lastIndex]) {
            return lastIndex;
        }
        var i : Int = as3hx.Compat.parseInt(lastIndex - 1);
        while (i >= 0) {
            if (_comparator.compare(item, _array[i])) {
                break;
            }
            if (item == _array[i]) {
                return i;
            }
            i--;
        }
        return -1;
    }

    override public function removeAll(item : Dynamic) : Int {
        var firstIndex : Int = firstIndexOfEqual(item);
        if (firstIndex < 0) {
            return 0;
        }
        
        var numItems : Int = _array.length;
        var size : Int = _array.length;
        for (i in firstIndex...size) {
            if (_comparator.compare(item, _array[i])) {
                break;
            }
            
            if (item == _array[i]) {
                _array.splice(i, 1);
                
                itemRemoved(i, item);  // notify subclasses  
                
                i--;
                size--;
            }
        }
        return as3hx.Compat.parseInt(numItems - _array.length);
    }

    override public function has(item : Dynamic) : Bool {
        var firstIndex : Int = firstIndexOfEqual(item);
        if (firstIndex < 0) {
            return false;
        }
        
        if (item == _array[firstIndex]) {
            return true;
        }
        var size : Int = _array.length;
        for (i in firstIndex + 1...size) {
            if (_comparator.compare(item, _array[i])) {
                break;
            }
            if (item == _array[i]) {
                return true;
            }
        }
        return false;
    }

    override public function remove(item : Dynamic) : Bool {
        var firstIndex : Int = firstIndexOfEqual(item);
        if (firstIndex < 0) {
            return false;
        }
        
        var i : Int;
        var size : Int = _array.length;
        for (i in firstIndex...size) {
            if (_comparator.compare(item, _array[i])) {
                break;
            }
            if (_array[i] == item) {
                _array.splice(i, 1);
                
                itemRemoved(i, item);  // notify subclasses  
                
                return true;
            }
        }
        return false;
    }

    private function firstIndexOfEqual(item : Dynamic) : Int {
        var start : Int = 0;
        var end : Int = as3hx.Compat.parseInt(_array.length - 1);  // end may become negative  
        var cursor : Int;
        var match : Bool = false;
        while (start <= end) {
            cursor = as3hx.Compat.parseInt((end + start) / 2);
            switch (_comparator.compare(item, _array[cursor])) {
                case 0:
                    if (cursor == start) {
                        return cursor;
                    }
                    match = true;
                    end = as3hx.Compat.parseInt(cursor - 1);
                case -1:  // array at cursor greater than item  
                    if (cursor == start) {
                        return -1 - cursor;
                    }
                    end = as3hx.Compat.parseInt(cursor - 1);
                case 1:  // array at cursor lesser than item  
                    if (cursor == end) {
                        if (match) {
                            return cursor + 1;
                        }
                        return -1 - (cursor + 1);
                    }
                    start = as3hx.Compat.parseInt(cursor + 1);
            }
        }
        return -1;
    }

    private function lastIndexOfEqual(item : Dynamic) : Int {
        var start : Int = 0;
        var end : Int = as3hx.Compat.parseInt(_array.length - 1);  // end may become negative  
        var cursor : Int;
        var match : Bool = false;
        while (start <= end) {
            cursor = as3hx.Compat.parseInt((end + start) / 2);
            switch (_comparator.compare(item, _array[cursor])) {
                case 0:
                    if (cursor == end) {
                        return cursor;
                    }
                    match = true;
                    start = as3hx.Compat.parseInt(cursor + 1);
                case -1:  // array at cursor greater than item  
                    if (cursor == start) {
                        if (match) {
                            return cursor - 1;
                        }
                        return -1 - cursor;
                    }
                    end = as3hx.Compat.parseInt(cursor - 1);
                case 1:  // array at cursor lesser than item  
                    if (cursor == end) {
                        return -1 - (cursor + 1);
                    }
                    start = as3hx.Compat.parseInt(cursor + 1);
            }
        }
        return -1;
    }
}