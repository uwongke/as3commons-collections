
package org.as3commons.collections;

import org.as3commons.collections.framework.core.AbstractLinkedDuplicatesCollection;
import org.as3commons.collections.framework.core.LinkedListIterator;
import org.as3commons.collections.framework.core.LinkedNode;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.ILinkedList;

class LinkedList extends AbstractLinkedDuplicatesCollection implements ILinkedList {

    public function new() {
        super();
    }

    public function add(item : Dynamic) : Void {
        addNodeLast(new LinkedNode(item));
    }

    public function addFirst(item : Dynamic) : Void {
        addNodeFirst(new LinkedNode(item));
    }

    public function addLast(item : Dynamic) : Void {
        addNodeLast(new LinkedNode(item));
    }

    override public function iterator(cursor : Dynamic = null) : IIterator {
        return new LinkedListIterator(this);
    }

    public function removeNode_internal(node : LinkedNode) : Void {
        removeNode(node);
    }

    public function addNodeBefore_internal(next : LinkedNode, node : LinkedNode) : Void {
        addNodeBefore(next, node);
    }
}