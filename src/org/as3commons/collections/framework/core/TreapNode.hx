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
        priority = Math.floor(Math.random() * 0x3FFFFFFF);
    }
}