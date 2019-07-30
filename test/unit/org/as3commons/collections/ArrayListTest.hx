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
package org.as3commons.collections;

import org.as3commons.collections.framework.ICollection;
import org.as3commons.collections.framework.IOrderedList;
import org.as3commons.collections.mocks.ArrayListMock;
import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
import org.as3commons.collections.testhelpers.TestItems;
import org.as3commons.collections.units.IInsertionOrderDuplicatesTests;
import org.as3commons.collections.units.IListTests;

/**
	 * @author Jens Struwe 18.03.2010
	 */
class ArrayListTest extends AbstractCollectionTestCase
{
    private var _arrayList(get, never) : IOrderedList;

    
    /*
		 * AbstractCollectionTest
		 */
    
    override public function createCollection() : ICollection
    {
        return new ArrayListMock();
    }
    
    override public function fillCollection(items : Array<Dynamic>) : Void
    {
        cast((collection), IOrderedList).array = items;
    }
    
    private function get__arrayList() : IOrderedList
    {
        return try cast(collection, IOrderedList) catch(e:Dynamic) null;
    }
    
    /*
		 * Units
		 */
    
    /*
		 * List tests
		 */
    
    public function test_list() : Void
    {
        new IListTests(this).runAllTests();
    }
    
    /*
		 * Order tests
		 */
    
    public function test_order() : Void
    {
        new IInsertionOrderDuplicatesTests(this).runAllTests();
    }
    
    /*
		 * IOrderedList
		 */
    
    /*
		 * Initial state
		 */
    
    public function test_init() : Void
    {
        assertTrue(Std.is(_arrayList, IOrderedList));
    }
    
    /*
		 * Test add at
		 */
    
    public function test_addAt() : Void
    {
        fillCollection(TestItems.itemArray(3));
        assertEquals(3, _arrayList.size);
        
        assertTrue(_arrayList.addAt(2, TestItems.object4));
        assertEquals(4, _arrayList.size);
        assertTrue(validateTestItems([1, 2, 4, 3]));
        assertEquals(TestItems.object1, _arrayList.itemAt(0));
        assertEquals(TestItems.object2, _arrayList.itemAt(1));
        assertEquals(TestItems.object4, _arrayList.itemAt(2));
        assertEquals(TestItems.object3, _arrayList.itemAt(3));
        
        assertTrue(_arrayList.addAt(1, TestItems.object5));
        assertEquals(5, _arrayList.size);
        assertTrue(validateTestItems([1, 5, 2, 4, 3]));
        assertEquals(TestItems.object1, _arrayList.itemAt(0));
        assertEquals(TestItems.object5, _arrayList.itemAt(1));
        assertEquals(TestItems.object2, _arrayList.itemAt(2));
        assertEquals(TestItems.object4, _arrayList.itemAt(3));
        assertEquals(TestItems.object3, _arrayList.itemAt(4));
    }
    
    public function test_addAt_withEmptyList() : Void
    {
        assertTrue(_arrayList.addAt(0, TestItems.object1));
        assertEquals(1, _arrayList.size);
        assertTrue(validateTestItems([1]));
        assertEquals(TestItems.object1, _arrayList.itemAt(0));
    }
    
    public function test_addAt_start() : Void
    {
        fillCollection(TestItems.itemArray(3));
        assertEquals(3, _arrayList.size);
        
        assertTrue(_arrayList.addAt(0, TestItems.object4));
        assertEquals(4, _arrayList.size);
        assertTrue(validateTestItems([4, 1, 2, 3]));
        assertEquals(TestItems.object4, _arrayList.itemAt(0));
        assertEquals(TestItems.object1, _arrayList.itemAt(1));
        assertEquals(TestItems.object2, _arrayList.itemAt(2));
        assertEquals(TestItems.object3, _arrayList.itemAt(3));
        
        assertTrue(_arrayList.addAt(0, TestItems.object5));
        assertEquals(5, _arrayList.size);
        assertTrue(validateTestItems([5, 4, 1, 2, 3]));
        assertEquals(TestItems.object5, _arrayList.itemAt(0));
        assertEquals(TestItems.object4, _arrayList.itemAt(1));
        assertEquals(TestItems.object1, _arrayList.itemAt(2));
        assertEquals(TestItems.object2, _arrayList.itemAt(3));
        assertEquals(TestItems.object3, _arrayList.itemAt(4));
    }
    
    public function test_addAt_end() : Void
    {
        fillCollection(TestItems.itemArray(3));
        assertEquals(3, _arrayList.size);
        
        assertTrue(_arrayList.addAt(3, TestItems.object4));
        assertEquals(4, _arrayList.size);
        assertTrue(validateTestItems([1, 2, 3, 4]));
        assertEquals(TestItems.object1, _arrayList.itemAt(0));
        assertEquals(TestItems.object2, _arrayList.itemAt(1));
        assertEquals(TestItems.object3, _arrayList.itemAt(2));
        assertEquals(TestItems.object4, _arrayList.itemAt(3));
        
        assertTrue(_arrayList.addAt(4, TestItems.object5));
        assertEquals(5, _arrayList.size);
        assertTrue(validateTestItems([1, 2, 3, 4, 5]));
        assertEquals(TestItems.object1, _arrayList.itemAt(0));
        assertEquals(TestItems.object2, _arrayList.itemAt(1));
        assertEquals(TestItems.object3, _arrayList.itemAt(2));
        assertEquals(TestItems.object4, _arrayList.itemAt(3));
        assertEquals(TestItems.object5, _arrayList.itemAt(4));
    }
    
    public function test_addAt_wrongIndex() : Void
    {
        fillCollection(TestItems.itemArray(2));
        
        assertFalse(_arrayList.addAt(10, TestItems.object3));
        assertEquals(2, _arrayList.size);
        assertTrue(validateTestItems([1, 2]));
        assertEquals(TestItems.object1, _arrayList.itemAt(0));
        assertEquals(TestItems.object2, _arrayList.itemAt(1));
    }
    
    public function test_addAt_wrongIndexWithEmptyList() : Void
    {
        assertFalse(_arrayList.addAt(10, TestItems.object3));
        assertEquals(0, _arrayList.size);
        assertTrue(validateItems([]));
    }
    
    /*
		 * Test add all at
		 */
    
    public function test_addAllAt() : Void
    {
        fillCollection(TestItems.itemArray(3));
        assertEquals(3, _arrayList.size);
        
        assertTrue(_arrayList.addAllAt(1, [TestItems.object4, TestItems.object5]));
        assertEquals(5, _arrayList.size);
        assertTrue(validateTestItems([1, 4, 5, 2, 3]));
        assertEquals(TestItems.object1, _arrayList.itemAt(0));
        assertEquals(TestItems.object4, _arrayList.itemAt(1));
        assertEquals(TestItems.object5, _arrayList.itemAt(2));
        assertEquals(TestItems.object2, _arrayList.itemAt(3));
        assertEquals(TestItems.object3, _arrayList.itemAt(4));
    }
    
    public function test_addAllAt_withEmptyList() : Void
    {
        assertTrue(_arrayList.addAllAt(0, [TestItems.object1, TestItems.object2]));
        assertEquals(2, _arrayList.size);
        assertTrue(validateTestItems([1, 2]));
        assertEquals(TestItems.object1, _arrayList.itemAt(0));
        assertEquals(TestItems.object2, _arrayList.itemAt(1));
    }
    
    public function test_addAllAt_start() : Void
    {
        fillCollection(TestItems.itemArray(3));
        assertEquals(3, _arrayList.size);
        
        assertTrue(_arrayList.addAllAt(0, [TestItems.object4, TestItems.object5]));
        assertEquals(5, _arrayList.size);
        assertTrue(validateTestItems([4, 5, 1, 2, 3]));
        assertEquals(TestItems.object4, _arrayList.itemAt(0));
        assertEquals(TestItems.object5, _arrayList.itemAt(1));
        assertEquals(TestItems.object1, _arrayList.itemAt(2));
        assertEquals(TestItems.object2, _arrayList.itemAt(3));
        assertEquals(TestItems.object3, _arrayList.itemAt(4));
    }
    
    public function test_addAllAt_end() : Void
    {
        fillCollection(TestItems.itemArray(3));
        assertEquals(3, _arrayList.size);
        
        assertTrue(_arrayList.addAllAt(3, [TestItems.object4, TestItems.object5]));
        assertEquals(5, _arrayList.size);
        assertTrue(validateTestItems([1, 2, 3, 4, 5]));
        assertEquals(TestItems.object1, _arrayList.itemAt(0));
        assertEquals(TestItems.object2, _arrayList.itemAt(1));
        assertEquals(TestItems.object3, _arrayList.itemAt(2));
        assertEquals(TestItems.object4, _arrayList.itemAt(3));
        assertEquals(TestItems.object5, _arrayList.itemAt(4));
    }
    
    public function test_addAllAt_wrongIndex() : Void
    {
        fillCollection(TestItems.itemArray(3));
        assertEquals(3, _arrayList.size);
        
        assertFalse(_arrayList.addAllAt(10, [TestItems.object4, TestItems.object5]));
        assertEquals(3, _arrayList.size);
        assertTrue(validateTestItems([1, 2, 3]));
        assertEquals(TestItems.object1, _arrayList.itemAt(0));
        assertEquals(TestItems.object2, _arrayList.itemAt(1));
        assertEquals(TestItems.object3, _arrayList.itemAt(2));
    }
    
    public function test_addAllAt_wrongIndexWithEmptyList() : Void
    {
        assertFalse(_arrayList.addAllAt(10, [TestItems.object1, TestItems.object2]));
        assertEquals(0, _arrayList.size);
        assertTrue(validateItems([]));
    }
    
    /*
		 * Test replace at
		 */
    
    public function test_replaceAt() : Void
    {
        fillCollection(TestItems.itemArray(3));
        assertEquals(3, _arrayList.size);
        
        assertTrue(_arrayList.replaceAt(1, TestItems.object4));
        assertEquals(3, _arrayList.size);
        assertTrue(validateTestItems([1, 4, 3]));
        assertEquals(TestItems.object1, _arrayList.itemAt(0));
        assertEquals(TestItems.object4, _arrayList.itemAt(1));
        assertEquals(TestItems.object3, _arrayList.itemAt(2));
        
        assertTrue(_arrayList.replaceAt(0, TestItems.object5));
        assertEquals(3, _arrayList.size);
        assertTrue(validateTestItems([5, 4, 3]));
        assertEquals(TestItems.object5, _arrayList.itemAt(0));
        assertEquals(TestItems.object4, _arrayList.itemAt(1));
        assertEquals(TestItems.object3, _arrayList.itemAt(2));
        
        assertTrue(_arrayList.replaceAt(2, TestItems.object6));
        assertEquals(3, _arrayList.size);
        assertTrue(validateTestItems([5, 4, 6]));
        assertEquals(TestItems.object5, _arrayList.itemAt(0));
        assertEquals(TestItems.object4, _arrayList.itemAt(1));
        assertEquals(TestItems.object6, _arrayList.itemAt(2));
    }
    
    public function test_replacedAt_withWrongIndex() : Void
    {
        fillCollection(TestItems.itemArray(3));
        assertEquals(3, _arrayList.size);
        
        assertFalse(_arrayList.replaceAt(3, TestItems.object4));
        assertEquals(3, _arrayList.size);
        assertTrue(validateTestItems([1, 2, 3]));
        assertEquals(TestItems.object1, _arrayList.itemAt(0));
        assertEquals(TestItems.object2, _arrayList.itemAt(1));
        assertEquals(TestItems.object3, _arrayList.itemAt(2));
    }
    
    public function test_replacedAt_withEmptyList() : Void
    {
        assertFalse(_arrayList.replaceAt(0, TestItems.object1));
        assertEquals(0, _arrayList.size);
        assertTrue(validateItems([]));
    }
    
    public function test_replaceAt_withSameItem() : Void
    {
        fillCollection(TestItems.itemArray(3));
        assertEquals(3, _arrayList.size);
        
        assertFalse(_arrayList.replaceAt(0, TestItems.object1));
        assertFalse(_arrayList.replaceAt(1, TestItems.object2));
        assertFalse(_arrayList.replaceAt(2, TestItems.object3));
        assertEquals(3, _arrayList.size);
        assertTrue(validateTestItems([1, 2, 3]));
        assertEquals(TestItems.object1, _arrayList.itemAt(0));
        assertEquals(TestItems.object2, _arrayList.itemAt(1));
        assertEquals(TestItems.object3, _arrayList.itemAt(2));
    }

    public function new()
    {
        super();
    }
}

