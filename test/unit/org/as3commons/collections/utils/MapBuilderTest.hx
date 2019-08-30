package org.as3commons.collections.utils;

import flexunit.framework.TestCase;
import org.as3commons.collections.LinkedMap;
import org.as3commons.collections.Map;
import org.as3commons.collections.SortedMap;
import org.as3commons.collections.framework.IMap;

/**
	 * @author John Reeves.
	 */
class MapBuilderTest extends TestCase
{
    public function test_buildMap() : Void
    {
        var result : IMap = MapBuilder.newMap().add("key", "item").build();
        
        assertEquals(1, result.size);  // Resulting map has a single mapping
        assertEquals("item", result.itemFor("key"));  // Resulting map has the supplied mapping
        assertEquals(Type.getClassName(Map), Type.getClassName(result));  // Resulting map instance is of type Map
    }
    
    public function test_buildLinkedMap() : Void
    {
        var result : IMap = MapBuilder.newLinkedMap().add("key1", "item-1").add("key2", "item-2").build();
        
        assertEquals(2, result.size);  // Resulting map has a two mappings
        assertEquals("item-1", result.itemFor("key1"));  // Resulting map has the supplied mapping
        assertEquals("item-2", result.itemFor("key2"));  // Resulting map has the supplied mapping
        assertEquals(Type.getClassName(LinkedMap), Type.getClassName(result));  // Resulting map instance is of type Map
    }
    
    public function test_buildSortedMap() : Void
    {
        var result : IMap = MapBuilder.newSortedMap(new NumericComparator()).add("key1", 200).add("key2", 100).add("key3", 25).build();
        
        assertEquals(3, result.size);  // Resulting map has a three mappings
        assertEquals(200, result.itemFor("key1"));  // Resulting map has the supplied mapping
        assertEquals(100, result.itemFor("key2"));  // Resulting map has the supplied mapping
        assertEquals(25, result.itemFor("key3"));  // Resulting map has the supplied mapping
        assertEquals(Type.getClassName(SortedMap), Type.getClassName(result));  // Resulting map instance is of type Map
    }

    public function new()
    {
        super();
    }
}


