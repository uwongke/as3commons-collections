
package org.as3commons.collections.framework.core;

class SortedMapNode extends SortedNode {

    public var key : Dynamic;

    public function new(theKey : Dynamic, theItem : Dynamic) {
        super(theItem);
        
        key = theKey;
    }
}