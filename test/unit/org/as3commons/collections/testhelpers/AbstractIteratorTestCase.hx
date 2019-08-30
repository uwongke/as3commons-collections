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

import flexunit.framework.TestCase;
import org.as3commons.collections.framework.ICollectionIterator;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.IMapIterator;
import org.as3commons.collections.units.ITestOrder;
import org.as3commons.collections.units.ITestSortOrder;
import org.as3commons.collections.utils.ArrayUtils;

/**
	 * @author Jens Struwe 18.03.2010
	 */
class AbstractIteratorTestCase extends TestCase
{
    
    /*
		 * Test to override
		 */
    
    public function fillCollection(items : Array<Dynamic>) : Void
    {
    }
    
    public function createCollection() : Dynamic
    {
        return null;
    }
    
    public function getIterator(index : Int = 0) : IIterator
    {
        return null;
    }
    
    public function toArray() : Array<Dynamic>
    {
        return null;
    }
    
    
    /*
		 * Test neutralisation
		 */
    
    public var collection : Dynamic;
    
    override public function setUp() : Void
    {
        TestItems.init();
        collection = createCollection();
    }
    
    override public function tearDown() : Void
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
    
    public function allKeys(iterator : IMapIterator) : Array<Dynamic>
    {
        var keys : Array<Dynamic> = new Array<Dynamic>();
        while (iterator.hasNext())
        {
            iterator.next();
            keys.push(iterator.key);
        }
        iterator.start();
        return keys;
    }
    
    public function validateItems(expectedItems : Array<Dynamic>, items : Array<Dynamic> = null) : Bool
    {
        if (items == null)
        {
            items = toArray();
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
    
    public function validateTestItems(expectedItems : Array<Dynamic>, items : Array<Dynamic> = null) : Bool
    {
        if (items == null)
        {
            items = toArray();
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

    public function new()
    {
        super();
    }
}

