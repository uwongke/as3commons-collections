package org.as3commons.collections.framework.core;

class TreapNode {

    public var item : Dynamic;

    public var parent : TreapNode;

    public var left : TreapNode;

    public var right : TreapNode;

    public var priority : Int;

    public function new(theItem : Dynamic, theParent : TreapNode = null) {
        item = theItem;
        parent = theParent;
        priority = as3hx.Compat.parseInt(Math.random() * as3hx.Compat.INT_MAX);
    }
}