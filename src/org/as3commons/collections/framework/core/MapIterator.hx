package org.as3commons.collections.framework.core;

import org.as3commons.collections.framework.IMap;
import org.as3commons.collections.framework.IMapIterator;
import org.as3commons.collections.iterators.ArrayIterator;

class MapIterator extends ArrayIterator implements IMapIterator {
    public var previousKey(get, never) : Dynamic;
    public var nextKey(get, never) : Dynamic;
    public var key(get, never) : Dynamic;

    private var _map : IMap;

    public function new(map : IMap) {
        _map = map;
        super(_map.keysToArray());
    }

    private function get_previousKey() : Dynamic {
        return _array[previousIndex];
    }

    private function get_nextKey() : Dynamic {
        return Reflect.field(_array, Std.string(_next));
    }

    private function get_key() : Dynamic {
        return super.current;
    }

    override public function previous() : Dynamic {
        return _map.itemFor(super.previous());
    }

    override private function get_current() : Dynamic {
        return _map.itemFor(super.current);
    }

    override public function next() : Dynamic {
        return _map.itemFor(super.next());
    }

    override private function removeCurrent() : Void {
        _map.removeKey(super.current);
        super.removeCurrent();
    }
}