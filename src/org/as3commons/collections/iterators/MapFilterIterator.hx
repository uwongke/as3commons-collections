package org.as3commons.collections.iterators;

import haxe.Constraints.Function;
import org.as3commons.collections.framework.IBasicMapIterator;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.IMap;

@:final class MapFilterIterator implements IBasicMapIterator {
    public var key(get, never) : Dynamic;

    private var _map : IMap;

    private var _iterator : IIterator;

    private var _nextKey : Dynamic;

    private var _currentKey : Dynamic;

    private var _keyFilter : Function;

    private var _itemFilter : Function;

    public function new(map : IMap, keyFilter : Function, itemFilter : Function = null) {
        _map = map;
        _iterator = map.keyIterator();
        
        _keyFilter = (keyFilter != null) ? keyFilter : nullFilter;
        _itemFilter = (itemFilter != null) ? itemFilter : nullFilter;
    }

    public function hasNext() : Bool {
        if (_nextKey != null) {
            return true;
        }
        
        var nextKey : Dynamic;
        var next : Dynamic;
        while (_iterator.hasNext()) {
            nextKey = _iterator.next();
            next = _map.itemFor(nextKey);
            
            if (_keyFilter(nextKey) && _itemFilter(next)) {
                _nextKey = nextKey;
                return true;
            }
        }
        return false;
    }

    public function next() : Dynamic {
        if (_nextKey == null && !hasNext()) {
            _currentKey = null;
            return null;
        }
        
        _currentKey = _nextKey;
        _nextKey = null;
        return _map.itemFor(_currentKey);
    }

    private function get_key() : Dynamic {
        return _currentKey;
    }

    private function nullFilter(key : Dynamic) : Bool {
        return true;
    }
}