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

import flash.errors.ArgumentError;
import flash.errors.Error;
import org.as3commons.collections.framework.IComparator;
import org.as3commons.collections.framework.ISortOrder;
import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
import org.as3commons.collections.testhelpers.CollectionTest;
import org.as3commons.collections.testhelpers.TestComparator;
import org.as3commons.collections.testhelpers.TestItems;
import org.as3commons.collections.utils.NullComparator;
import org.as3commons.collections.utils.NumericComparator;

/**
	 * @author Jens Struwe 19.03.2010
	 */
class ISortOrderTests extends IOrderTests
{
    private var _sortOrder(get, never) : ITestSortOrder;

    
    public function new(test : AbstractCollectionTestCase)
    {
        super(test);
    }
    
    private function get__sortOrder() : ITestSortOrder
    {
        return try cast(_test.collection, ITestSortOrder) catch(e:Dynamic) null;
    }
    
    /*
		 * Initial state
		 */
    
    public function test_init_sortOrder() : Void
    {
        assertTrue(Std.is(_sortOrder, ISortOrder));
    }
    
    /*
		 * Test add
		 */
    
    public function test_add() : Void
    {
        _sortOrder.addMock(TestItems.object1);
        assertTrue(_test.validateTestItemsStrictly([1]));
        
        _sortOrder.addMock(TestItems.object6);
        assertTrue(_test.validateTestItemsStrictly([1, 6]));
        
        _sortOrder.addMock(TestItems.object3);
        assertTrue(_test.validateTestItemsStrictly([1, 3, 6]));
        
        _sortOrder.addMock(TestItems.object2);
        assertTrue(_test.validateTestItemsStrictly([1, 2, 3, 6]));
        
        _sortOrder.addMock(TestItems.object4);
        assertTrue(_test.validateTestItemsStrictly([1, 2, 3, 4, 6]));
        
        _sortOrder.addMock(TestItems.object5);
        assertTrue(_test.validateTestItemsStrictly([1, 2, 3, 4, 5, 6]));
    }
    
    /*
		 * Test hasEqual
		 */
    
    public function test_hasEqual() : Void
    {
        TestItems.object2["index"] = 1;
        
        _sortOrder.addMock(TestItems.object1);
        
        assertTrue(_sortOrder.has(TestItems.object1));
        assertFalse(_sortOrder.has(TestItems.object2));
        assertFalse(_sortOrder.has(TestItems.object3));
        
        assertTrue(_sortOrder.hasEqual(TestItems.object1));
        assertTrue(_sortOrder.hasEqual(TestItems.object2));
        assertFalse(_sortOrder.hasEqual(TestItems.object3));
    }
    
    /*
		 * Test lesser
		 */
    
    public function test_lesser() : Void
    {
        _test.fillCollection([4, 2, 7, 5, 1]);  // 1, 2, 4, 5, 7  
        
        assertTrue(null == _sortOrder.lesser(0));
        assertTrue(null == _sortOrder.lesser(1));
        assertEquals(2, _sortOrder.lesser(3));
        assertEquals(2, _sortOrder.lesser(4));
        assertEquals(4, _sortOrder.lesser(5));
        assertEquals(5, _sortOrder.lesser(6));
        assertEquals(5, _sortOrder.lesser(7));
        assertEquals(7, _sortOrder.lesser(8));
        assertEquals(7, _sortOrder.lesser(9));
    }
    
    public function test_lesser2() : Void
    {
        _test.fillCollection([1, 5, 8, 10, 14]);
        
        assertTrue(null == _sortOrder.lesser(0));
        assertTrue(null == _sortOrder.lesser(1));
        assertEquals(1, _sortOrder.lesser(2));
        assertEquals(8, _sortOrder.lesser(9));
        assertEquals(8, _sortOrder.lesser(10));
        assertEquals(10, _sortOrder.lesser(11));
        assertEquals(10, _sortOrder.lesser(13));
        assertEquals(10, _sortOrder.lesser(14));
        assertEquals(14, _sortOrder.lesser(15));
    }
    
    /*
		 * Test higher
		 */
    
    public function test_higher() : Void
    {
        _test.fillCollection([4, 2, 7, 5, 1]);  // 1, 2, 4, 5, 7  
        
        assertEquals(1, _sortOrder.higher(0));
        assertEquals(2, _sortOrder.higher(1));
        assertEquals(4, _sortOrder.higher(2));
        assertEquals(4, _sortOrder.higher(3));
        assertEquals(5, _sortOrder.higher(4));
        assertEquals(7, _sortOrder.higher(5));
        assertEquals(7, _sortOrder.higher(6));
        assertTrue(null == _sortOrder.higher(7));
        assertTrue(null == _sortOrder.higher(8));
    }
    
    public function test_higher2() : Void
    {
        _test.fillCollection([1, 5, 8, 10, 14]);
        
        assertEquals(1, _sortOrder.higher(0));
        assertEquals(5, _sortOrder.higher(1));
        assertEquals(5, _sortOrder.higher(2));
        assertEquals(5, _sortOrder.higher(4));
        assertEquals(8, _sortOrder.higher(5));
        assertEquals(8, _sortOrder.higher(6));
        assertEquals(14, _sortOrder.higher(13));
        assertTrue(null == _sortOrder.higher(14));
        assertTrue(null == _sortOrder.higher(15));
    }
    
    /*
		 * Test equal items
		 */
    
    public function test_equalItems() : Void
    {
        _test.fillCollection([1, 2, 3]);
        
        assertTrue(_test.validateItemsStrictly([1], _sortOrder.equalItems(1)));
        assertTrue(_test.validateItemsStrictly([2], _sortOrder.equalItems(2)));
        assertTrue(_test.validateItemsStrictly([3], _sortOrder.equalItems(3)));
    }
    
    /*
		 * Test remove
		 */
    
    public function test_remove_notContainedEqualItem() : Void
    {
        TestItems.object2["index"] = 1;
        
        _sortOrder.addMock(TestItems.object1);
        
        assertTrue(_sortOrder.has(TestItems.object1));
        assertFalse(_sortOrder.has(TestItems.object2));
        
        assertTrue(_sortOrder.hasEqual(TestItems.object1));
        assertTrue(_sortOrder.hasEqual(TestItems.object2));
        
        assertFalse(_sortOrder.remove(TestItems.object2));
        assertTrue(_sortOrder.remove(TestItems.object1));
        
        assertFalse(_sortOrder.has(TestItems.object1));
        assertFalse(_sortOrder.has(TestItems.object2));
        
        assertFalse(_sortOrder.hasEqual(TestItems.object1));
        assertFalse(_sortOrder.hasEqual(TestItems.object2));
    }
    
    /*
		 * Test setting / getting comparator
		 */
    
    public function test_constructor_without_args() : Void
    {
        var thrownError : ArgumentError;
        var sortOrder : ITestSortOrder;
        
        try
        {
            sortOrder = new;
        }
        catch (e : Error)
        {
            thrownError = try cast(e, ArgumentError) catch(e:Dynamic) null;
        }
        
        Assert.isNull(thrownError);
        assertTrue(Std.is(sortOrder, ITestSortOrder));
        assertEquals(Type.getClassName(sortOrder), Type.getClassName(_sortOrder));
    }
    
    public function test_constructor_without_args_sets_nullcomparator() : Void
    {
        var sortOrder : ITestSortOrder = new;
        Assert.isNotNull(sortOrder.comparator);
        assertTrue(Std.is(sortOrder.comparator, NullComparator));
    }
    
    public function test_set_comparator_without_items() : Void
    {
        assertTrue(Std.is(_sortOrder.comparator, TestComparator));
        
        var comparator : IComparator = new NumericComparator();
        
        _sortOrder.comparator = comparator;
        assertEquals(comparator, _sortOrder.comparator);
    }
    
    public function test_set_comparator_without_items2() : Void
    {
        _sortOrder.comparator = new NumericComparator();
        
        _test.fillCollection([7, 6, 9, 3, 1]);
        
        assertTrue(CollectionTest.itemsEqual(_sortOrder, [1, 3, 6, 7, 9]));
    }
    
    public function test_set_comparator_without_items3() : Void
    {
        assertTrue(Std.is(_sortOrder.comparator, TestComparator));
        _sortOrder.comparator = new NumericComparator();
        assertTrue(Std.is(_sortOrder.comparator, NumericComparator));
        _sortOrder.comparator = new TestComparator();
        assertTrue(Std.is(_sortOrder.comparator, TestComparator));
    }
    
    public function test_set_comparator_with_items() : Void
    {
        _test.fillCollection([1, 5, 8, 10, 14]);
        
        var thrownError : Error;
        try
        {
            _sortOrder.comparator = new NumericComparator();
        }
        catch (e : Error)
        {
            thrownError = e;
        }
        
        Assert.isNotNull(thrownError);
        assertTrue(Std.is(thrownError, ArgumentError));
    }
}

