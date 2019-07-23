
package org.as3commons.collections;

import flash.errors.ArgumentError;
import org.as3commons.collections.framework.core.TreapIterator;
import org.as3commons.collections.framework.core.TreapNode;
import org.as3commons.collections.framework.IBinarySearchTree;
import org.as3commons.collections.framework.IComparator;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.utils.NullComparator;

class Treap implements IBinarySearchTree {
    public var comparator(get, set) : IComparator;
    public var first(get, never) : Dynamic;
    public var last(get, never) : Dynamic;
    public var size(get, never) : Int;

    private var _comparator : IComparator;

    private var _root : TreapNode;

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
        var node : TreapNode = getNode(item);
        return (node != null) ? true : false;
    }

    public function add(item : Dynamic) : Bool {
        return add_protected(item) != null;
    }

    public function lesser(item : Dynamic) : Dynamic {
        var node : TreapNode = lesserNode(item);
        if (node == null) {
            return null;
        }
        return node.item;
    }

    public function higher(item : Dynamic) : Dynamic {
        var node : TreapNode = higherNode(item);
        if (node == null) {
            return null;
        }
        return node.item;
    }

    public function equalItem(item : Dynamic) : Dynamic {
        var node : TreapNode = getNode(item);
        return (node != null) ? node.item : null;
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
        var node : TreapNode = mostLeftNode_internal();
        if (node == null) {
            return null;
        }
        removeNode(node);
        return node.item;
    }

    public function removeLast() : Dynamic {
        var node : TreapNode = mostRightNode_internal();
        if (node == null) {
            return null;
        }
        removeNode(node);
        return node.item;
    }

    public function has(item : Dynamic) : Bool {
        var node : TreapNode = getNode(item);
        return (node != null && node.item == item) ? true : false;
    }

    public function remove(item : Dynamic) : Bool {
        var node : TreapNode = getNode(item);
        if (node == null || node.item != item) {
            return false;
        }
        removeNode(node);
        return true;
    }

    public function clear() : Bool {
        if (_size == 0) {
            return false;
        }
        _root = null;
        _size = 0;
        return true;
    }

    public function toArray() : Array<Dynamic> {
        var array : Array<Dynamic> = new Array<Dynamic>();
        var iterator : IIterator = iterator();
        while (iterator.hasNext()) {
            array.push(iterator.next());
        }
        return array;
    }

    private function get_size() : Int {
        return _size;
    }

    public function iterator(cursor : Dynamic = null) : IIterator {
        var node : TreapNode = mostLeftNode_internal();
        if (cursor != null) {
            var i : Int = 0;
            while (node && i < cursor) {
                node = nextNode_internal(node);
                i++;
            }
        }
        return new TreapIterator(this, node);
    }

    private function mostLeftNode_internal(node : TreapNode = null) : TreapNode {
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

    private function mostRightNode_internal(node : TreapNode = null) : TreapNode {
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

    private function nextNode_internal(node : TreapNode) : TreapNode {
        if (node.right) {
            node = mostLeftNode_internal(node.right);
        }
        else {
            var parent : TreapNode = node.parent;
            while (parent && node == parent.right) {
                node = parent;
                parent = parent.parent;
            }
            node = parent;
        }
        return node;
    }

    private function previousNode_internal(node : TreapNode) : TreapNode {
        if (node.left) {
            node = mostRightNode_internal(node.left);
        }
        else {
            var parent : TreapNode = node.parent;
            while (parent && node == parent.left) {
                node = parent;
                parent = parent.parent;
            }
            node = parent;
        }
        return node;
    }

    private function removeNode_internal(node : TreapNode) : Void {
        removeNode(node);
    }

    private function add_protected(item : Dynamic) : TreapNode {
        
        
        if (_root == null) {
            _comparator.compare(item, item);  // type check, should throw an error if not passed  
            _root = new TreapNode(item, null);
            _size++;
            return _root;
        }
        
        // add node to tree
        
        var node : TreapNode = _root;
        while (node) {
            var compare : Int = _comparator.compare(item, node.item);
            if (compare == -1)  {
                
                if (node.left) {
                    node = node.left;
                    continue;
                }
                else {
                    node.left = new TreapNode(item, node);
                    node = node.left;
                    break;
                }
            }
            else if (compare == 1)  {
                
                if (node.right) {
                    node = node.right;
                    continue;
                }
                else {
                    node.right = new TreapNode(item, node);
                    node = node.right;
                    break;
                }
            }
            // add an item for an existing equality not permitted
            else {
                
                return null;
            }
        }
        
        // bubble up
        
        while (node.parent) {
            if (node.parent.priority >= node.priority) {
                break;
            }
            rotate(node.parent, node);
        }
        
        _size++;
        return node;
    }

    private function removeNode(node : TreapNode) : Void {
        
        
        var child : TreapNode;
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

    private function rotate(parent : TreapNode, child : TreapNode) : Void {
        var grandparent : TreapNode = parent.parent;
        
        var right : String = "right";  // rotate with right child  
        var left : String = "left";
        if (child == parent.left) {
            
            right = "left";
            left = "right";
        }
        
        // set left of child to be the new right of parent
        Reflect.setField(parent, right, Reflect.field(child, left));
        if (Reflect.field(child, left) != null) {
            cast((Reflect.field(child, left)), TreapNode).parent = parent;
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

    private function getNode(item : Dynamic) : TreapNode {
        var node : TreapNode = _root;
        
        while (node) {
            var compare : Int = _comparator.compare(item, node.item);
            if (compare == -1) {
                node = node.left;
            }
            else if (compare == 1) {
                node = node.right;
            }
            else {
                return node;
            }
        }
        
        return null;
    }

    private function lesserNode(item : Dynamic) : TreapNode {
        var node : TreapNode = _root;
        var lesser : TreapNode;
        
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

    private function higherNode(item : Dynamic) : TreapNode {
        var node : TreapNode = _root;
        var higher : TreapNode;
        
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