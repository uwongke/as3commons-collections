package org.as3commons.collections.framework.core;

import org.as3commons.collections.framework.IComparator;
import org.as3commons.collections.framework.IDuplicates;

class AbstractSortedDuplicatesCollection extends AbstractSortedCollection implements IDuplicates {

    public function new(comparator : IComparator) {
        super(comparator);
    }

    public function count(item : Dynamic) : Int {
        var node : SortedNode = firstEqualNode(item);
        if (node == null) {
            return 0;
        }
        
        var count : Int = 0;
        
        if (node.item == item) {
            count++;
        }
        node = nextNode_internal(node);
        while (node) {
            if (_comparator.compare(item, node.item)) {
                break;
            }
            if (node.item == item) {
                count++;
            }
            node = nextNode_internal(node);
        }
        
        return count;
    }

    public function removeAll(item : Dynamic) : Int {
        var node : SortedNode = firstEqualNode(item);
        if (node == null) {
            return 0;
        }
        
        var count : Int = 0;
        
        while (node) {
            if (_comparator.compare(item, node.item)) {
                break;
            }
            if (node.item == item) {
                var next : SortedNode = nextNode_internal(node);
                removeNode(node);
                node = next;
                count++;
            }
            else {
                node = nextNode_internal(node);
            }
        }
        
        return count;
    }
}

