package org.as3commons.collections.utils;

import haxe.Constraints.Function;
import flexunit.framework.TestCase;
import org.as3commons.collections.LinkedList;
import org.as3commons.collections.framework.ILinkedList;
import org.as3commons.collections.framework.IMap;
import org.as3commons.collections.testhelpers.CollectionTest;

class LinkedListsTest extends TestCase
{
    
    private var list : ILinkedList;
    
    override public function setUp() : Void
    {
        list = new LinkedList();
    }
    
    /*
		 * Creation
		 */
    
    public function test_newLinkedList() : Void
    {
        var map : IMap = Maps.newMap(5, 5);
        var a : Array<Dynamic> = [3, 3];
        
        // list of items to add
        
        var list : LinkedList = LinkedLists.newLinkedList(2, Args.from(map), 1, 1, Args.from(a));
        assertTrue(Std.is(list, LinkedList));
        assertEquals(6, list.size);
        assertTrue(CollectionTest.itemsEqual(list, [2, 5, 1, 1, 3, 3]));
        
        // no item
        
        list = LinkedLists.newLinkedList();
        assertTrue(Std.is(list, LinkedList));
        assertEquals(0, list.size);
        assertTrue(CollectionTest.itemsEqual(list, []));
    }
    
    /*
		 * Clone
		 */
    
    public function test_clone_returnsCopy() : Void
    {
        list.add(1);
        list.add(2);
        
        var filter : Function = function(key : Int) : Bool
        {
            return (key % 2 == 0);
        }
        
        // no filter
        
        var clone : ILinkedList = LinkedLists.clone(list);
        assertTrue(list != clone);
        
        // only item filter
        
        clone = LinkedLists.clone(list, filter);
        assertTrue(list != clone);
        
        // both filters
        
        clone = LinkedLists.clone(list, filter);
        assertTrue(list != clone);
    }
    
    public function test_clone_filters() : Void
    {
        list.add(1);
        list.add(2);
        list.add(3);
        list.add(4);
        list.add(5);
        list.add(6);
        list.add(7);
        list.add(8);
        list.add(9);
        list.add(10);
        list.add(11);
        list.add(12);
        
        var filter : Function = function(key : Int) : Bool
        {
            return (key % 2 == 0);
        }
        
        // no filter
        
        var clone : ILinkedList = LinkedLists.clone(list);
        assertEquals(12, clone.size);
        assertEquals(Type.getClassName(list), Type.getClassName(clone));
        assertTrue(CollectionTest.itemsEqual(clone, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]));
        
        // filter
        
        clone = LinkedLists.clone(list, filter);
        assertEquals(6, clone.size);
        assertEquals(Type.getClassName(list), Type.getClassName(clone));
        assertTrue(CollectionTest.itemsEqual(clone, [2, 4, 6, 8, 10, 12]));
    }
    
    public function test_clone_type_and_order() : Void
    {
        list = new LinkedList();
        list.add(3);
        list.add(2);
        list.add(4);
        list.add(1);
        
        var clone : ILinkedList = LinkedLists.clone(list);
        assertTrue(Std.is(clone, LinkedList));
        assertTrue(CollectionTest.itemsEqual(clone, [3, 2, 4, 1]));
    }
    
    public function test_copy() : Void
    {
        list.add(1);
        list.add(2);
        list.add(3);
        list.add(4);
        list.add(5);
        list.add(6);
        list.add(7);
        list.add(8);
        list.add(9);
        list.add(10);
        list.add(11);
        list.add(12);
        
        var filter : Function = function(key : Int) : Bool
        {
            return (key % 2 == 0);
        }
        
        // no filter
        
        var destination : ILinkedList = new LinkedList();
        LinkedLists.copy(list, destination);
        assertEquals(12, destination.size);
        assertEquals(Type.getClassName(list), Type.getClassName(destination));
        assertTrue(CollectionTest.itemsEqual(destination, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]));
        
        // filter
        
        destination = new LinkedList();
        LinkedLists.copy(list, destination, filter);
        assertEquals(6, destination.size);
        assertEquals(Type.getClassName(list), Type.getClassName(destination));
        assertTrue(CollectionTest.itemsEqual(destination, [2, 4, 6, 8, 10, 12]));
    }
    
    /*
		 * Population
		 */
    
    // from array
    
    public function test_addFromArray() : Void
    // even number of arguments
    {
        
        
        var list : ILinkedList = new LinkedList();
        var numItems : Int = LinkedLists.addFromArray(list, [1, 2, 3, 4, 5]);
        assertEquals(5, numItems);
        assertEquals(5, list.size);
        assertTrue(CollectionTest.itemsEqual(list, [1, 2, 3, 4, 5]));
        
        // no argument
        
        list = new LinkedList();
        numItems = LinkedLists.addFromArray(list, []);
        assertEquals(0, numItems);
        assertEquals(0, list.size);
        assertTrue(CollectionTest.itemsEqual(list, []));
    }
    
    public function test_addFromArray_null() : Void
    {
        var list : LinkedList = new LinkedList();
        var numItems : Int = LinkedLists.addFromArray(list, null);
        assertEquals(0, numItems);
        assertEquals(0, list.size);
        assertTrue(CollectionTest.itemsEqual(list, []));
    }
    
    public function test_addFromArray_entries_kept() : Void
    {
        var list : LinkedList = new LinkedList();
        list.add(1);
        
        var source : Array<Dynamic> = [2, 3];
        
        var numItems : Int = LinkedLists.addFromArray(list, source);
        assertEquals(2, numItems);
        assertEquals(3, list.size);
        assertTrue(CollectionTest.itemsEqual(list, [1, 2, 3]));
    }
    
    public function test_addFromArray_mixed_array() : Void
    {
        var sourceList : LinkedList = new LinkedList();
        sourceList.add(2);
        sourceList.add(3);
        sourceList.add(4);
        
        var sourceMap : IMap = Maps.newLinkedMap(6, 6, 7, 7);
        var sourceArray : Array<Dynamic> = [8, 8];
        
        var source : Array<Dynamic> = [
        1, 1, 
        Args.from(sourceList), 
        5, 5, 
        Args.from(sourceMap), 
        Args.from(sourceArray), 
        9, 9
    ];
        
        var list : LinkedList = new LinkedList();
        var numItems : Int = LinkedLists.addFromArray(list, source);
        
        assertEquals(13, numItems);
        assertEquals(13, list.size);
        assertTrue(CollectionTest.itemsEqual(list, [1, 1, 2, 3, 4, 5, 5, 6, 7, 8, 8, 9, 9]));
    }
    
    // from collection
    
    public function test_addFromCollection() : Void
    {
        var source : LinkedList = new LinkedList();
        source.add(1);
        source.add(2);
        
        var list : LinkedList = new LinkedList();
        var numItems : Int = LinkedLists.addFromCollection(list, source);
        
        assertEquals(2, numItems);
        assertEquals(2, list.size);
        assertTrue(CollectionTest.itemsEqual(list, [1, 2]));
    }
    
    public function test_addFromCollection_null() : Void
    {
        var list : LinkedList = new LinkedList();
        var numItems : Int = LinkedLists.addFromCollection(list, null);
        assertEquals(0, numItems);
        assertEquals(0, list.size);
        assertTrue(CollectionTest.itemsEqual(list, []));
    }
    
    public function test_addFromCollection_entries_kept() : Void
    {
        var list : LinkedList = new LinkedList();
        list.add(1);
        
        var source : LinkedList = new LinkedList();
        source.add(2);
        
        var numItems : Int = LinkedLists.addFromCollection(list, source);
        
        assertEquals(1, numItems);
        assertEquals(2, list.size);
        assertTrue(CollectionTest.itemsEqual(list, [1, 2]));
    }
    
    // from args
    
    public function test_addFromArgs() : Void
    // even number of arguments
    {
        
        
        var list : ILinkedList = new LinkedList();
        LinkedLists.addFromArgs(list, 1, 2, 3, 4, 5);
        assertTrue(CollectionTest.itemsEqual(list, [1, 2, 3, 4, 5]));
        
        // no argument
        
        list = new LinkedList();
        LinkedLists.addFromArgs(list);
        assertTrue(CollectionTest.itemsEqual(list, []));
    }

    public function new()
    {
        super();
    }
}


