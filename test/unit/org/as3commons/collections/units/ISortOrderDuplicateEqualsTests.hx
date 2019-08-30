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
import org.as3commons.collections.framework.ISortOrder;
import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
import org.as3commons.collections.testhelpers.TestItems;

/**
	 * @author Jens Struwe 19.03.2010
	 */
class ISortOrderDuplicateEqualsTests extends ISortOrderTests
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
    
    public function test_init_sortOrderEquals() : Void
    {
        assertTrue(Std.is(_sortOrder, ISortOrder));
        assertTrue(Std.is(_sortOrder, ITestSortOrderDuplicateEquals));
    }
    
    /*
		 * Test add
		 */
    
    public function test_add_isStable() : Void
    {
        TestItems.object2["index"] = 1;
        TestItems.object3["index"] = 1;
        TestItems.object4["index"] = 1;
        TestItems.object5["index"] = 1;
        TestItems.object6["index"] = 1;
        TestItems.object7["index"] = 1;
        TestItems.object8["index"] = 1;
        TestItems.object9["index"] = 1;
        TestItems.object10["index"] = 1;
        
        _test.fillCollection(TestItems.itemArrayByIndices([8, 1, 3, 2, 7, 10, 4, 5, 9, 6]));
        
        assertTrue(_test.validateTestItemsStrictly([8, 1, 3, 2, 7, 10, 4, 5, 9, 6]));
    }
    
    public function test_add_isStable2() : Void
    // function and xml are sorted only by their type
    {
        
        
        var func1 : Function = function() : Void
        {
        }
        var func2 : Function = function() : Void
        {
        }
        var func3 : Function = function() : Void
        {
        }
        var xml1 : FastXML = new FastXML();
        var xml2 : FastXML = new FastXML();
        
        _test.fillCollection([1, func3, xml2, 4, func1, 2, TestItems.object1, func2, 3, xml1, "one"]);
        
        assertTrue(_test.validateItemsStrictly([1, 2, 3, 4, "one", func3, func1, func2, xml2, xml1, TestItems.object1]));
    }
    
    /*
		 * Test equal items
		 */
    
    public function test_equalItems_duplicateEquals() : Void
    {
        TestItems.object2["index"] = 1;
        TestItems.object3["index"] = 1;
        TestItems.object4["index"] = 2;
        TestItems.object5["index"] = 2;
        TestItems.object6["index"] = 2;
        TestItems.object7["index"] = 3;
        TestItems.object8["index"] = 3;
        TestItems.object9["index"] = 3;
        
        _test.fillCollection(TestItems.itemArray(9));
        
        assertTrue(_test.validateItemsStrictly(TestItems.itemArrayByIndices([1, 2, 3]), _sortOrder.equalItems(TestItems.object1)));
        assertTrue(_test.validateItemsStrictly(TestItems.itemArrayByIndices([4, 5, 6]), _sortOrder.equalItems(TestItems.object4)));
        assertTrue(_test.validateItemsStrictly(TestItems.itemArrayByIndices([7, 8, 9]), _sortOrder.equalItems(TestItems.object7)));
    }
    
    /*
		 * Test remove
		 */
    
    public function test_remove_isStable() : Void
    {
        TestItems.object2["index"] = 1;
        TestItems.object3["index"] = 1;
        TestItems.object4["index"] = 1;
        TestItems.object5["index"] = 1;
        TestItems.object6["index"] = 1;
        TestItems.object7["index"] = 1;
        TestItems.object8["index"] = 1;
        TestItems.object9["index"] = 1;
        TestItems.object10["index"] = 1;
        
        _test.fillCollection(TestItems.itemArrayByIndices([8, 1, 3, 2, 7, 10, 4, 5, 9, 6]));
        
        _test.collection.remove(TestItems.object3);
        assertTrue(_test.validateTestItemsStrictly([8, 1, 2, 7, 10, 4, 5, 9, 6]));
        
        _test.collection.remove(TestItems.object10);
        assertTrue(_test.validateTestItemsStrictly([8, 1, 2, 7, 4, 5, 9, 6]));
        
        _test.collection.remove(TestItems.object8);
        assertTrue(_test.validateTestItemsStrictly([1, 2, 7, 4, 5, 9, 6]));
        
        _test.collection.remove(TestItems.object6);
        assertTrue(_test.validateTestItemsStrictly([1, 2, 7, 4, 5, 9]));
    }
    
    public function test_remove_isStable2() : Void
    // function and xml are sorted only by their type
    {
        
        
        var func1 : Function = function() : Void
        {
        }
        var func2 : Function = function() : Void
        {
        }
        var func3 : Function = function() : Void
        {
        }
        var xml1 : FastXML = new FastXML();
        var xml2 : FastXML = new FastXML();
        
        _test.fillCollection([1, func3, xml2, 4, func1, 2, TestItems.object1, func2, 3, xml1, "one"]);
        
        _test.collection.remove(func1);
        assertTrue(_test.validateItemsStrictly([1, 2, 3, 4, "one", func3, func2, xml2, xml1, TestItems.object1]));
        
        _test.collection.remove(xml2);
        assertTrue(_test.validateItemsStrictly([1, 2, 3, 4, "one", func3, func2, xml1, TestItems.object1]));
        
        _test.collection.remove(func3);
        assertTrue(_test.validateItemsStrictly([1, 2, 3, 4, "one", func2, xml1, TestItems.object1]));
        
        _test.collection.remove(func2);
        assertTrue(_test.validateItemsStrictly([1, 2, 3, 4, "one", xml1, TestItems.object1]));
    }
}

