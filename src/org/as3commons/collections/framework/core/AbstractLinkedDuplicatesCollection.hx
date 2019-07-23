package org.as3commons.collections.framework.core;

import org.as3commons.collections.framework.IDuplicates;

class AbstractLinkedDuplicatesCollection extends AbstractLinkedCollection implements IDuplicates {
    public function count(item : Dynamic) : Int {
        var count : Int = 0;
        var node : LinkedNode = _first;
        while (node !=null) {
            if (node.item == item) {
                count++;
            }
            node = node.right;
        }
        return count;
    }

    public function removeAll(item : Dynamic) : Int {
        var size : Int = _size;
        var node : LinkedNode = _first;
        var right : LinkedNode;
        while (node !=null) {
            right = node.right;
            if (node.item == item) {
                removeNode(node);
            }
            node = right;
        }
        return as3hx.Compat.parseInt(size - _size);
    }

    public function new() {
        super();
    }
}

