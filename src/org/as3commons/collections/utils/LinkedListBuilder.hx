package org.as3commons.collections.utils;

import org.as3commons.collections.framework.ILinkedList;

class LinkedListBuilder {

    private var _list : ILinkedList;

    public static function newLinkedList() : LinkedListBuilder {
        return new LinkedListBuilder(new LinkedList());
    }

    public function new(underlyingLinkedList : ILinkedList) {
        _list = underlyingLinkedList;
    }

    public function add(item : Dynamic) : LinkedListBuilder {
        _list.add(item);
        return this;
    }

    public function build() : ILinkedList {
        return _list;
    }
}