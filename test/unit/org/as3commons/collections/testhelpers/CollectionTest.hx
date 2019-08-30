package org.as3commons.collections.testhelpers;

import org.as3commons.collections.framework.ICollection;
import org.as3commons.collections.framework.IMap;
import org.as3commons.collections.framework.core.LinkedMapNode;
import org.as3commons.collections.units.ITestOrder;
import org.as3commons.collections.units.ITestSortOrder;
import org.as3commons.collections.utils.ArrayUtils;

import org.as3commons.collections.testhelpers.TestComparator;

/**
	 * @author Jens Struwe 15.04.2011
	 */
class CollectionTest
{
    
    /*
		 * Collection items
		 */
    
    public static function itemsMatch(collection : ICollection, expectedItems : Array<Dynamic>, items : Array<Dynamic> = null) : Bool
    {
        if (items == null)
        {
            items = collection.toArray();
        }
        
        if (Std.is(collection, ITestSortOrder))
        {
            ArrayUtils.mergeSort(expectedItems, new TestComparator());
            return ArrayUtils.arraysEqual(expectedItems, items);
        }
        else if (Std.is(collection, ITestOrder))
        {
            return ArrayUtils.arraysEqual(expectedItems, items);
        }
        else
        {
            return ArrayUtils.arraysMatch(expectedItems, items);
        }
    }
    
    public static function itemsEqual(collection : ICollection, expectedItems : Array<Dynamic>, items : Array<Dynamic> = null) : Bool
    {
        if (items == null)
        {
            items = collection.toArray();
        }
        
        return ArrayUtils.arraysEqual(expectedItems, items);
    }
    
    /*
		 * Map keys
		 */
    
    public static function keysMatch(map : IMap, expectedKeys : Array<Dynamic>, keys : Array<Dynamic> = null) : Bool
    {
        if (keys == null)
        {
            keys = map.keysToArray();
        }
        
        if (Std.is(map, ITestSortOrder))
        {
            expectedKeys = sortKeys(map, expectedKeys, map.toArray());
            return ArrayUtils.arraysEqual(expectedKeys, keys);
        }
        else if (Std.is(map, ITestOrder))
        {
            return ArrayUtils.arraysEqual(expectedKeys, keys);
        }
        else
        {
            return ArrayUtils.arraysMatch(expectedKeys, keys);
        }
    }
    
    public static function keysEqual(map : IMap, expectedKeys : Array<Dynamic>, keys : Array<Dynamic> = null) : Bool
    {
        if (keys == null)
        {
            keys = map.keysToArray();
        }
        
        return ArrayUtils.arraysEqual(expectedKeys, keys);
    }
    
    /*
		 * Private
		 */
    
    private static function sortKeys(map : IMap, keys : Array<Dynamic>, items : Array<Dynamic>) : Array<Dynamic>
    {
        var entries : Array<Dynamic> = new Array<Dynamic>();
        for (i in 0...keys.length)
        {
            entries.push(new LinkedMapNode(keys[i], map.itemFor(keys[i])));
        }
        ArrayUtils.mergeSort(entries, new MapEntryComparator());
        
        var sortedKeys : Array<Dynamic> = new Array<Dynamic>();
        for (i in 0...entries.length)
        {
            sortedKeys.push(cast((entries[i]), LinkedMapNode).key);
        }
        
        return sortedKeys;
    }

    public function new()
    {
    }
}



class MapEntryComparator extends TestComparator
{
    override public function compare(item1 : Dynamic, item2 : Dynamic) : Int
    {
        return super.compare(cast((item1), LinkedMapNode).item, cast((item2), LinkedMapNode).item);
    }

    @:allow(org.as3commons.collections.testhelpers)
    private function new()
    {
        super();
    }
}