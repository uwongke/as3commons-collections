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
package org.as3commons.collections.units;

import org.as3commons.collections.framework.IOrder;
import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
import org.as3commons.collections.testhelpers.AbstractCollectionUnitTestCase;
import org.as3commons.collections.testhelpers.TestItems;

/**
	 * @author Jens Struwe 18.03.2010
	 */
class IOrderTests extends AbstractCollectionUnitTestCase
{
    private var _order(get, never) : ITestOrder;

    
    public function new(test : AbstractCollectionTestCase)
    {
        super(test);
    }
    
    private function get__order() : ITestOrder
    {
        return try cast(_test.collection, ITestOrder) catch(e:Dynamic) null;
    }
    
    /*
		 * Initial state
		 */
    
    public function test_init() : Void
    {
        assertTrue(Std.is(_order, IOrder));
    }
    
    /*
		 * Test get first
		 */
    
    public function test_first_withEmptyCollection() : Void
    {
        assertTrue(_order.first == null);
    }
    
    public function test_first() : Void
    {
        _test.fillCollection(TestItems.itemArray(4));
        
        assertStrictlyEquals(TestItems.object1, _order.first);
    }
    
    public function test_first2() : Void
    {
        _test.fillCollection(TestItems.itemArrayByIndices([3, 4, 5]));
        
        assertStrictlyEquals(TestItems.object3, _order.first);
        
        _test.fillCollection(TestItems.itemArrayByIndices([2, 3, 4, 5]));
        assertStrictlyEquals(TestItems.object2, _order.first);
        
        _test.fillCollection(TestItems.itemArrayByIndices([1, 2, 3, 4, 5]));
        assertStrictlyEquals(TestItems.object1, _order.first);
    }
    
    /*
		 * Test get last
		 */
    
    public function test_last_withEmptyCollection() : Void
    {
        assertTrue(_order.last == null);
    }
    
    public function test_last() : Void
    {
        _test.fillCollection(TestItems.itemArray(4));
        
        assertStrictlyEquals(TestItems.object4, _order.last);
    }
    
    public function test_last2() : Void
    {
        _test.fillCollection(TestItems.itemArrayByIndices([1, 2, 3]));
        assertStrictlyEquals(TestItems.object3, _order.last);
        
        _test.fillCollection(TestItems.itemArrayByIndices([1, 2, 3, 4]));
        assertStrictlyEquals(TestItems.object4, _order.last);
        
        _test.fillCollection(TestItems.itemArrayByIndices([1, 2, 3, 4, 5]));
        assertStrictlyEquals(TestItems.object5, _order.last);
    }
    
    /*
		 * Test get first and last
		 */
    
    public function test_firstAndLast() : Void
    {
        assertTrue(_order.first == null);
        assertTrue(_order.last == null);
        
        _test.fillCollection([TestItems.object1]);
        assertStrictlyEquals(TestItems.object1, _order.first);
        assertStrictlyEquals(TestItems.object1, _order.last);
        
        _test.fillCollection([TestItems.object1, TestItems.object2]);
        assertStrictlyEquals(TestItems.object1, _order.first);
        assertStrictlyEquals(TestItems.object2, _order.last);
    }
    
    /*
		 * Test remove first
		 */
    
    public function test_removeFirst_withEmptyCollection() : Void
    {
        assertTrue(_order.removeFirst() == null);
    }
    
    public function test_removeFirst() : Void
    {
        _test.fillCollection(TestItems.itemArray(3));
        
        assertEquals(3, _order.size);
        assertStrictlyEquals(TestItems.object1, _order.first);
        assertStrictlyEquals(TestItems.object1, _order.removeFirst());
        assertFalse(_test.collection.has(TestItems.object1));
        
        assertEquals(2, _order.size);
        assertStrictlyEquals(TestItems.object2, _order.first);
        assertStrictlyEquals(TestItems.object2, _order.removeFirst());
        assertFalse(_test.collection.has(TestItems.object2));
        
        assertEquals(1, _order.size);
        assertStrictlyEquals(TestItems.object3, _order.first);
        assertStrictlyEquals(TestItems.object3, _order.removeFirst());
        assertFalse(_test.collection.has(TestItems.object3));
        
        assertEquals(0, _order.size);
        assertTrue(_order.first == null);
        assertTrue(_order.removeFirst() == null);
    }
    
    /*
		 * Test remove last
		 */
    
    public function test_removeLast_withEmptyCollection() : Void
    {
        assertTrue(_order.removeLast() == null);
    }
    
    public function test_removeLast() : Void
    {
        _test.fillCollection(TestItems.itemArray(3));
        
        assertEquals(3, _order.size);
        assertStrictlyEquals(TestItems.object3, _order.last);
        assertStrictlyEquals(TestItems.object3, _order.removeLast());
        assertFalse(_test.collection.has(TestItems.object3));
        
        assertEquals(2, _order.size);
        assertStrictlyEquals(TestItems.object2, _order.last);
        assertStrictlyEquals(TestItems.object2, _order.removeLast());
        assertFalse(_test.collection.has(TestItems.object2));
        
        assertEquals(1, _order.size);
        assertStrictlyEquals(TestItems.object1, _order.last);
        assertStrictlyEquals(TestItems.object1, _order.removeLast());
        assertFalse(_test.collection.has(TestItems.object1));
        
        assertEquals(0, _order.size);
        assertTrue(_order.last == null);
        assertTrue(_order.removeLast() == null);
    }
    
    /*
		 * Test remove first and last
		 */
    
    public function test_removeFirstAndLast() : Void
    {
        _test.fillCollection(TestItems.itemArray(3));
        
        assertEquals(3, _order.size);
        assertStrictlyEquals(TestItems.object1, _order.first);
        assertStrictlyEquals(TestItems.object3, _order.last);
        
        assertStrictlyEquals(TestItems.object1, _order.removeFirst());
        assertStrictlyEquals(TestItems.object3, _order.removeLast());
        assertFalse(_test.collection.has(TestItems.object1));
        assertFalse(_test.collection.has(TestItems.object3));
        
        assertEquals(1, _order.size);
        assertStrictlyEquals(TestItems.object2, _order.first);
        assertStrictlyEquals(TestItems.object2, _order.last);
        
        assertStrictlyEquals(TestItems.object2, _order.removeFirst());
        assertFalse(_test.collection.has(TestItems.object2));
        
        assertEquals(0, _order.size);
        assertTrue(_order.first == null);
        assertTrue(_order.last == null);
        
        _test.fillCollection([TestItems.object2]);
        
        assertEquals(1, _order.size);
        assertStrictlyEquals(TestItems.object2, _order.first);
        assertStrictlyEquals(TestItems.object2, _order.last);
        
        assertStrictlyEquals(TestItems.object2, _order.removeLast());
        
        assertEquals(0, _order.size);
        assertTrue(_order.first == null);
        assertTrue(_order.last == null);
    }
}

