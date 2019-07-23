
package org.as3commons.collections.framework.core;

import org.as3commons.collections.iterators.ArrayIterator;
import org.as3commons.collections.framework.IListIterator;

class AbstractListIterator extends ArrayIterator implements IListIterator {

    private var _list : AbstractList;

    public function new(list : AbstractList, index : Int = 0) {
        _list = list;
        
        super(_list.array_internal, index);
    }

    override private function removeCurrent() : Void {
        _list.removeAt(_current);
    }
}

