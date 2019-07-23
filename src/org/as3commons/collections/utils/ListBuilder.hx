package org.as3commons.collections.utils;

import org.as3commons.collections.framework.IComparator;
import org.as3commons.collections.framework.IList;

class ListBuilder {

    private var _list : IList;

    public static function newArrayList() : ListBuilder {
        return new ListBuilder(new ArrayList());
    }

    public static function newSortedList(comparator : IComparator) : ListBuilder {
        return new ListBuilder(new SortedList(comparator));
    }

    public function new(underlyingList : IList) {
        _list = underlyingList;
    }

    public function add(item : Dynamic) : ListBuilder {
        _list.add(item);
        return this;
    }

    public function build() : IList {
        return _list;
    }
}