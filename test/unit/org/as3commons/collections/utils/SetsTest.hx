package org.as3commons.collections.utils;

import haxe.Constraints.Function;
import flexunit.framework.TestCase;
import org.as3commons.collections.LinkedSet;
import org.as3commons.collections.Set;
import org.as3commons.collections.SortedSet;
import org.as3commons.collections.framework.IMap;
import org.as3commons.collections.framework.ISet;
import org.as3commons.collections.testhelpers.CollectionTest;

class SetsTest extends TestCase
{
    
    private var theSet : ISet;
    
    override public function setUp() : Void
    {
        theSet = new LinkedSet();
    }
    
    /*
		 * Creation
		 */
    
    public function test_newSet() : Void
    {
        var map : IMap = Maps.newMap(5, 5);
        var a : Array<Dynamic> = [3, 3];
        
        // theSet of items to add
        
        var theSet : Set = Sets.newSet(2, Args.from(map), 1, 1, Args.from(a));
        assertTrue(Std.is(theSet, Set));
        assertEquals(4, theSet.size);
        assertTrue(CollectionTest.itemsMatch(theSet, [2, 5, 1, 3]));
        
        // no item
        
        theSet = Sets.newSet();
        assertTrue(Std.is(theSet, Set));
        assertEquals(0, theSet.size);
        assertTrue(CollectionTest.itemsEqual(theSet, []));
    }
    
    public function test_newLinkedSet() : Void
    {
        var map : IMap = Maps.newMap(5, 5);
        var a : Array<Dynamic> = [3, 3];
        
        // theSet of items to add
        
        var theSet : LinkedSet = Sets.newLinkedSet(2, Args.from(map), 1, 1, Args.from(a));
        assertTrue(Std.is(theSet, LinkedSet));
        assertEquals(4, theSet.size);
        assertTrue(CollectionTest.itemsEqual(theSet, [2, 5, 1, 3]));
        
        // no item
        
        theSet = Sets.newLinkedSet();
        assertTrue(Std.is(theSet, LinkedSet));
        assertEquals(0, theSet.size);
        assertTrue(CollectionTest.itemsEqual(theSet, []));
    }
    
    public function test_newSortedSet() : Void
    {
        var map : IMap = Maps.newMap(5, 5);
        var a : Array<Dynamic> = [3, 3];
        
        // even theSet of items to add
        
        var theSet : SortedSet = Sets.newSortedSet(new NumericComparator(), 2, Args.from(map), 1, Args.from(a));
        assertTrue(Std.is(theSet, SortedSet));
        assertEquals(4, theSet.size);
        assertTrue(CollectionTest.itemsEqual(theSet, [1, 2, 3, 5]));
        
        // no item
        
        theSet = Sets.newSortedSet(new NumericComparator());
        assertTrue(Std.is(theSet, SortedSet));
        assertEquals(0, theSet.size);
        assertTrue(CollectionTest.itemsEqual(theSet, []));
    }
    
    /*
		 * Clone
		 */
    
    public function test_clone_returnsCopy() : Void
    {
        theSet.add(1);
        theSet.add(2);
        
        var filter : Function = function(key : Int) : Bool
        {
            return (key % 2 == 0);
        }
        
        // no filter
        
        var clone : ISet = Sets.clone(theSet);
        assertTrue(theSet != clone);
        
        // only item filter
        
        clone = Sets.clone(theSet, filter);
        assertTrue(theSet != clone);
        
        // both filters
        
        clone = Sets.clone(theSet, filter);
        assertTrue(theSet != clone);
    }
    
    public function test_clone_filters() : Void
    {
        theSet.add(1);
        theSet.add(2);
        theSet.add(3);
        theSet.add(4);
        theSet.add(5);
        theSet.add(6);
        theSet.add(7);
        theSet.add(8);
        theSet.add(9);
        theSet.add(10);
        theSet.add(11);
        theSet.add(12);
        
        var filter : Function = function(key : Int) : Bool
        {
            return (key % 2 == 0);
        }
        
        // no filter
        
        var clone : ISet = Sets.clone(theSet);
        assertEquals(12, clone.size);
        assertEquals(Type.getClassName(theSet), Type.getClassName(clone));
        assertTrue(CollectionTest.itemsEqual(clone, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]));
        
        // filter
        
        clone = Sets.clone(theSet, filter);
        assertEquals(6, clone.size);
        assertEquals(Type.getClassName(theSet), Type.getClassName(clone));
        assertTrue(CollectionTest.itemsEqual(clone, [2, 4, 6, 8, 10, 12]));
    }
    
    public function test_clone_type_and_order() : Void
    // array theSet
    {
        
        theSet = new LinkedSet();
        populate(theSet);
        var clone : ISet = Sets.clone(theSet);
        assertTrue(Std.is(clone, LinkedSet));
        assertTrue(CollectionTest.itemsEqual(clone, [3, 2, 4, 1]));
        
        // sorted theSet
        theSet = new SortedSet(new NumericComparator());
        populate(theSet);
        clone = Sets.clone(theSet);
        assertTrue(Std.is(clone, SortedSet));
        assertTrue(CollectionTest.itemsEqual(clone, [1, 2, 3, 4]));
        
        var populate : ISet->Void = function(theSet : ISet) : Void
        {
            theSet.add(3);
            theSet.add(2);
            theSet.add(4);
            theSet.add(1);
        }
    }
    
    public function test_copy() : Void
    {
        theSet.add(1);
        theSet.add(2);
        theSet.add(3);
        theSet.add(4);
        theSet.add(5);
        theSet.add(6);
        theSet.add(7);
        theSet.add(8);
        theSet.add(9);
        theSet.add(10);
        theSet.add(11);
        theSet.add(12);
        
        var filter : Function = function(key : Int) : Bool
        {
            return (key % 2 == 0);
        }
        
        // no filter
        
        var destination : ISet = new LinkedSet();
        Sets.copy(theSet, destination);
        assertEquals(12, destination.size);
        assertEquals(Type.getClassName(theSet), Type.getClassName(destination));
        assertTrue(CollectionTest.itemsEqual(destination, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]));
        
        // filter
        
        destination = new LinkedSet();
        Sets.copy(theSet, destination, filter);
        assertEquals(6, destination.size);
        assertEquals(Type.getClassName(theSet), Type.getClassName(destination));
        assertTrue(CollectionTest.itemsEqual(destination, [2, 4, 6, 8, 10, 12]));
    }
    
    /*
		 * Population
		 */
    
    // from array
    
    public function test_addFromArray() : Void
    // even number of arguments
    {
        
        
        var theSet : ISet = new LinkedSet();
        var numItems : Int = Sets.addFromArray(theSet, [1, 2, 3, 4, 5]);
        assertEquals(5, numItems);
        assertEquals(5, theSet.size);
        assertTrue(CollectionTest.itemsEqual(theSet, [1, 2, 3, 4, 5]));
        
        // no argument
        
        theSet = new LinkedSet();
        numItems = Sets.addFromArray(theSet, []);
        assertEquals(0, numItems);
        assertEquals(0, theSet.size);
        assertTrue(CollectionTest.itemsEqual(theSet, []));
    }
    
    public function test_addFromArray_null() : Void
    {
        var theSet : LinkedSet = new LinkedSet();
        var numItems : Int = Sets.addFromArray(theSet, null);
        assertEquals(0, numItems);
        assertEquals(0, theSet.size);
        assertTrue(CollectionTest.itemsEqual(theSet, []));
    }
    
    public function test_addFromArray_entries_kept() : Void
    {
        var theSet : LinkedSet = new LinkedSet();
        theSet.add(1);
        
        var source : Array<Dynamic> = [2, 3];
        
        var numItems : Int = Sets.addFromArray(theSet, source);
        assertEquals(2, numItems);
        assertEquals(3, theSet.size);
        assertTrue(CollectionTest.itemsEqual(theSet, [1, 2, 3]));
    }
    
    public function test_addFromArray_mixed_array() : Void
    {
        var sourceSet : LinkedSet = new LinkedSet();
        sourceSet.add(2);
        sourceSet.add(3);
        sourceSet.add(4);
        
        var sourceMap : IMap = Maps.newLinkedMap(6, 6, 7, 7);
        var sourceArray : Array<Dynamic> = [8, 8];
        
        var source : Array<Dynamic> = [
        1, 1, 
        Args.from(sourceSet), 
        5, 5, 
        Args.from(sourceMap), 
        Args.from(sourceArray), 
        9, 9
    ];
        
        var theSet : LinkedSet = new LinkedSet();
        var numItems : Int = Sets.addFromArray(theSet, source);
        
        assertEquals(9, numItems);
        assertEquals(9, theSet.size);
        assertTrue(CollectionTest.itemsEqual(theSet, [1, 2, 3, 4, 5, 6, 7, 8, 9]));
    }
    
    // from collection
    
    public function test_addFromCollection() : Void
    {
        var source : LinkedSet = new LinkedSet();
        source.add(1);
        source.add(2);
        
        var theSet : LinkedSet = new LinkedSet();
        var numItems : Int = Sets.addFromCollection(theSet, source);
        
        assertEquals(2, numItems);
        assertEquals(2, theSet.size);
        assertTrue(CollectionTest.itemsEqual(theSet, [1, 2]));
    }
    
    public function test_addFromCollection_null() : Void
    {
        var theSet : LinkedSet = new LinkedSet();
        var numItems : Int = Sets.addFromCollection(theSet, null);
        assertEquals(0, numItems);
        assertEquals(0, theSet.size);
        assertTrue(CollectionTest.itemsEqual(theSet, []));
    }
    
    public function test_addFromCollection_entries_kept() : Void
    {
        var theSet : LinkedSet = new LinkedSet();
        theSet.add(1);
        
        var source : LinkedSet = new LinkedSet();
        source.add(2);
        
        var numItems : Int = Sets.addFromCollection(theSet, source);
        
        assertEquals(1, numItems);
        assertEquals(2, theSet.size);
        assertTrue(CollectionTest.itemsEqual(theSet, [1, 2]));
    }
    
    // from args
    
    public function test_addFromArgs() : Void
    // even number of arguments
    {
        
        
        var theSet : ISet = new LinkedSet();
        Sets.addFromArgs(theSet, 1, 2, 3, 4, 5);
        assertTrue(CollectionTest.itemsEqual(theSet, [1, 2, 3, 4, 5]));
        
        // no argument
        
        theSet = new LinkedSet();
        Sets.addFromArgs(theSet);
        assertTrue(CollectionTest.itemsEqual(theSet, []));
    }

    public function new()
    {
        super();
    }
}


