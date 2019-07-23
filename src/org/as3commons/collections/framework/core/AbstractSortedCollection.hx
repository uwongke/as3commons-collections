package org.as3commons.collections.framework.core;

import flash.errors.ArgumentError;
import org.as3commons.collections.framework.IComparator;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.ISortOrder;
import org.as3commons.collections.utils.NullComparator;

class AbstractSortedCollection implements ISortOrder {
    public var comparator(get, set) : IComparator;
    public var first(get, never) : Dynamic;
    public var last(get, never) : Dynamic;
    public var size(get, never) : Int;

    private var _comparator : IComparator;

    private var _root : SortedNode;

    private var _size : Int = 0;

    public function new(comparator : IComparator = null) {
        _comparator = (comparator != null) ? comparator : new NullComparator();
    }

    private function set_comparator(comparator : IComparator) : IComparator {
        if (_size != 0) {
            throw new ArgumentError("You cannot set a comparator to a collection with size > 0");
        }
        _comparator = comparator;
        return comparator;
    }

    private function get_comparator() : IComparator {
        return _comparator;
    }

    public function hasEqual(item : Dynamic) : Bool {
        var node : SortedNode = _root;
        
        while (node) {
            var compare : Int = _comparator.compare(item, node.item);
            if (compare == -1) {
                node = node.left;
            }
            else if (compare == 1) {
                node = node.right;
            }
            else {
                return true;
            }
        }
        
        return false;
    }

    private function get_first() : Dynamic {
        if (_root == null) {
            return null;
        }
        return mostLeftNode_internal().item;
    }

    private function get_last() : Dynamic {
        if (_root == null) {
            return null;
        }
        return mostRightNode_internal().item;
    }

    public function removeFirst() : Dynamic {
        var node : SortedNode = mostLeftNode_internal();
        if (node == null) {
            return null;
        }
        removeNode(node);
        return node.item;
    }

    public function removeLast() : Dynamic {
        var node : SortedNode = mostRightNode_internal();
        if (node == null) {
            return null;
        }
        removeNode(node);
        return node.item;
    }

    private function get_size() : Int {
        return _size;
    }

    public function has(item : Dynamic) : Bool {
        var node : SortedNode = firstEqualNode(item);
        if (node == null) {
            return false;
        }
        
        if (node.item == item) {
            return true;
        }
        node = nextNode_internal(node);
        while (node) {
            if (_comparator.compare(item, node.item)) {
                break;
            }
            if (node.item == item) {
                return true;
            }
            node = nextNode_internal(node);
        }
        
        return false;
    }

    public function toArray() : Array<Dynamic> {
        var array : Array<Dynamic> = new Array<Dynamic>();
        
        var node : SortedNode = mostLeftNode_internal();
        
        while (node) {
            array.push(node.item);
            node = nextNode_internal(node);
        }
        
        return array;
    }

    public function remove(item : Dynamic) : Bool {
        var node : SortedNode = firstEqualNode(item);
        if (node == null) {
            return false;
        }
        
        if (node.item == item) {
            removeNode(node);
            return true;
        }
        node = nextNode_internal(node);
        while (node) {
            if (_comparator.compare(item, node.item)) {
                break;
            }
            if (node.item == item) {
                removeNode(node);
                return true;
            }
            node = nextNode_internal(node);
        }
        
        return false;
    }

    public function clear() : Bool {
        if (_size == 0) {
            return false;
        }
        _root = null;
        _size = 0;
        return true;
    }

    public function iterator(cursor : Dynamic = null) : IIterator {
        return null;
    }

    private function mostLeftNode_internal(node : SortedNode = null) : SortedNode {
        if (_root == null) {
            return null;
        }
        if (node == null) {
            node = _root;
        }
        while (node.left) {
            node = node.left;
        }
        return node;
    }

    private function mostRightNode_internal(node : SortedNode = null) : SortedNode {
        if (_root == null) {
            return null;
        }
        if (node == null) {
            node = _root;
        }
        while (node.right) {
            node = node.right;
        }
        return node;
    }

    private function nextNode_internal(node : SortedNode) : SortedNode {
        if (node.right) {
            node = mostLeftNode_internal(node.right);
        }
        else {
            var parent : SortedNode = node.parent;
            while (parent && node == parent.right) {
                node = parent;
                parent = parent.parent;
            }
            node = parent;
        }
        return node;
    }

    private function previousNode_internal(node : SortedNode) : SortedNode {
        if (node.left) {
            node = mostRightNode_internal(node.left);
        }
        else {
            var parent : SortedNode = node.parent;
            while (parent && node == parent.left) {
                node = parent;
                parent = parent.parent;
            }
            node = parent;
        }
        return node;
    }

    private function removeNode_internal(node : SortedNode) : Void {
        removeNode(node);
    }

    private function addNode(newNode : SortedNode) : Void {
        if (_root == null) {
            _comparator.compare(newNode.item, newNode.item);  // type check, should throw an error if not passed  
            _root = newNode;
            _size++;
            return;
        }
        
        // add node to tree
        
        var node : SortedNode = _root;
        while (node) {
            var compare : Int = _comparator.compare(newNode.item, node.item);
            if (compare == 0) {
                compare = (newNode.order < node.order) ? -1 : 1;
            }
            
            if (compare == -1){
                
                if (node.left) {
                    node = node.left;
                }
                else {
                    newNode.parent = node;
                    node.left = newNode;
                    node = node.left;
                    break;
                }
            }
            else if (compare == 1) 
            // add item in right branch{
                
                if (node.right) {
                    node = node.right;
                }
                else {
                    newNode.parent = node;
                    node.right = newNode;
                    node = node.right;
                    break;
                }

            else {
                
                return;
            }
        }
        

        while (node.parent) {
            if (node.parent.priority >= node.priority) {
                break;
            }
            rotate(node.parent, node);
        }
        
        _size++;
    }

    private function removeNode(node : SortedNode) : Void {
        var child : SortedNode;
        while (node.left || node.right) {
            if (node.left && node.right) {
                child = (node.left.priority < node.right.priority) ? node.left : node.right;
            }
            else if (node.left) {
                child = node.left;
            }
            else if (node.right) {
                child = node.right;
            }
            else {
                break;
            }
            rotate(node, child);
        }
        
        // remove node from tree
        
        if (node.parent) {
            if (node.parent.left == node) {
                node.parent.left = null;
            }
            else {
                node.parent.right = null;
            }
            node.parent = null;
        }
        else {
            _root = null;
        }
        
        _size--;
    }

    private function rotate(parent : SortedNode, child : SortedNode) : Void {
        var grandparent : SortedNode = parent.parent;
        
        var right : String = "right";  // rotate with right child  
        var left : String = "left";
        if (child == parent.left){
            
            right = "left";
            left = "right";
        }
        
        // set left of child to be the new right of parent
        Reflect.setField(parent, right, Reflect.field(child, left));
        if (Reflect.field(child, left) != null) {
            cast((Reflect.field(child, left)), SortedNode).parent = parent;
        }
        
        // set child as the new parent
        parent.parent = child;
        Reflect.setField(child, left, parent);
        
        // link grandparent to the child
        child.parent = grandparent;
        if (grandparent != null) {
            if (Reflect.field(grandparent, left) == parent) {
                Reflect.setField(grandparent, left, child);
            }
            else {
                Reflect.setField(grandparent, right, child);
            }
        }
        else {
            _root = child;
        }
    }

    private function firstEqualNode(item : Dynamic) : SortedNode {
        var node : SortedNode = _root;
        var firstEqual : SortedNode;
        
        while (node) {
            var compare : Int = _comparator.compare(item, node.item);
            if (compare == -1) {
                
                if (firstEqual != null) {
                    return firstEqual;
                }
                node = node.left;
            }
            else if (compare == 1) {
                
                node = node.right;
            }
            // item equals node
            else {
                
                firstEqual = node;
                node = node.left;
            }
        }
        
        return firstEqual;
    }

    private function lesserNode(item : Dynamic) : SortedNode {
        var node : SortedNode = _root;
        var lesser : SortedNode;
        
        while (node) {
            var compare : Int = _comparator.compare(item, node.item);
            if (compare == -1) {
                node = node.left;
            }
            else if (compare == 1) {
                lesser = node;
                node = node.right;
            }
            else {
                node = node.left;
            }
        }
        
        return lesser;
    }

    private function higherNode(item : Dynamic) : SortedNode {
        var node : SortedNode = _root;
        var higher : SortedNode;
        
        while (node) {
            var compare : Int = _comparator.compare(item, node.item);
            if (compare == -1) {
                higher = node;
                node = node.left;
            }
            else if (compare == 1) {
                node = node.right;
            }
            else {
                node = node.right;
            }
        }
        
        return higher;
    }
}