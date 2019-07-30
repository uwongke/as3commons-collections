package org.as3commons.collections.utils;

import flash.errors.ArgumentError;
import flash.errors.Error;
import haxe.Constraints.Function;
import flexunit.framework.TestCase;
import org.as3commons.collections.LinkedMap;
import org.as3commons.collections.Map;
import org.as3commons.collections.SortedMap;
import org.as3commons.collections.framework.IMap;
import org.as3commons.collections.testhelpers.CollectionTest;

class MapsTest extends TestCase
{
    
    private var map : IMap;
    
    override public function setUp() : Void
    {
        map = new Map();
    }
    
    /*
		 * Creation
		 */
    
    public function test_newMap() : Void
    {
        var o : Dynamic = {
            3 : 3,
            4 : 4
        };
        var o2 : Dynamic = {
            3 : "3b",
            6 : 6
        };
        var a : Array<Dynamic> = [5, 5];
        
        // even list of items to add
        
        var map : Map = Maps.newMap(1, 1, 2, 2, Args.from(o), Args.from(a));
        assertTrue(Std.is(map, Map));
        assertEquals(5, map.size);
        assertTrue(CollectionTest.keysMatch(map, [1, 2, 3, 4, 5]));
        assertTrue(CollectionTest.itemsMatch(map, [1, 2, 3, 4, 5]));
        
        // odd list of items to add
        
        map = Maps.newMap(1, 1, "wrong", 2, 2, Args.from(o), Args.from(a));
        assertTrue(Std.is(map, Map));
        assertEquals(4, map.size);
        assertTrue(CollectionTest.keysMatch(map, [1, "wrong", 2, 5]));
        assertTrue(CollectionTest.itemsMatch(map, [1, 2, o, 5]));
        
        // duplicates
        
        map = Maps.newMap(1, 1, Args.from(o), 1, "1b", Args.from(o2));
        assertTrue(Std.is(map, Map));
        assertEquals(4, map.size);
        assertTrue(CollectionTest.keysMatch(map, [1, 3, 4, 6]));
        assertTrue(CollectionTest.itemsMatch(map, [1, 3, 4, 6]));
        
        // no item
        
        map = Maps.newMap();
        assertTrue(Std.is(map, Map));
        assertEquals(0, map.size);
        assertTrue(CollectionTest.keysMatch(map, []));
        assertTrue(CollectionTest.itemsMatch(map, []));
    }
    
    public function test_newLinkedMap() : Void
    {
        var o : Dynamic = {
            5 : 5
        };
        var o2 : Dynamic = {
            5 : "5b"
        };
        var a : Array<Dynamic> = [3, 3];
        
        // even list of items to add
        
        var map : LinkedMap = Maps.newLinkedMap(2, 2, Args.from(o), 1, 1, Args.from(a));
        assertTrue(Std.is(map, LinkedMap));
        assertEquals(4, map.size);
        assertTrue(CollectionTest.keysEqual(map, [2, 5, 1, 3]));
        assertTrue(CollectionTest.itemsEqual(map, [2, 5, 1, 3]));
        
        // odd list of items to add
        
        map = Maps.newLinkedMap(2, 2, "wrong", Args.from(o), 1, 1, Args.from(a));
        assertTrue(Std.is(map, LinkedMap));
        assertEquals(4, map.size);
        assertTrue(CollectionTest.keysEqual(map, [2, "wrong", 1, 3]));
        assertTrue(CollectionTest.itemsEqual(map, [2, o, 1, 3]));
        
        // duplicates
        
        map = Maps.newLinkedMap(1, 1, Args.from(o), 1, "1b", Args.from(o2));
        assertTrue(Std.is(map, LinkedMap));
        assertEquals(2, map.size);
        assertTrue(CollectionTest.keysEqual(map, [1, 5]));
        assertTrue(CollectionTest.itemsEqual(map, [1, 5]));
        
        // no item
        
        map = Maps.newLinkedMap();
        assertTrue(Std.is(map, LinkedMap));
        assertEquals(0, map.size);
        assertTrue(CollectionTest.keysEqual(map, []));
        assertTrue(CollectionTest.itemsEqual(map, []));
    }
    
    public function test_newSortedMap() : Void
    {
        var o : Dynamic = {
            5 : 5
        };
        var o2 : Dynamic = {
            5 : "5b"
        };
        var a : Array<Dynamic> = [3, 3];
        
        // even list of items to add
        
        var map : SortedMap = Maps.newSortedMap(new NumericComparator(), 2, 2, Args.from(o), 1, 1, Args.from(a));
        assertTrue(Std.is(map, SortedMap));
        assertEquals(4, map.size);
        assertTrue(CollectionTest.keysEqual(map, [1, 2, 3, 5]));
        assertTrue(CollectionTest.itemsEqual(map, [1, 2, 3, 5]));
        
        // odd list of items to add
        
        var thrownError : Error;
        try
        {
            map = Maps.newSortedMap(new NumericComparator(), 2, 2, 22, Args.from(o), 1, 1, Args.from(a));
        }
        catch (e : Error)
        {
            thrownError = e;
        }
        
        Assert.isNotNull(thrownError);
        assertTrue(Std.is(thrownError, UncomparableType));
        
        // duplicates
        
        map = Maps.newSortedMap(new NumericComparator(), Args.from(o), 1, 1, 1, 11, Args.from(o2));
        assertTrue(Std.is(map, SortedMap));
        assertEquals(2, map.size);
        assertTrue(CollectionTest.keysEqual(map, [1, 5]));
        assertTrue(CollectionTest.itemsEqual(map, [1, 5]));
        
        // no item
        
        map = Maps.newSortedMap(new NumericComparator());
        assertTrue(Std.is(map, SortedMap));
        assertEquals(0, map.size);
        assertTrue(CollectionTest.keysEqual(map, []));
        assertTrue(CollectionTest.itemsEqual(map, []));
    }
    
    
    /*
		 * Retrieval
		 */
    
    public function test_itemOrError_notMapped() : Void
    {
        var expectedErrorMessage : String = "expected error message";
        var thrownError : ArgumentError;
        
        try
        {
            Maps.itemForOrError(map, "non-existant-key", expectedErrorMessage);
        }
        catch (e : Error)
        {
            thrownError = try cast(e, ArgumentError) catch(e:Dynamic) null;
        }
        
        Assert.isNotNull(thrownError);  // ArgumentError was thrown
        assertEquals(expectedErrorMessage, thrownError.message);  // ArgumentError used the supplied error message
    }
    
    public function test_itemOrError_mapped() : Void
    {
        var expectedItem : Dynamic = "an item";
        var key : Dynamic = "a key";
        var thrownError : Error;
        
        map.add(key, expectedItem);
        
        try
        {
            var result : Dynamic = Maps.itemForOrError(map, key);
        }
        catch (e : Error)
        {
            thrownError = e;
        }
        
        Assert.isNull(thrownError);  // No error was thrown
        assertEquals(expectedItem, result);  // Expected item was retrieved from the map
    }
    
    public function test_itemOrValue_notMapped() : Void
    {
        var expectedDefaultValue : Dynamic = "a default value";
        
        var result : Dynamic = Maps.itemForOrValue(map, "non-existant-key", expectedDefaultValue);
        
        assertEquals(expectedDefaultValue, result);  // Expected default value is returned when no mapping exists
    }
    
    public function test_itemOrValue_mapped() : Void
    {
        var mappedItem : Dynamic = "a mapped item";
        var key : Dynamic = "a key";
        
        map.add(key, mappedItem);
        var result : Dynamic = Maps.itemForOrValue(map, key, "a default value which will not be used");
        
        assertEquals(mappedItem, result);  // Mapped item is returned when a prior mapping exists
    }
    
    public function test_itemOrAdd_notMapped() : Void
    {
        var item : Dynamic = "a new item";
        var key : Dynamic = "a key";
        
        var result : Dynamic = Maps.itemForOrAdd(map, key, item);
        
        assertEquals(item, map.itemFor(key));  // Supplied item is now mapped to the key
        assertEquals(item, result);  // Mapped item is returned by the call when no mapping exists
    }
    
    public function test_itemOrAdd_priorMapping() : Void
    {
        var newItem : Dynamic = "a new item";
        var previouslyMappedItem : Dynamic = "a previously mapped item";
        var key : Dynamic = "a key";
        
        map.add(key, previouslyMappedItem);
        var result : Dynamic = Maps.itemForOrAdd(map, key, newItem);
        
        assertEquals(previouslyMappedItem, map.itemFor(key));  // Previously mapped item is not replaced
        assertEquals(previouslyMappedItem, result);  // Previously mapped item is returned by the call when a prior mapping exists
    }
    
    /*
		 * Clone
		 */
    
    public function test_clone_returnsCopy() : Void
    {
        map.add(1, 1);
        map.add(2, 1);
        
        var filter : Function = function(key : Int) : Bool
        {
            return (key % 2 == 0);
        }
        
        // no filter
        
        var clone : IMap = Maps.clone(map);
        assertTrue(map != clone);
        
        // only key filter
        
        clone = Maps.clone(map, filter);
        assertTrue(map != clone);
        
        // only item filter
        
        clone = Maps.clone(map, null, filter);
        assertTrue(map != clone);
        
        // both filters
        
        clone = Maps.clone(map, filter, filter);
        assertTrue(map != clone);
    }
    
    public function test_clone_filters() : Void
    {
        map.add(1, 1);
        map.add(2, 1);
        map.add(3, 2);
        map.add(4, 2);
        map.add(5, 3);
        map.add(6, 3);
        map.add(7, 4);
        map.add(8, 4);
        map.add(9, 5);
        map.add(10, 5);
        map.add(11, 6);
        map.add(12, 6);
        
        var filter : Function = function(key : Int) : Bool
        {
            return (key % 2 == 0);
        }
        
        // no filter
        
        var clone : IMap = Maps.clone(map);
        assertEquals(12, clone.size);
        assertEquals(Type.getClassName(map), Type.getClassName(clone));
        assertTrue(CollectionTest.keysMatch(clone, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]));
        assertTrue(CollectionTest.itemsMatch(clone, [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6]));
        
        // only key filter
        
        clone = Maps.clone(map, filter);
        assertEquals(6, clone.size);
        assertEquals(Type.getClassName(map), Type.getClassName(clone));
        assertTrue(CollectionTest.keysMatch(clone, [2, 4, 6, 8, 10, 12]));
        assertTrue(CollectionTest.itemsMatch(clone, [1, 2, 3, 4, 5, 6]));
        
        // only item filter
        
        clone = Maps.clone(map, null, filter);
        assertEquals(6, clone.size);
        assertEquals(Type.getClassName(map), Type.getClassName(clone));
        assertTrue(CollectionTest.keysMatch(clone, [3, 4, 7, 8, 11, 12]));
        assertTrue(CollectionTest.itemsMatch(clone, [2, 2, 4, 4, 6, 6]));
        
        // both filters
        
        clone = Maps.clone(map, filter, filter);
        assertEquals(3, clone.size);
        assertEquals(Type.getClassName(map), Type.getClassName(clone));
        assertTrue(CollectionTest.keysMatch(clone, [4, 8, 12]));
        assertTrue(CollectionTest.itemsMatch(clone, [2, 4, 6]));
    }
    
    public function test_clone_type_and_order() : Void
    // map
    {
        
        var map : IMap = new Map();
        populate(map);
        var clone : IMap = Maps.clone(map);
        assertTrue(Std.is(clone, Map));
        assertTrue(CollectionTest.keysMatch(clone, [1, 2, 3, 4]));
        assertTrue(CollectionTest.itemsMatch(clone, [1, 2, 3, 4]));
        
        // linked map
        map = new LinkedMap();
        populate(map);
        clone = Maps.clone(map);
        assertTrue(Std.is(clone, LinkedMap));
        assertTrue(CollectionTest.keysEqual(clone, [3, 2, 4, 1]));
        assertTrue(CollectionTest.itemsEqual(clone, [3, 2, 4, 1]));
        
        // sorted map
        map = new SortedMap(new NumericComparator());
        populate(map);
        clone = Maps.clone(map);
        assertTrue(Std.is(clone, SortedMap));
        assertTrue(CollectionTest.keysEqual(clone, [1, 2, 3, 4]));
        assertTrue(CollectionTest.itemsEqual(clone, [1, 2, 3, 4]));
        
        var populate : IMap->Void = function(map : IMap) : Void
        {
            map.add(3, 3);
            map.add(2, 2);
            map.add(4, 4);
            map.add(1, 1);
        }
    }
    
    public function test_copy() : Void
    {
        map.add(1, 1);
        map.add(2, 1);
        map.add(3, 2);
        map.add(4, 2);
        map.add(5, 3);
        map.add(6, 3);
        map.add(7, 4);
        map.add(8, 4);
        map.add(9, 5);
        map.add(10, 5);
        map.add(11, 6);
        map.add(12, 6);
        
        var filter : Function = function(key : Int) : Bool
        {
            return (key % 2 == 0);
        }
        
        // no filter
        var destination : IMap = new Map();
        Maps.copy(map, destination);
        assertEquals(12, destination.size);
        assertTrue(CollectionTest.keysMatch(destination, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]));
        assertTrue(CollectionTest.itemsMatch(destination, [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6]));
        
        // only key filter
        
        destination = new Map();
        Maps.copy(map, destination, filter);
        assertEquals(6, destination.size);
        assertEquals(Type.getClassName(map), Type.getClassName(destination));
        assertTrue(CollectionTest.keysMatch(destination, [2, 4, 6, 8, 10, 12]));
        assertTrue(CollectionTest.itemsMatch(destination, [1, 2, 3, 4, 5, 6]));
        
        // only item filter
        
        destination = new Map();
        Maps.copy(map, destination, null, filter);
        assertEquals(6, destination.size);
        assertEquals(Type.getClassName(map), Type.getClassName(destination));
        assertTrue(CollectionTest.keysMatch(destination, [3, 4, 7, 8, 11, 12]));
        assertTrue(CollectionTest.itemsMatch(destination, [2, 2, 4, 4, 6, 6]));
        
        // both filters
        
        destination = new Map();
        Maps.copy(map, destination, filter, filter);
        assertEquals(3, destination.size);
        assertEquals(Type.getClassName(map), Type.getClassName(destination));
        assertTrue(CollectionTest.keysMatch(destination, [4, 8, 12]));
        assertTrue(CollectionTest.itemsMatch(destination, [2, 4, 6]));
    }
    
    /*
		 * Population
		 */
    
    // from object
    
    public function test_addFromObject() : Void
    {
        var source : Dynamic = { };
        Reflect.setField(source, "key", "value");
        Reflect.setField(source, Std.string(22), "twenty two");
        
        var map : Map = new Map();
        var numItems : Int = Maps.addFromObject(map, source);
        
        assertEquals(2, numItems);
        assertEquals(2, map.size);
        assertEquals("value", map.itemFor("key"));
        assertEquals("twenty two", map.itemFor(22));
    }
    
    public function test_addFromObject_null() : Void
    {
        var map : Map = new Map();
        var numItems : Int = Maps.addFromObject(map, null);
        assertEquals(0, numItems);
        assertEquals(0, map.size);
        assertTrue(CollectionTest.keysEqual(map, []));
        assertTrue(CollectionTest.itemsEqual(map, []));
    }
    
    public function test_addFromObject_entries_kept() : Void
    {
        var map : Map = new Map();
        map.add(1, 1);
        
        var source : Dynamic = {
            2 : 2
        };
        var numItems : Int = Maps.addFromObject(map, source);
        
        assertEquals(1, numItems);
        assertEquals(2, map.size);
    }
    
    // from array
    
    public function test_addFromArray() : Void
    // even number of arguments
    {
        
        
        var map : IMap = new LinkedMap();
        var numItems : Int = Maps.addFromArray(map, [1, "1", 2, "2", 3, "3", 4, "4", 5, "5"]);
        assertEquals(5, numItems);
        assertEquals(5, map.size);
        assertTrue(CollectionTest.keysEqual(map, [1, 2, 3, 4, 5]));
        assertTrue(CollectionTest.itemsEqual(map, ["1", "2", "3", "4", "5"]));
        
        // odd number of arguments
        
        map = new LinkedMap();
        numItems = Maps.addFromArray(map, [1, "1", 2, "2", 3, "3", 4, "4", 5]);
        assertEquals(4, numItems);
        assertEquals(4, map.size);
        assertTrue(CollectionTest.keysEqual(map, [1, 2, 3, 4]));
        assertTrue(CollectionTest.itemsEqual(map, ["1", "2", "3", "4"]));
        
        // single argument
        
        map = new LinkedMap();
        numItems = Maps.addFromArray(map, [1]);
        assertEquals(0, numItems);
        assertEquals(0, map.size);
        assertTrue(CollectionTest.keysEqual(map, []));
        assertTrue(CollectionTest.itemsEqual(map, []));
        
        // no argument
        
        map = new LinkedMap();
        numItems = Maps.addFromArray(map, []);
        assertEquals(0, numItems);
        assertEquals(0, map.size);
        assertTrue(CollectionTest.keysEqual(map, []));
        assertTrue(CollectionTest.itemsEqual(map, []));
    }
    
    public function test_addFromArray_null() : Void
    {
        var map : Map = new Map();
        var numItems : Int = Maps.addFromArray(map, null);
        assertEquals(0, numItems);
        assertEquals(0, map.size);
        assertTrue(CollectionTest.keysEqual(map, []));
        assertTrue(CollectionTest.itemsEqual(map, []));
    }
    
    public function test_addFromArray_entries_kept() : Void
    {
        var map : Map = new Map();
        map.add(1, 1);
        
        var source : Array<Dynamic> = [2, 2];
        
        var numItems : Int = Maps.addFromArray(map, source);
        assertEquals(1, numItems);
        assertEquals(2, map.size);
    }
    
    public function test_addFromArray_mixed_array() : Void
    {
        var sourceMap : LinkedMap = new LinkedMap();
        sourceMap.add(2, 2);
        sourceMap.add(3, 3);
        sourceMap.add(4, 4);
        
        var sourceObject : Dynamic = {
            6 : 6,
            7 : 7
        };
        var sourceArray : Array<Dynamic> = [8, 8];
        
        var source : Array<Dynamic> = [
        1, 1, 
        Args.from(sourceMap), 
        5, 5, 
        Args.from(sourceObject), 
        Args.from(sourceArray), 
        9, 9
    ];
        
        var map : LinkedMap = new LinkedMap();
        var numItems : Int = Maps.addFromArray(map, source);
        
        assertEquals(9, numItems);
        assertEquals(9, map.size);
        assertTrue(CollectionTest.keysEqual(map, [1, 2, 3, 4, 5, 6, 7, 8, 9]));
        assertTrue(CollectionTest.itemsEqual(map, [1, 2, 3, 4, 5, 6, 7, 8, 9]));
    }
    
    public function test_addFromArray_mixed_array_wrong_keyitempairs() : Void
    {
        var sourceMap : LinkedMap = new LinkedMap();
        sourceMap.add(2, 2);
        sourceMap.add(3, 3);
        sourceMap.add(4, 4);
        
        var sourceObject : Dynamic = {
            6 : 6,
            7 : 7
        };
        var sourceArray : Array<Dynamic> = [8, 8];
        
        var source : Array<Dynamic> = [
        1, 1, "wrong", 
        Args.from(sourceMap), 
        5, 5, 
        Args.from(sourceObject), 
        Args.from(sourceArray), 
        9, 9
    ];
        
        var map : LinkedMap = new LinkedMap();
        var numItems : Int = Maps.addFromArray(map, source);
        
        assertEquals(7, numItems);
        assertEquals(7, map.size);
        assertTrue(CollectionTest.keysEqual(map, [1, "wrong", 5, 6, 7, 8, 9]));
        assertTrue(CollectionTest.itemsEqual(map, [1, sourceMap, 5, 6, 7, 8, 9]));
    }
    
    public function test_addFromArray_mixed_array_wrong_keyitempairs2() : Void
    {
        var sourceMap : LinkedMap = new LinkedMap();
        sourceMap.add(2, 2);
        sourceMap.add(3, 3);
        sourceMap.add(4, 4);
        
        var sourceObject : Dynamic = {
            6 : 6,
            7 : 7
        };
        var sourceArray : Array<Dynamic> = [8, 8, "wrong"];
        
        var source : Array<Dynamic> = [
        1, 1, 
        Args.from(sourceMap), 
        5, "wrong2", 5, 
        Args.from(sourceObject), 
        Args.from(sourceArray), 
        "wrong3", 9, 9
    ];
        
        var map : LinkedMap = new LinkedMap();
        var numItems : Int = Maps.addFromArray(map, source);
        
        assertEquals(7, numItems);
        assertEquals(7, map.size);
        assertTrue(CollectionTest.keysEqual(map, [1, 2, 3, 4, 5, 8, "wrong3"]));
        assertTrue(CollectionTest.itemsEqual(map, [1, 2, 3, 4, "wrong2", 8, 9]));
    }
    
    // from map
    
    public function test_addFromMap() : Void
    {
        var source : Map = new Map();
        source.add("key", "value");
        source.add(22, "twenty two");
        
        var map : Map = new Map();
        var numItems : Int = Maps.addFromMap(map, source);
        
        assertEquals(2, numItems);
        assertEquals(2, map.size);
        assertEquals("value", map.itemFor("key"));
        assertEquals("twenty two", map.itemFor(22));
    }
    
    public function test_addFromMap_null() : Void
    {
        var map : Map = new Map();
        var numItems : Int = Maps.addFromMap(map, null);
        assertEquals(0, numItems);
        assertEquals(0, map.size);
        assertTrue(CollectionTest.keysEqual(map, []));
        assertTrue(CollectionTest.itemsEqual(map, []));
    }
    
    public function test_addFromMap_entries_kept() : Void
    {
        var map : Map = new Map();
        map.add(1, 1);
        
        var source : Map = new Map();
        source.add(2, 2);
        
        var numItems : Int = Maps.addFromMap(map, source);
        
        assertEquals(1, numItems);
        assertEquals(2, map.size);
    }
    
    // from args
    
    public function test_addFromArgs() : Void
    // even number of arguments
    {
        
        
        var map : IMap = new LinkedMap();
        Maps.addFromArgs(map, 1, "1", 2, "2", 3, "3", 4, "4", 5, "5");
        assertTrue(CollectionTest.keysEqual(map, [1, 2, 3, 4, 5]));
        assertTrue(CollectionTest.itemsEqual(map, ["1", "2", "3", "4", "5"]));
        
        // odd number of arguments
        
        map = new LinkedMap();
        Maps.addFromArgs(map, 1, "1", 2, "2", 3, "3", 4, "4", 5);
        assertTrue(CollectionTest.keysEqual(map, [1, 2, 3, 4]));
        assertTrue(CollectionTest.itemsEqual(map, ["1", "2", "3", "4"]));
        
        // single argument
        
        map = new LinkedMap();
        Maps.addFromArgs(map, 1);
        assertTrue(CollectionTest.keysEqual(map, []));
        assertTrue(CollectionTest.itemsEqual(map, []));
        
        // no argument
        
        map = new LinkedMap();
        Maps.addFromArgs(map);
        assertTrue(CollectionTest.keysEqual(map, []));
        assertTrue(CollectionTest.itemsEqual(map, []));
    }

    public function new()
    {
        super();
    }
}


