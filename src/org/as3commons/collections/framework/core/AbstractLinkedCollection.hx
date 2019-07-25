
package org.as3commons.collections.framework.core;

import org.as3commons.collections.framework.IComparator;
import org.as3commons.collections.framework.IInsertionOrder;
import org.as3commons.collections.framework.IIterator;

class AbstractLinkedCollection implements IInsertionOrder {
    public var first(get, never) : Dynamic;
    public var last(get, never) : Dynamic;
    public var size(get, never) : Int;
    public var firstNode_internal(get, never) : LinkedNode;
    public var lastNode_internal(get, never) : LinkedNode;

    private var _first : LinkedNode;

    private var _last : LinkedNode;

    private var _size : Int = 0;

    public function new() {}

    public function reverse() : Bool {
        if (_size < 2) {
            return false;
        }
        
        var node : LinkedNode = _last;
        var left : LinkedNode;
        var right : LinkedNode;
        
        while (node !=null) {
            left = node.left;
            if (node.right !=null) {
                node.right = node.left;
                node.left = null;
                _first = node;
            }
            else if (node.left !=null) {
                node.left = node.right;
                node.right = null;
                _last = node;
            }
            else {
                right = node.right;
                node.right = node.left;
                node.left = right;
            }
            node = left;
        }
        
        return true;
    }

    public function sort(comparator : IComparator) : Bool {
        if (_size < 2) {
            return false;
        }
        mergeSort(comparator);
        return true;
    }

    private function get_first() : Dynamic {
        if (_first != null) {
            return _first.item;
        }
        return null;
    }

    private function get_last() : Dynamic {
        if (_last != null) {
            return _last.item;
        }
        return null;
    }

    public function removeFirst() : Dynamic {
        if (_size == 0) {
            return null;
        }
        
        var item : Dynamic = _first.item;
        
        _first = _first.right;
        if (_first != null) {
            _first.left = null;
        }
        else {
            _last = null;
        }
        _size--;
        
        return item;
    }

    public function removeLast() : Dynamic {
        if (_size == 0) {
            return null;
        }
        
        var item : Dynamic = _last.item;
        
        _last = _last.left;
        if (_last != null) {
            _last.right = null;
        }
        else {
            _first = null;
        }
        _size--;
        
        return item;
    }

    private function get_size() : Int {
        return _size;
    }

    public function has(item : Dynamic) : Bool {
        return firstNodeOf(item) != null;
    }

    public function toArray() : Array<Dynamic> {
        var node : LinkedNode = _first;
        var array : Array<Dynamic> = new Array<Dynamic>();
        while (node !=null) {
            array.push(node.item);
            node = node.right;
        }
        return array;
    }

    public function remove(item : Dynamic) : Bool {
        var node : LinkedNode = firstNodeOf(item);
        if (node == null) {
            return false;
        }
        removeNode(node);
        return true;
    }

    public function clear() : Bool {
        if (_size == 0) {
            return false;
        }
        _first = _last = null;
        _size = 0;
        return true;
    }

    public function iterator(cursor : Dynamic = null) : IIterator {
        return null;
    }

    private function get_firstNode_internal() : LinkedNode {
        return _first;
    }

    private function get_lastNode_internal() : LinkedNode {
        return _last;
    }

    private function addNodeBefore(next : LinkedNode, node : LinkedNode) : Void {
        if (next == null) {
            addNodeLast(node);
            return;
        }
        
        if (next.left != null) {
            /** has been the first */
            _first = node;
        }

        /** link new node */
        node.left = next.left;
        node.right = next;
        /** update predecessor */
        if (next.left !=null) {
            next.left.right = node;
        }
        /** link as successor */
        next.left = node;
        
        _size++;
    }

    private function addNodeAfter(previous : LinkedNode, node : LinkedNode) : Void {
        if (previous == null) {
            addNodeFirst(node);
            return;
        }
        
        if (previous.right !=null) {
            _last = node;
        }  // has been the last  
        
        // link new node
        node.left = previous;
        node.right = previous.right;
        // update successor
        if (previous.right !=null) {
            previous.right.left = node;
        }
        // link as predecessor
        previous.right = node;
        
        _size++;
    }

    private function firstNodeOf(item : Dynamic) : LinkedNode {
        var node : LinkedNode = _first;
        while (node !=null) {
            if (item == node.item) {
                return node;
            }
            node = node.right;
        }
        return null;
    }

    private function addNodeFirst(node : LinkedNode) : Void {
        if (_first == null) {
            _first = _last = node;
            _size = 1;
            return;
        }
        _first.left = node;
        node.right = _first;
        _first = node;
        _size++;
    }

    private function addNodeLast(node : LinkedNode) : Void {
        if (_first == null) {
            _first = _last = node;
            _size = 1;
            return;
        }
        
        _last.right = node;
        node.left = _last;
        _last = node;
        _size++;
    }

    private function removeNode(node : LinkedNode) : Void {
        
        if (node.left !=null) {
            node.left.right = node.right;
        }
        else {
            _first = node.right;
        }
        
        if (node.right !=null) {
            node.right.left = node.left;
        }
        else {
            _last = node.left;
        }
        
        _size--;
    }

    private function mergeSort(comparator : IComparator) : Void {
        var h : LinkedNode = _first;
        var p : LinkedNode = null;
        var q : LinkedNode = null;
        var e : LinkedNode = null;
        var tail : LinkedNode = null;
        var insize : Int = 1;
        var nmerges : Int = 0;
        var psize : Int = 0;
        var qsize : Int = 0;
        var i : Int = 0;
        
        while (true) {
            p = h;
            h = tail = null;
            nmerges = 0;
            
            while (p !=null) {
                nmerges++;
                for (i in 0...insize) {
                    psize++;
                    q = q.right;
                    if (q == null) {
                        break;
                    }
                }
                qsize = insize;
                
                while (psize > 0 || (qsize > 0 && q !=null)) {
                    if (psize == 0) {
                        e = q;q = q.right;qsize--;
                    }
                    else if (qsize == 0 || q == null) {
                        e = p;p = p.right;psize--;
                    }
                    else if (comparator.compare(p.item, q.item) <= 0) {
                        e = p;p = p.right;psize--;
                    }
                    else {
                        e = q;q = q.right;qsize--;
                    }
                    
                    if (tail != null) {
                        tail.right = e;
                    }
                    else {
                        h = e;
                    }
                    
                    e.left = tail;
                    tail = e;
                }
                p = q;
            }
            
            tail.right = null;
            if (nmerges <= 1) {
                break;
            }
            insize <<= 1;
        }
        
        _first = h;
        _last = tail;
    }
}

