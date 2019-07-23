
package org.as3commons.collections;

import org.as3commons.collections.framework.core.AbstractList;
import org.as3commons.collections.framework.core.ArrayListIterator;
import org.as3commons.collections.framework.IComparator;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.IOrderedList;
import org.as3commons.collections.utils.ArrayUtils;

class ArrayList extends AbstractList implements IOrderedList {

    public function new() {
        super();
    }

    public function addFirst(item : Dynamic) : Void {
        _array.unshift(item);
    }

    public function addLast(item : Dynamic) : Void {
        _array.push(item);
    }

    public function addAt(index : Int, item : Dynamic) : Bool {
        if (index <= _array.length) {
            _array.splice(index, 0, item);
            return true;
        }
        else {
            return false;
        }
    }

    public function addAllAt(index : Int, items : Array<Dynamic>) : Bool {
        if (index <= _array.length) {
            _array = _array.slice(0, index).concat(items).concat(_array.slice(index));
            return true;
        }
        else {
            return false;
        }
    }

    public function replaceAt(index : Int, item : Dynamic) : Bool {
        if (index < _array.length) {
            if (_array[index] == item) {
                return false;
            }
            _array[index] = item;
            return true;
        }
        return false;
    }

    public function reverse() : Bool {
        if (_array.length < 2) {
            return false;
        }
        _array.reverse();
        return true;
    }

    public function sort(comparator : IComparator) : Bool {
        if (_array.length < 2) {
            return false;
        }
        ArrayUtils.mergeSort(_array, comparator);
        return true;
    }

    override public function iterator(cursor : Dynamic = null) : IIterator {
        var index : Int = (Std.is(cursor, Int)) ? cursor : 0;
        return new ArrayListIterator(this, index);
    }
}