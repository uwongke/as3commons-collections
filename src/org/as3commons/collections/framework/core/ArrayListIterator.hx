package org.as3commons.collections.framework.core;

import org.as3commons.collections.framework.core.AbstractListIterator;
import org.as3commons.collections.framework.IOrderedList;
import org.as3commons.collections.framework.IOrderedListIterator;

class ArrayListIterator extends AbstractListIterator implements IOrderedListIterator {
    private var _arrayList(get, never) : IOrderedList;

    public function new(list : ArrayList, index : Int = 0) {
        super(list, index);
    }

    public function addBefore(item : Dynamic) : Int {
        var index : Int;
        
        _current = -1;
        
        if (_next == -1) {
            index = _arrayList.size;
        }
        else {
            index = _next;
            _next++;
        }
        
        _arrayList.addAt(index, item);
        return index;
    }

    public function addAfter(item : Dynamic) : Int {
        _current = -1;
        
        var index : Int;
        
        if (_next == -1) {
            index = _arrayList.size;
            _next = index;
        }
        else {
            index = _next;
        }
        
        _arrayList.addAt(index, item);
        return index;
    }

    public function replace(item : Dynamic) : Bool {
        if (_current == -1) {
            return false;
        }
        
        return _arrayList.replaceAt(_current, item);
    }

    private function get__arrayList() : IOrderedList {
        return try cast(_list, IOrderedList) catch(e:Dynamic) null;
    }
}