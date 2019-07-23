package org.as3commons.collections.framework.core;

class SortedNode {

    public var item : Dynamic;

    public var parent : SortedNode;

    public var left : SortedNode;

    public var right : SortedNode;

    public var priority : Int;

    public var order : Int;

    private static var _order : Int = 0;

    public function new(theItem : Dynamic) {
        item = theItem;
        priority = as3hx.Compat.parseInt(Math.random() * as3hx.Compat.INT_MAX);
        order = ++_order;
    }
}