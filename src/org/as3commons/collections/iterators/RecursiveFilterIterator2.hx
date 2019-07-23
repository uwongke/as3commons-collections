package org.as3commons.collections.iterators;

import haxe.Constraints.Function;
import org.as3commons.collections.framework.IIterable;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.IRecursiveIterator;

@:final class RecursiveFilterIterator2 implements IRecursiveIterator {
    public var depth(get, never) : Int;

    private var _iterator : IIterator;

    private var _filter : Function;

    private var _childrenFilter : Function;

    private var _rootDepth : Int;

    private var _depth : Int;

    private var _childIterator : IRecursiveIterator;

    private var _parentItems : Array<Dynamic>;

    private var _next : Dynamic;

    public function new(
            iterable : IIterable,
            filter : Function,
            childrenFilter : Function,
            depth : Int = 0,
            parentItems : Array<Dynamic> = null) {
        _filter = (filter != null) ? filter : nullFilter;
        _childrenFilter = (childrenFilter != null) ? childrenFilter : nullFilter;
        
        _rootDepth = depth;
        _depth = depth;
        
        _iterator = iterable.iterator();
        _parentItems = (parentItems != null) ? parentItems : new Array<Dynamic>(iterable);
    }

    private function get_depth() : Int {
        return _depth;
    }

    public function hasNext() : Bool {
        if (_next != null) {
            return true;
        }
        
        var next : Dynamic;
        if (_childIterator != null) {
            if (_childIterator.hasNext()) {
                _next = _childIterator.next();
                return true;
            }
            _childIterator = null;
            return hasNext();
        }
        
        while (_iterator.hasNext()) {
            next = _iterator.next();
            if (_filter(next)) {
                _next = next;
            }
            if (Std.is(next, IIterable) && _childrenFilter(next)) {
                if (Lambda.indexOf(_parentItems, next) < 0) {
                    _childIterator = new RecursiveFilterIterator2(
                            next, 
                            _filter, 
                            _childrenFilter, 
                            _depth + 1, 
                            _parentItems.concat(next));
                    if (_next == null) {
                        return hasNext();
                    }
                }
            }
            
            if (_next != null) {
                return true;
            }
        }
        
        return false;
    }

    public function next() : Dynamic {
        if (_next == null && !hasNext()) {
            return null;
        }
        
        var next : Dynamic;
        
        if (_childIterator != null) {
            _depth = _childIterator.depth;
            next = _next;
            _next = null;
            return next;
        }
        
        _depth = _rootDepth;  // cannot use _iterator.getDepth() as we have here an IIterator instance  
        
        next = _next;
        _next = null;
        return next;
    }

    private function nullFilter(item : Dynamic) : Bool {
        return true;
    }
}