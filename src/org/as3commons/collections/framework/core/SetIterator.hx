package org.as3commons.collections.framework.core;

import org.as3commons.collections.framework.ISet;
import org.as3commons.collections.framework.ISetIterator;
import org.as3commons.collections.iterators.ArrayIterator;

class SetIterator extends ArrayIterator implements ISetIterator {
    public var previousItem(get, never) : Dynamic;
    public var nextItem(get, never) : Dynamic;

    private var _set : ISet;

    public function new(theSet : ISet) {
        _set = theSet;
        super(_set.toArray());
    }

    private function get_previousItem() : Dynamic {
        return _array[previousIndex];
    }

    private function get_nextItem() : Dynamic {
        return Reflect.field(_array, Std.string(_next));
    }

    override private function removeCurrent() : Void {
        _set.remove(super.current);
        super.removeCurrent();
    }
}