package org.as3commons.collections.framework.core;

import org.as3commons.collections.framework.core.AbstractListIterator;

class SortedListIterator extends AbstractListIterator {
    public function new(sortedList : SortedList, index : Int = 0) {
        super(sortedList, index);
    }
}