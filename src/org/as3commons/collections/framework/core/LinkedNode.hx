
package org.as3commons.collections.framework.core;

class LinkedNode {
    public var item(get, set) : Dynamic;

    private var _item : Dynamic;

    public var left : LinkedNode;

    public var right : LinkedNode;

    public function new(theItem : Dynamic) {
        _item = theItem;
    }

    private function set_item(item : Dynamic) : Dynamic {
        _item = item;
        return item;
    }

    private function get_item() : Dynamic {
        return _item;
    }
}