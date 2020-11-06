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
        priority = Math.floor(Math.random() * 0x3FFFFFFF);
        order = ++_order;
    }
}