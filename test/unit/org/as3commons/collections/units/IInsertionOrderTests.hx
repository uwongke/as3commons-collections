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

import org.as3commons.collections.framework.IInsertionOrder;
import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
import org.as3commons.collections.testhelpers.TestComparator;
import org.as3commons.collections.testhelpers.TestItems;
import org.as3commons.collections.utils.NullComparator;

/**
	 * @author Jens Struwe 18.03.2010
	 */
class IInsertionOrderTests extends IOrderTests
{
    private var _insertionOrder(get, never) : ITestInsertionOrder;

    
    public function new(test : AbstractCollectionTestCase)
    {
        super(test);
    }
    
    private function get__insertionOrder() : ITestInsertionOrder
    {
        return try cast(_test.collection, ITestInsertionOrder) catch(e:Dynamic) null;
    }
    
    /*
		 * Initial state
		 */
    
    public function test_init_insertionOrder() : Void
    {
        print("IInsertionOrderTests :: test_init_insertionOrder");

        assertTrue(Std.is(_insertionOrder, IInsertionOrder));
    }
    
    /*
		 * Test add first
		 */
    
    public function test_addFirst_withEmptyCollection() : Void
    {
        print("IInsertionOrderTests :: test_addFirst_withEmptyCollection");
        assertEquals(0, _insertionOrder.size);
        assertTrue(_insertionOrder.first == null);
        assertTrue(_insertionOrder.last == null);
        
        _insertionOrder.addFirstMock(TestItems.object1);
        assertEquals(1, _insertionOrder.size);
        assertStrictlyEquals(TestItems.object1, _insertionOrder.first);
        assertStrictlyEquals(TestItems.object1, _insertionOrder.last);
        
        _insertionOrder.addFirstMock(TestItems.object2);
        assertEquals(2, _insertionOrder.size);
        assertStrictlyEquals(TestItems.object2, _insertionOrder.first);
        assertStrictlyEquals(TestItems.object1, _insertionOrder.last);
    }
    
    public function test_addFirst() : Void
    {
        print("IInsertionOrderTests :: test_addFirst");
        _test.fillCollection(TestItems.itemArrayByIndices([3, 4, 5]));
        assertEquals(3, _insertionOrder.size);
        assertStrictlyEquals(TestItems.object3, _insertionOrder.first);
        
        _insertionOrder.addFirstMock(TestItems.object1);
        assertEquals(4, _insertionOrder.size);
        assertStrictlyEquals(TestItems.object1, _insertionOrder.first);
        
        _insertionOrder.addFirstMock(TestItems.object2);
        assertEquals(5, _insertionOrder.size);
        assertStrictlyEquals(TestItems.object2, _insertionOrder.first);
    }
    
    /*
		 * Test add last
		 */
    
    public function test_addLast_withEmptyCollection() : Void
    {
        print("IInsertionOrderTests :: test_addLast_withEmptyCollection");

        assertEquals(0, _insertionOrder.size);
        assertTrue(_insertionOrder.first == null);
        assertTrue(_insertionOrder.last == null);
        
        _insertionOrder.addLastMock(TestItems.object1);
        assertEquals(1, _insertionOrder.size);
        assertStrictlyEquals(TestItems.object1, _insertionOrder.first);
        assertStrictlyEquals(TestItems.object1, _insertionOrder.last);
        
        _insertionOrder.addLastMock(TestItems.object2);
        assertEquals(2, _insertionOrder.size);
        assertStrictlyEquals(TestItems.object1, _insertionOrder.first);
        assertStrictlyEquals(TestItems.object2, _insertionOrder.last);
    }
    
    public function test_addLast() : Void
    {
        print("IInsertionOrderTests :: test_addLast");
        _test.fillCollection(TestItems.itemArrayByIndices([1, 2, 3]));
        assertEquals(3, _insertionOrder.size);
        assertStrictlyEquals(TestItems.object3, _insertionOrder.last);
        
        _insertionOrder.addLastMock(TestItems.object5);
        assertEquals(4, _insertionOrder.size);
        assertStrictlyEquals(TestItems.object5, _insertionOrder.last);
        
        _insertionOrder.addLastMock(TestItems.object4);
        assertEquals(5, _insertionOrder.size);
        assertStrictlyEquals(TestItems.object4, _insertionOrder.last);
    }
    
    /*
		 * Test add first and last
		 */
    
    public function test_addFirst_andLast() : Void
    {
        print("IInsertionOrderTests :: test_addFirst_andLast");

        _insertionOrder.addFirstMock(TestItems.object1);
        _insertionOrder.addLastMock(TestItems.object2);
        _insertionOrder.addFirstMock(TestItems.object3);
        _insertionOrder.addLastMock(TestItems.object4);
        _insertionOrder.addLastMock(TestItems.object5);
        _insertionOrder.addFirstMock(TestItems.object6);
        _insertionOrder.addFirstMock(TestItems.object7);
        
        assertEquals(7, _insertionOrder.size);
        
        assertTrue(_test.validateTestItems([7, 6, 3, 1, 2, 4, 5]));
    }
    
    /*
		 * Test sort
		 */
    
    public function test_sort_withEmptyCollection() : Void
    {
        print("IInsertionOrderTests :: test_sort_withEmptyCollection");

        assertFalse(_insertionOrder.sort(new TestComparator()));
    }
    
    public function test_sort_withSingleItem() : Void
    {
        print("IInsertionOrderTests :: test_sort_withSingleItem");

        _test.fillCollection([TestItems.object1]);
        
        assertFalse(_insertionOrder.sort(new TestComparator()));
    }
    
    public function test_sort() : Void
    {
        print("IInsertionOrderTests :: test_sort");

        _test.fillCollection(TestItems.itemArrayByIndices([4, 1, 3, 6, 2]));
        
        assertTrue(_insertionOrder.sort(new TestComparator()));
        
        assertTrue(_test.validateTestItems([1, 2, 3, 4, 6]));
        assertTrue(_test.validateTestItemsReverse([1, 2, 3, 4, 6]));
        
        assertStrictlyEquals(TestItems.object1, _insertionOrder.first);
        assertStrictlyEquals(TestItems.object6, _insertionOrder.last);
    }
    
    public function test_sort2() : Void
    {
        print("IInsertionOrderTests :: test_sort2");
        _test.fillCollection(TestItems.itemArrayByIndices([1, 3, 2]));
        
        assertTrue(_insertionOrder.sort(new TestComparator()));
        
        assertTrue(_test.validateTestItems([1, 2, 3]));
        assertTrue(_test.validateTestItemsReverse([1, 2, 3]));
        
        assertStrictlyEquals(TestItems.object1, _insertionOrder.first);
        assertStrictlyEquals(TestItems.object3, _insertionOrder.last);
    }
    
    public function test_sort3() : Void
    {
        print("IInsertionOrderTests :: test_sort3");
        _test.fillCollection(TestItems.itemArrayByIndices([2, 1, 3]));
        
        assertTrue(_insertionOrder.sort(new TestComparator()));
        
        assertTrue(_test.validateTestItems([1, 2, 3]));
        assertTrue(_test.validateTestItemsReverse([1, 2, 3]));
        
        assertStrictlyEquals(TestItems.object1, _insertionOrder.first);
        assertStrictlyEquals(TestItems.object3, _insertionOrder.last);
    }
    
    public function test_sort4() : Void
    {
        print("IInsertionOrderTests :: test_sort4");
        _test.fillCollection(TestItems.itemArrayByIndices([2, 1]));
        
        assertTrue(_insertionOrder.sort(new TestComparator()));
        
        assertTrue(_test.validateTestItems([1, 2]));
        assertTrue(_test.validateTestItemsReverse([1, 2]));
        
        assertStrictlyEquals(TestItems.object1, _insertionOrder.first);
        assertStrictlyEquals(TestItems.object2, _insertionOrder.last);
    }
    
    public function test_sort_isStable() : Void
    {
        print("IInsertionOrderTests :: test_sort_isStable");
        _test.fillCollection([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
        
        assertTrue(_insertionOrder.sort(new NullComparator()));
        
        assertTrue(_test.validateItems([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]));
        
        assertTrue(_insertionOrder.sort(new NullComparator()));
        
        assertTrue(_test.validateItems([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]));
        
        assertStrictlyEquals(1, _insertionOrder.first);
        assertStrictlyEquals(10, _insertionOrder.last);
    }
    
    /*
		 * Reverse
		 */
    
    public function test_reverse_withEmptyCollection() : Void
    {
        print("IInsertionOrderTests :: test_reverse_withEmptyCollection");

        assertFalse(_insertionOrder.reverse());
    }
    
    public function test_reverse_withSingleItem() : Void
    {
        print("IInsertionOrderTests :: test_reverse_withSingleItem");
        _test.fillCollection([TestItems.object1]);
        assertFalse(_insertionOrder.reverse());
    }
    
    public function test_reverse() : Void
    {
        print("IInsertionOrderTests :: test_reverse");

        var items : Array<Dynamic> = TestItems.itemArray(4);
        _test.fillCollection(items);
        
        assertTrue(_insertionOrder.reverse());
        
        assertTrue(_test.validateTestItems([4, 3, 2, 1]));
        
        assertTrue(_insertionOrder.reverse());
        
        assertTrue(_test.validateItems(items));
    }
}

