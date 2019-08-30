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

import haxe.Constraints.Function;
import org.as3commons.collections.framework.IDuplicates;
import org.as3commons.collections.framework.IInsertionOrder;
import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
import org.as3commons.collections.testhelpers.TestComparator;
import org.as3commons.collections.testhelpers.TestItems;
import org.as3commons.collections.units.IInsertionOrderTests;

/**
	 * @author Jens Struwe 22.03.2010
	 */
class IInsertionOrderDuplicatesTests extends IInsertionOrderTests
{
    private var _duplicates(get, never) : ITestDuplicates;
    private var _insertionOrder2(get, never) : ITestInsertionOrder;

    
    public function new(test : AbstractCollectionTestCase)
    {
        super(test);
    }
    
    private function get__duplicates() : ITestDuplicates
    {
        return try cast(_test.collection, ITestDuplicates) catch(e:Dynamic) null;
    }
    
    private function get__insertionOrder2() : ITestInsertionOrder
    {
        return try cast(_test.collection, ITestInsertionOrder) catch(e:Dynamic) null;
    }
    
    /*
		 * Initial state
		 */
    
    public function test_init_duplicates() : Void
    {
        print("IInsertionOrderDuplicatesTests :: test_init_duplicates");
        assertTrue(Std.is(_test.collection, IDuplicates));
        assertTrue(Std.is(_test.collection, IInsertionOrder));
    }
    
    /*
		 * Test add
		 */
    
    public function test_add() : Void
    {
        print("IInsertionOrderDuplicatesTests :: test_add");

        _insertionOrder2.addLastMock(TestItems.object1);
        assertTrue(_test.validateTestItemsStrictly([1]));
        
        _insertionOrder2.addLastMock(TestItems.object1);
        assertTrue(_test.validateTestItemsStrictly([1, 1]));
        
        _insertionOrder2.addLastMock(TestItems.object6);
        assertTrue(_test.validateTestItemsStrictly([1, 1, 6]));
        
        _insertionOrder2.addLastMock(TestItems.object3);
        assertTrue(_test.validateTestItemsStrictly([1, 1, 6, 3]));
        
        _insertionOrder2.addLastMock(TestItems.object2);
        assertTrue(_test.validateTestItemsStrictly([1, 1, 6, 3, 2]));
        
        _insertionOrder2.addLastMock(TestItems.object1);
        assertTrue(_test.validateTestItemsStrictly([1, 1, 6, 3, 2, 1]));
        
        _insertionOrder2.addLastMock(TestItems.object3);
        assertTrue(_test.validateTestItemsStrictly([1, 1, 6, 3, 2, 1, 3]));
        
        _insertionOrder2.addLastMock(TestItems.object6);
        assertTrue(_test.validateTestItemsStrictly([1, 1, 6, 3, 2, 1, 3, 6]));
        
        _insertionOrder2.addLastMock(TestItems.object3);
        assertTrue(_test.validateTestItemsStrictly([1, 1, 6, 3, 2, 1, 3, 6, 3]));
    }
    
    /*
		 * Test sort
		 */
    
    public function test_sort_duplicates() : Void
    {
        print("IInsertionOrderDuplicatesTests :: test_sort_duplicates");
        _test.fillCollection(TestItems.itemArrayByIndices([4, 1, 4, 1, 3, 2, 2, 3, 1]));
        
        assertTrue(_insertionOrder2.sort(new TestComparator()));
        
        assertTrue(_test.validateTestItems([1, 1, 1, 2, 2, 3, 3, 4, 4]));
        
        assertStrictlyEquals(TestItems.object1, _insertionOrder2.first);
        assertStrictlyEquals(TestItems.object4, _insertionOrder2.last);
    }
    
    public function test_sort_isStable_duplicates() : Void
    {
        print("IInsertionOrderDuplicatesTests :: test_sort_isStable_duplicates");
        Reflect.setField(TestItems.object2, "index",  1);
        Reflect.setField(TestItems.object3, "index",  1);
        Reflect.setField(TestItems.object4, "index",  2);
        
        _test.fillCollection(TestItems.itemArrayByIndices([4, 1, 4, 3, 2, 2, 3, 1, 3, 1, 4]));
        
        assertTrue(_insertionOrder2.sort(new TestComparator()));
        
        assertTrue(_test.validateTestItems([1, 3, 2, 2, 3, 1, 3, 1, 4, 4, 4]));
        
        assertTrue(_insertionOrder2.sort(new TestComparator()));
        
        assertTrue(_test.validateTestItems([1, 3, 2, 2, 3, 1, 3, 1, 4, 4, 4]));
        
        assertStrictlyEquals(TestItems.object1, _insertionOrder2.first);
        assertStrictlyEquals(TestItems.object4, _insertionOrder2.last);
    }
    
    /*
		 * Test remove
		 */
    
    public function test_remove() : Void
    // functions are sorted only by their type
    {

        print("IInsertionOrderDuplicatesTests :: test_remove");
        var func1 : Function = function() : Void
        {
        }
        var func2 : Function = function() : Void
        {
        }
        var func3 : Function = function() : Void
        {
        }
        
        _test.fillCollection([1, func3, func2, func2, "one", func1, 2, TestItems.object1, func2, 3, func3, "one"]);
        
        assertTrue(_test.validateItemsStrictly([1, func3, func2, func2, "one", func1, 2, TestItems.object1, func2, 3, func3, "one"]));
        
        assertTrue(_duplicates.remove("one"));
        assertTrue(_test.validateItemsStrictly([1, func3, func2, func2, func1, 2, TestItems.object1, func2, 3, func3, "one"]));
        
        assertTrue(_duplicates.remove(1));
        assertTrue(_test.validateItemsStrictly([func3, func2, func2, func1, 2, TestItems.object1, func2, 3, func3, "one"]));
        
        assertTrue(_duplicates.remove(func1));
        assertTrue(_test.validateItemsStrictly([func3, func2, func2, 2, TestItems.object1, func2, 3, func3, "one"]));
        
        assertTrue(_duplicates.remove(func2));
        assertTrue(_test.validateItemsStrictly([func3, func2, 2, TestItems.object1, func2, 3, func3, "one"]));
        
        assertTrue(_duplicates.remove(func3));
        assertTrue(_test.validateItemsStrictly([func2, 2, TestItems.object1, func2, 3, func3, "one"]));
    }
    
    /*
		 * Test remove all
		 */
    
    public function test_removeAll() : Void
    // functions are sorted only by their type
    {
        print("IInsertionOrderDuplicatesTests :: test_removeAll");



        var func1 : Function = function() : Void
        {
        }
        var func2 : Function = function() : Void
        {
        }
        var func3 : Function = function() : Void
        {
        }
        
        _test.fillCollection([1, func3, func2, func2, "one", func1, 2, TestItems.object1, func2, 3, func3, "one"]);
        
        assertTrue(_test.validateItemsStrictly([1, func3, func2, func2, "one", func1, 2, TestItems.object1, func2, 3, func3, "one"]));
        
        assertEquals(2, _duplicates.removeAll("one"));
        assertTrue(_test.validateItemsStrictly([1, func3, func2, func2, func1, 2, TestItems.object1, func2, 3, func3]));
        
        assertEquals(1, _duplicates.removeAll(1));
        assertTrue(_test.validateItemsStrictly([func3, func2, func2, func1, 2, TestItems.object1, func2, 3, func3]));
        
        assertEquals(1, _duplicates.removeAll(func1));
        assertTrue(_test.validateItemsStrictly([func3, func2, func2, 2, TestItems.object1, func2, 3, func3]));
        
        assertEquals(3, _duplicates.removeAll(func2));
        assertTrue(_test.validateItemsStrictly([func3, 2, TestItems.object1, 3, func3]));
        
        assertEquals(2, _duplicates.removeAll(func3));
        assertTrue(_test.validateItemsStrictly([2, TestItems.object1, 3]));
    }

    public function runAllTests()
    {

    }
}

