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

import org.as3commons.collections.framework.IList;
import org.as3commons.collections.framework.IListIterator;
import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
import org.as3commons.collections.testhelpers.TestItems;

/**
	 * @author Jens Struwe 18.03.2010
	 */
class IListTests extends ICollectionTests
{
    private var _list(get, never) : IList;

    
    public function new(test : AbstractCollectionTestCase)
    {
        super(test);
    }
    
    private function get__list() : IList
    {
        return try cast(_test.collection, IList) catch(e:Dynamic) null;
    }
    
    /*
		 * Units
		 */
    
    /*
		 * Duplicates tests
		 */
    
    public function test_duplicates() : Void
    {
        new IDuplicatesTests(_test).runAllTests();
    }
    
    /*
		 * IList
		 */
    
    /*
		 * Initial state
		 */
    
    public function test_init_list() : Void
    {
        assertTrue(Std.is(_test.collection, IList));
    }
    
    /*
		 * Test iterator
		 */
    
    public function test_iterator_list() : Void
    {
        assertTrue(Std.is(_test.collection.iterator(), IListIterator));
    }
    
    /*
		 * Set array
		 */
    
    public function test_array_withEmptyList() : Void
    {
        assertEquals(0, _list.size);
        assertTrue(_test.validateItems([]));
        
        var items : Array<Dynamic> = TestItems.itemArrayByIndices([2, 6, 4, 1, 9]);
        
        _list.array = items;
        
        assertEquals(5, _list.size);
        assertTrue(_test.validateItems(items));
    }
    
    public function test_array() : Void
    {
        _test.fillCollection(TestItems.itemArrayByIndices([1, 3, 2]));
        
        assertEquals(3, _list.size);
        assertTrue(_test.validateTestItems([1, 3, 2]));
        
        var items : Array<Dynamic> = TestItems.itemArrayByIndices([2, 6, 4, 1, 9]);
        
        _list.array = items;
        
        assertEquals(5, _list.size);
        assertTrue(_test.validateItems(items));
    }
    
    public function test_array_setsCopy() : Void
    {
        assertEquals(0, _list.size);
        
        var items : Array<Dynamic> = TestItems.itemArrayByIndices([2, 6, 4, 1, 9]);
        
        _list.array = items;
        
        items.splice(0, 2);
        
        assertEquals(3, items.length);
        
        assertEquals(5, _list.size);
        assertTrue(_test.validateTestItems([2, 6, 4, 1, 9]));
    }
    
    /*
		 * Test first index of
		 */
    
    public function test_firstIndexOf_withEmptyCollection() : Void
    {
        assertEquals(-1, _list.firstIndexOf(TestItems.object1));
    }
    
    public function test_firstIndexOf_withWrongItem() : Void
    {
        _test.fillCollection(TestItems.itemArray(3));
        
        assertEquals(-1, _list.firstIndexOf(TestItems.object4));
    }
    
    public function test_firstIndexOf() : Void
    {
        _test.fillCollection(TestItems.itemArray(3));
        
        assertEquals(0, _list.firstIndexOf(TestItems.object1));
        assertEquals(1, _list.firstIndexOf(TestItems.object2));
        assertEquals(2, _list.firstIndexOf(TestItems.object3));
    }
    
    public function test_firstIndexOf_withNull() : Void
    {
        _test.fillCollection([null, null, null, TestItems.object1, TestItems.object2, TestItems.object3]);
        
        assertEquals(0, _list.firstIndexOf(null));
    }
    
    /*
		 * Test last index of
		 */
    
    public function test_lastIndexOf_withEmptyCollection() : Void
    {
        assertEquals(-1, _list.lastIndexOf(TestItems.object1));
    }
    
    public function test_lastIndexOf_withWrongItem() : Void
    {
        _test.fillCollection(TestItems.itemArray(3));
        
        assertEquals(-1, _list.lastIndexOf(TestItems.object4));
    }
    
    public function test_lastIndexOf() : Void
    {
        _test.fillCollection(TestItems.itemArray(3));
        
        assertEquals(0, _list.lastIndexOf(TestItems.object1));
        assertEquals(1, _list.lastIndexOf(TestItems.object2));
        assertEquals(2, _list.lastIndexOf(TestItems.object3));
        
        _test.fillCollection(TestItems.itemArrayByIndices([1, 1, 2, 3]));
        assertEquals(1, _list.lastIndexOf(TestItems.object1));
        
        _test.fillCollection(TestItems.itemArrayByIndices([1, 1, 1, 2, 3]));
        assertEquals(2, _list.lastIndexOf(TestItems.object1));
        
        _test.fillCollection(TestItems.itemArrayByIndices([1, 1, 1, 2, 2, 3]));
        assertEquals(4, _list.lastIndexOf(TestItems.object2));
    }
    
    public function test_lastIndexOf_withNull() : Void
    {
        _test.fillCollection([null, null, null, TestItems.object1, TestItems.object2, TestItems.object3]);
        
        assertEquals(2, _list.lastIndexOf(null));
    }
    
    /*
		 * Test item at
		 */
    
    public function test_itemAt() : Void
    {
        _test.fillCollection(TestItems.itemArray(3));
        
        assertEquals(TestItems.object1, _list.itemAt(0));
        assertEquals(TestItems.object2, _list.itemAt(1));
        assertEquals(TestItems.object3, _list.itemAt(2));
    }
    
    public function test_itemAt_withEmptyCollection() : Void
    {
        assertTrue(_list.itemAt(0) == null);
    }
    
    public function test_itemAt_withWrongIndex() : Void
    {
        _test.fillCollection(TestItems.itemArray(3));
        
        assertTrue(_list.itemAt(3) == null);
    }
    
    /*
		 * Test remove at
		 */
    
    public function test_removeAt() : Void
    {
        _test.fillCollection(TestItems.itemArray(3));
        assertEquals(3, _list.size);
        
        assertStrictlyEquals(TestItems.object2, _list.removeAt(1));
        assertEquals(2, _list.size);
        assertTrue(_test.validateTestItems([1, 3]));
        
        assertEquals(TestItems.object1, _list.itemAt(0));
        assertEquals(TestItems.object3, _list.itemAt(1));
        assertTrue(_list.itemAt(2) == null);
    }
    
    public function test_removeAt_start() : Void
    {
        _test.fillCollection(TestItems.itemArray(3));
        assertEquals(3, _list.size);
        
        assertStrictlyEquals(TestItems.object1, _list.removeAt(0));
        assertEquals(2, _list.size);
        assertTrue(_test.validateTestItems([2, 3]));
        
        assertEquals(TestItems.object2, _list.itemAt(0));
        assertEquals(TestItems.object3, _list.itemAt(1));
        assertTrue(_list.itemAt(2) == null);
    }
    
    public function test_removeAt_end() : Void
    {
        _test.fillCollection(TestItems.itemArray(3));
        assertEquals(3, _list.size);
        
        assertStrictlyEquals(TestItems.object3, _list.removeAt(2));
        assertEquals(2, _list.size);
        assertTrue(_test.validateTestItems([1, 2]));
        
        assertEquals(TestItems.object1, _list.itemAt(0));
        assertEquals(TestItems.object2, _list.itemAt(1));
        assertTrue(_list.itemAt(2) == null);
    }
    
    public function test_removeAt_withEmptyCollection() : Void
    {
        assertTrue(_list.removeAt(0) == null);
    }
    
    public function test_removeAt_withWrongIndex() : Void
    {
        _test.fillCollection(TestItems.itemArray(3));
        
        assertTrue(_list.removeAt(3) == null);
        assertEquals(3, _list.size);
    }
    
    /*
		 * Test remove all at
		 */
    
    public function test_removeAllAt() : Void
    {
        _test.fillCollection(TestItems.itemArray(5));
        
        assertTrue(_test.validateTestItems([2, 3], _list.removeAllAt(1, 2)));
        assertEquals(3, _list.size);
        
        assertEquals(TestItems.object1, _list.itemAt(0));
        assertEquals(TestItems.object4, _list.itemAt(1));
        assertTrue(_list.itemAt(3) == null);
        
        assertTrue(_test.validateTestItems([1, 4, 5]));
    }
    
    public function test_removeAllAt_start() : Void
    {
        _test.fillCollection(TestItems.itemArray(5));
        assertEquals(5, _list.size);
        
        assertTrue(_test.validateTestItems([1, 2, 3], _list.removeAllAt(0, 3)));
        assertEquals(2, _list.size);
        assertTrue(_test.validateTestItems([4, 5]));
        
        assertEquals(TestItems.object4, _list.itemAt(0));
        assertEquals(TestItems.object5, _list.itemAt(1));
        assertTrue(_list.itemAt(2) == null);
    }
    
    public function test_removeAllAt_end() : Void
    {
        _test.fillCollection(TestItems.itemArray(5));
        assertEquals(5, _list.size);
        
        assertTrue(_test.validateTestItems([3, 4, 5], _list.removeAllAt(2, 3)));
        assertEquals(2, _list.size);
        assertTrue(_test.validateTestItems([1, 2]));
        
        assertEquals(TestItems.object1, _list.itemAt(0));
        assertEquals(TestItems.object2, _list.itemAt(1));
        assertTrue(_list.itemAt(2) == null);
    }
    
    public function test_removeAllAt_withWrongIndex() : Void
    {
        _test.fillCollection(TestItems.itemArray(3));
        
        assertTrue(_test.validateItems([], _list.removeAllAt(3, 1)));
        assertEquals(3, _list.size);
    }
    
    public function test_removeAllAt_withExceedingNumberOfItems() : Void
    {
        _test.fillCollection(TestItems.itemArray(5));
        
        assertTrue(_test.validateTestItems([4, 5], _list.removeAllAt(3, 10)));
        assertEquals(3, _list.size);
        
        assertEquals(TestItems.object1, _list.itemAt(0));
        assertEquals(TestItems.object2, _list.itemAt(1));
        assertEquals(TestItems.object3, _list.itemAt(2));
        assertTrue(_list.itemAt(3) == null);
        
        assertTrue(_test.validateTestItems([1, 2, 3]));
    }
    
    public function test_removeAllAt_withZeroNumberOfItems() : Void
    {
        _test.fillCollection(TestItems.itemArray(3));
        
        assertTrue(_test.validateItems([], _list.removeAllAt(1, 0)));
        assertEquals(3, _list.size);
        assertTrue(_test.validateTestItems([1, 2, 3]));
    }
    
    /*
		 * Specialised unit tests
		 */
    
    /*
		 * Test add
		 */
    
    public function test_add_singleItem_returnValue() : Void
    {
        assertEquals(0, _list.add(TestItems.object1));
        assertEquals(1, _list.add(TestItems.object2));
        assertEquals(2, _list.add(TestItems.object3));
    }
    
    public function test_add_duplicates_returnValue() : Void
    {
        var index : Int = _list.add(TestItems.object2);
        assertTrue(TestItems.object2 == _list.itemAt(index));
        
        index = _list.add(TestItems.object4);
        assertTrue(TestItems.object4 == _list.itemAt(index));
        
        index = _list.add(TestItems.object2);
        assertTrue(TestItems.object2 == _list.itemAt(index));
        
        index = _list.add(TestItems.object1);
        assertTrue(TestItems.object1 == _list.itemAt(index));
        
        index = _list.add(TestItems.object3);
        assertTrue(TestItems.object3 == _list.itemAt(index));
        
        index = _list.add(TestItems.object1);
        assertTrue(TestItems.object1 == _list.itemAt(index));
    }
    
    public function test_add_null_returnValue() : Void
    {
        var index : Int = _list.add(TestItems.object2);
        assertTrue(TestItems.object2 == _list.itemAt(index));
        
        index = _list.add(null);
        assertTrue(null == _list.itemAt(index));
        
        index = _list.add(null);
        assertTrue(null == _list.itemAt(index));
        
        index = _list.add(TestItems.object1);
        assertTrue(TestItems.object1 == _list.itemAt(index));
    }
}

