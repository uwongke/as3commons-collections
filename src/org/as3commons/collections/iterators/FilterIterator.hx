package org.as3commons.collections.iterators;

import haxe.Constraints.Function;
import org.as3commons.collections.framework.IIterable;
import org.as3commons.collections.framework.IIterator;

@:final class FilterIterator implements IIterator {

    private var _iterator : IIterator;

    private var _next : Dynamic;

    private var _filter : Function;

    public function new(iterable : IIterable, filter : Function) {
        _iterator = iterable.iterator();
        _filter = (filter != null) ? filter : nullFilter;
    }

    public function hasNext() : Bool {
        if (_next != null) {
            return true;
        }
        
        var next : Dynamic;
        while (_iterator.hasNext()) {
            next = _iterator.next();
            if (_filter(next)) {
                _next = next;
                return true;
            }
        }
        return false;
    }

    public function next() : Dynamic {
        if (_next == null && !hasNext()) {
            return null;
        }
        
        var current : Dynamic = _next;
        _next = null;
        return current;
    }

    private function nullFilter(item : Dynamic) : Bool {
        return true;
    }
}