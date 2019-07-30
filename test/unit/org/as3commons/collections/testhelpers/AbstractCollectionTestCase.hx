/**
 * Copyright 2010 The original author or authors.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.as3commons.collections.testhelpers;

import org.as3commons.collections.framework.ICollection;
import org.as3commons.collections.framework.ICollectionIterator;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.IMap;
import org.as3commons.collections.framework.IMapIterator;
import org.as3commons.collections.framework.core.LinkedMapNode;
import org.as3commons.collections.testhelpers.TestItems;
import org.as3commons.collections.units.ITestOrder;
import org.as3commons.collections.units.ITestSortOrder;
import org.as3commons.collections.utils.ArrayUtils;

import org.as3commons.collections.testhelpers.TestComparator;

/**
	 * @author Jens Struwe 18.03.2010
	 */
class AbstractCollectionTestCase
{
    
    /*
		 * Test to override
		 */
    
    public function fillCollection(items : Array<Dynamic>) : Void
    {
    }
    
    public function createCollection() : ICollection
    {
        return null;
    }
    
    /*
		 * Test neutralisation
		 */
    
    public var collection : ICollection;
    public function setUp() : Void
    {
        TestItems.init();
        collection = createCollection();
    }

    public function tearDown() : Void
    {
        TestItems.cleanUp();
    }
    
    /*
		 * Test public interface
		 */
    
    public function allItems(iterator : ICollectionIterator) : Array<Dynamic>
    {
        var items : Array<Dynamic> = new Array<Dynamic>();
        while (iterator.hasNext())
        {
            items.push(iterator.next());
        }
        iterator.start();
        return items;
    }
    
    public function allKeys(iterator : IIterator) : Array<Dynamic>
    {
        var keys : Array<Dynamic> = new Array<Dynamic>();
        var current : Dynamic;
        while (iterator.hasNext())
        {
            current = iterator.next();
            if (Std.is(iterator, IMapIterator))
            {
                keys.push(cast((iterator), IMapIterator).key);
            }
            else
            {
                keys.push(current);
            }
        }
        if (Std.is(iterator, ICollectionIterator))
        {
            cast((iterator), ICollectionIterator).start();
        }
        return keys;
    }
    
    public function validateItems(expectedItems : Array<Dynamic>, items : Array<Dynamic> = null) : Bool
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
    
    public function validateItemsStrictly(expectedItems : Array<Dynamic>, items : Array<Dynamic> = null) : Bool
    {
        if (items == null)
        {
            items = collection.toArray();
        }
        
        return ArrayUtils.arraysEqual(expectedItems, items);
    }
    
    public function validateTestItems(expectedItems : Array<Dynamic>, items : Array<Dynamic> = null) : Bool
    {
        if (items == null)
        {
            items = collection.toArray();
        }
        
        if (Std.is(collection, ITestSortOrder))
        {
            expectedItems.sort(new TestComparator().compare);
            return TestItems.itemsEqual(expectedItems, items);
        }
        else if (Std.is(collection, ITestOrder))
        {
            return TestItems.itemsEqual(expectedItems, items);
        }
        else
        {
            return TestItems.itemsMatch(expectedItems, items);
        }
    }
    
    public function validateTestItemsReverse(expectedItems : Array<Dynamic>) : Bool
    {
        var items : Array<Dynamic> = new Array<Dynamic>();
        var iterator : ICollectionIterator = try cast(collection.iterator(), ICollectionIterator) catch(e:Dynamic) null;
        iterator.end();
        while (iterator.hasPrevious())
        {
            items.unshift(iterator.previous());
        }
        
        if (Std.is(collection, ITestSortOrder))
        {
            expectedItems.sort(new TestComparator().compare);
            return TestItems.itemsEqual(expectedItems, items);
        }
        else if (Std.is(collection, ITestOrder))
        {
            return TestItems.itemsEqual(expectedItems, items);
        }
        else
        {
            return TestItems.itemsMatch(expectedItems, items);
        }
    }
    
    public function validateTestItemsStrictly(expectedItems : Array<Dynamic>, items : Array<Dynamic> = null) : Bool
    {
        if (items == null)
        {
            items = collection.toArray();
        }
        
        return TestItems.itemsEqual(expectedItems, items);
    }
    
    /*
		 * Map keys
		 */
    
    public function validateKeys(expectedKeys : Array<Dynamic>, keys : Array<Dynamic> = null) : Bool
    {
        if (keys == null)
        {
            keys = cast((collection), IMap).keysToArray();
        }
        
        if (Std.is(collection, ITestSortOrder))
        {
            expectedKeys = sortKeys(expectedKeys, collection.toArray());
            return ArrayUtils.arraysEqual(expectedKeys, keys);
        }
        else if (Std.is(collection, ITestOrder))
        {
            return ArrayUtils.arraysEqual(expectedKeys, keys);
        }
        else
        {
            return ArrayUtils.arraysMatch(expectedKeys, keys);
        }
    }
    
    public function validateKeysStrictly(expectedKeys : Array<Dynamic>, keys : Array<Dynamic> = null) : Bool
    {
        if (keys == null)
        {
            keys = cast((collection), IMap).keysToArray();
        }
        
        return ArrayUtils.arraysEqual(expectedKeys, keys);
    }
    
    public function validateTestKeys(expectedKeys : Array<Dynamic>, keys : Array<Dynamic> = null) : Bool
    {
        if (keys == null)
        {
            keys = cast((collection), IMap).keysToArray();
        }
        
        if (Std.is(collection, ITestSortOrder))
        {
            expectedKeys = TestItems.keyArrayByIndices(expectedKeys);
            expectedKeys = sortKeys(expectedKeys, collection.toArray());
            return ArrayUtils.arraysEqual(expectedKeys, keys);
        }
        else if (Std.is(collection, ITestOrder))
        {
            return TestItems.keysEqual(expectedKeys, keys);
        }
        else
        {
            return TestItems.keysMatch(expectedKeys, keys);
        }
    }
    
    public function validateTestKeysStrictly(expectedKeys : Array<Dynamic>, keys : Array<Dynamic> = null) : Bool
    {
        if (keys == null)
        {
            keys = cast((collection), IMap).keysToArray();
        }
        
        return TestItems.keysEqual(expectedKeys, keys);
    }
    
    private function sortKeys(keys : Array<Dynamic>, items : Array<Dynamic>) : Array<Dynamic>
    {
        var entries : Array<Dynamic> = new Array<Dynamic>();
        for (i in 0...keys.length)
        {
            entries.push(new LinkedMapNode(keys[i], cast((collection), IMap).itemFor(keys[i])));
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
        //super();
    }
}



class MapEntryComparator extends TestComparator
{
    override public function compare(item1 : Dynamic, item2 : Dynamic) : Int
    {
        return super.compare(cast((item1), LinkedMapNode).item, cast((item2), LinkedMapNode).item);
    }

   // @:allow(org.as3commons.collections.testhelpers)
    public function new()
    {
        super();
    }
}
