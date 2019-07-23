package org.as3commons.collections.iterators;

import openfl.errors.ArgumentError;
import haxe.Constraints.Function;
import org.as3commons.collections.framework.ICollection;
import org.as3commons.collections.framework.ICollectionIterator;

@:final class CollectionFilterIterator implements ICollectionIterator {
    public var current(get, never) : Dynamic;

    private var _iterator : ICollectionIterator;

    private var _current : Dynamic;

    private var _previous : Dynamic;

    private var _next : Dynamic;

    private var _filter : Function;

    private var _lastLookUp : String;

    public function new(collection : ICollection, filter : Function) {
        _iterator = try cast(collection.iterator(), ICollectionIterator) catch(e:Dynamic) null;
        
        if (_iterator == null) {
            throw new ArgumentError("The iterator of the given collection is not an ICollectionIterator instance.");
        }
        
        _filter = (filter != null) ? filter : nullFilter;
    }

    public function hasNext() : Bool {
        if (_next != null) {
            return true;
        }
        
        var next : Dynamic;
        _lastLookUp = "next";
        while (_iterator.hasNext()) {
            next = _iterator.next();
            if (_filter(next)) {
                _next = next;
                _iterator.previous();
                return true;
            }
        }
        return false;
    }

    public function next() : Dynamic {
        if (_next == null && !hasNext()) {
            _current = null;
            return null;
        }
        
        rewindForward(_next);
        
        _current = _next;
        _previous = _current;
        _next = null;
        return _current;
    }

    public function start() : Void {
        _iterator.start();
        _next = _previous = _current = null;
    }

    public function end() : Void {
        _iterator.end();
        _next = _previous = _current = null;
    }

    public function hasPrevious() : Bool {
        if (_previous != null) {
            return true;
        }
        
        var previous : Dynamic;
        _lastLookUp = "previous";
        while (_iterator.hasPrevious()) {
            previous = _iterator.previous();
            if (_filter(previous)) {
                _previous = previous;
                _iterator.next();
                return true;
            }
        }
        return false;
    }

    public function previous() : Dynamic {
        if (_previous == null && !hasPrevious()) {
            _current = null;
            return null;
        }
        
        rewindBackward(_previous);
        
        _current = _previous;
        _next = _current;
        _previous = null;
        return _current;
    }

    private function get_current() : Dynamic {
        return _current;
    }

    public function remove() : Bool {
        if (_current == null) {
            return false;
        }
        
        if (_lastLookUp == "next") {
            rewindBackward(_current);
            _iterator.next();
        }
        else if (_lastLookUp == "previous") {
            rewindForward(_current);
            _iterator.previous();
        }
        
        _iterator.remove();
        _next = _previous = _current = null;
        return true;
    }

    private function rewindForward(item : Dynamic) : Void {
        _lastLookUp = "";
        while (_iterator.hasNext()) {
            _iterator.next();
            if (item == _iterator.current) {
                return;
            }
        }
    }

    private function rewindBackward(item : Dynamic) : Void {
        _lastLookUp = "";
        while (_iterator.hasPrevious()) {
            _iterator.previous();
            if (item == _iterator.current) {
                return;
            }
        }
    }

    private function nullFilter(item : Dynamic) : Bool {
        return true;
    }
}