package org.as3commons.collections.framework.core;

class LinkedMapNode extends LinkedNode {
    public var key : Dynamic;
    public function new(theKey : Dynamic, theItem : Dynamic) {
        key = theKey;
        super(theItem);
    }
}

