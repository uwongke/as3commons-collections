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
package org.as3commons.collections.units.iterators;

import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
import org.as3commons.collections.testhelpers.AbstractIteratorUnitTestCase;
import org.as3commons.collections.testhelpers.TestItems;

/**
	 * @author Jens Struwe 18.03.2010
	 */
class IIteratorTests extends AbstractIteratorUnitTestCase
{
    
    public function new(test : AbstractIteratorTestCase)
    {
        super(test);
    }
    
    /*
		 * Initial state
		 */
    
    public function test_init() : Void
    {
        assertTrue(Std.is(_test.getIterator(), IIterator));
    }
    
    public function test_init_withEmptyCollection() : Void
    {
        var iterator : IIterator = _test.getIterator();
        assertFalse(iterator.hasNext());
        assertTrue(null == iterator.next());
    }
    
    /*
		 * Basic tests
		 */
    
    public function test_next() : Void
    {
        _test.fillCollection(TestItems.itemArray(3));
        
        var iterator : IIterator = _test.getIterator();
        var items : Array<Dynamic> = _test.toArray();
        
        iterator = _test.getIterator();
        
        assertTrue(iterator.hasNext());
        assertTrue(iterator.next() == items[0]);
        
        iterator.next();
        
        assertTrue(iterator.hasNext());
        assertTrue(iterator.next() == items[2]);
        
        assertFalse(iterator.hasNext());
        assertTrue(null == iterator.next());
    }
    
    /*
		 * Test null valued items
		 */
    
    public function test_null() : Void
    {
        _test.fillCollection([null, TestItems.object1, TestItems.object2]);
        
        var iterator : IIterator = _test.getIterator();
        var items : Array<Dynamic> = _test.toArray();
        
        assertTrue(iterator.hasNext());
        assertTrue(iterator.next() == items[0]);
        
        assertTrue(iterator.hasNext());
        assertTrue(iterator.next() == items[1]);
        
        assertTrue(iterator.hasNext());
        assertTrue(iterator.next() == items[2]);
    }
    
    /*
		 * Test all items returned
		 */
    
    public function test_returnsAllItemsAdded() : Void
    {
        var items : Array<Dynamic> = TestItems.itemArray(5);
        _test.fillCollection(items);
        
        var returnedItems : Array<Dynamic> = new Array<Dynamic>();
        
        var iterator : IIterator = _test.getIterator();
        while (iterator.hasNext())
        {
            returnedItems.push(iterator.next());
        }
        
        assertTrue(_test.validateItems(returnedItems, items));
    }
}

