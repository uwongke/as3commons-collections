package org.as3commons.collections.iterators;

import org.as3commons.collections.framework.IIterable;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.IRecursiveIterator;

@:final class RecursiveIterator implements IRecursiveIterator {
    public var depth(get, never) : Int;

    private var _rootDepth : Int;

    private var _depth : Int;

    private var _iterator : IIterator;

    private var _childIterator : IRecursiveIterator;

    private var _parentItems : Array<Dynamic>;

    public function new(iterable : IIterable, depth : Int = 0, parentItems : Array<Dynamic> = null) {
        _rootDepth = depth;
        _depth = depth;
        
        _iterator = iterable.iterator();
        _parentItems = (parentItems != null) ? parentItems : new Array<Dynamic>(iterable);
    }

    private function get_depth() : Int {
        return _depth;
    }

    public function hasNext() : Bool {
        if (_childIterator != null) {
            if (_childIterator.hasNext()) {
                return true;
            }
            else {
                _childIterator = null;
                return hasNext();
            }
        }
        return _iterator.hasNext();
    }

    public function next() : Dynamic {
        var item : Dynamic;
        
        if (_childIterator != null && _childIterator.hasNext()) {
            item = _childIterator.next();
            _depth = _childIterator.depth;
            return item;
        }
        else {
            _childIterator = null;
        }
        
        item = _iterator.next();
        _depth = _rootDepth;  // cannot use _iterator.getDepth() as we have here an IIterator instance  
        
        if (Std.is(item, IIterable)) {
            if (Lambda.indexOf(_parentItems, item) < 0) {
                _childIterator = new RecursiveIterator(
                        item, 
                        _depth + 1, 
                        _parentItems.concat(item));
            }
        }
        
        return item;
    }
}