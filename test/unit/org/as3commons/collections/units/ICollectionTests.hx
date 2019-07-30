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

import org.as3commons.collections.framework.ICollection;
import org.as3commons.collections.framework.ICollectionIterator;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
import org.as3commons.collections.testhelpers.AbstractCollectionUnitTestCase;
import org.as3commons.collections.testhelpers.TestItems;

/*
	 * @author Jens Struwe 18.03.2010
	 */
class ICollectionTests extends AbstractCollectionUnitTestCase
{
    private var _collectionAdd(get, never) : ITestCollection;

    
    public function new(test : AbstractCollectionTestCase)
    {
        super(test);
    }
    
    private function get__collectionAdd() : ITestCollection
    {
        return try cast(_test.collection, ITestCollection) catch(e:Dynamic) null;
    }
    
    /*
		 * Initial state
		 */
    
    public function test_init() : Void
    {

        assertTrue(Std.is(_test.collection, ICollection));
    }
    
    public function test_init_initallyEmpty() : Void
    {
        assertTrue(_test.collection.size == 0);
    }
    
    /*
		 * Test iterator
		 */
    
    public function test_iterator() : Void
    {
        assertTrue(Std.is(_test.collection.iterator(), IIterator));
        assertTrue(Std.is(_test.collection.iterator(), ICollectionIterator));
    }
    
    /*
		 * Test mixed types
		 */
    
    public function test_add_mixedTypes() : Void
    {
        var items : Array<Dynamic> = [
        -1.5, -1, 1.5, 1, 
        "-1.5", "-1", "1.5", "1", "true", "false", 
        TestItems.object1, TestItems.object2, 
        true, false, 
        new Array(),
        function() : Void
        {
        }
    ];
        
        _test.fillCollection(items);
        
        assertTrue(_test.validateItems(items));
    }
    
    /*
		 * Test add
		 */
    
    public function test_add_singleItem() : Void
    {
        _collectionAdd.addMock(TestItems.object1);
        _collectionAdd.addMock(TestItems.object2);
        _collectionAdd.addMock(TestItems.object3);
        
        assertEquals(3, _collectionAdd.size);
        assertEquals(3, _collectionAdd.toArray().length);
        
        assertTrue(_test.validateTestItems([1, 2, 3]));
    }
    
    public function test_add() : Void
    {
        _collectionAdd.addMock(TestItems.object2);
        _collectionAdd.addMock(TestItems.object7);
        _collectionAdd.addMock(TestItems.object4);
        _collectionAdd.addMock(TestItems.object1);
        _collectionAdd.addMock(TestItems.object3);
        _collectionAdd.addMock(TestItems.object6);
        _collectionAdd.addMock(TestItems.object5);
        
        assertEquals(7, _collectionAdd.size);
        assertEquals(7, _collectionAdd.toArray().length);
        
        assertTrue(_test.validateTestItems([2, 7, 4, 1, 3, 6, 5]));
    }
    
    public function test_add_null() : Void
    {
        _collectionAdd.addMock(TestItems.object2);
        _collectionAdd.addMock(null);
        _collectionAdd.addMock(TestItems.object1);
        
        assertEquals(3, _collectionAdd.size);
        assertEquals(3, _collectionAdd.toArray().length);
        
        assertTrue(_test.validateTestItems([2, null, 1]));
    }
    
    /*
		 * Test size
		 */
    
    public function test_size_initiallyZero() : Void
    {
        assertEquals(0, _test.collection.size);
    }
    
    public function test_size() : Void
    {
        _test.fillCollection(TestItems.itemArray(5));
        
        assertEquals(5, _test.collection.size);
        assertEquals(5, _test.collection.toArray().length);
    }
    
    /*
		 * Test has
		 */
    
    public function test_has_withEmptySequence() : Void
    {
        assertFalse(_test.collection.has(TestItems.object2));
    }
    
    public function test_has_withWrongItem() : Void
    {
        _test.fillCollection([TestItems.object1]);
        
        assertFalse(_test.collection.has(TestItems.object2));
    }
    
    public function test_has_withSingleItem() : Void
    {
        _test.fillCollection([TestItems.object1]);
        
        assertTrue(_test.collection.has(TestItems.object1));
    }
    //TODO: fix
//    public function test_has_withNull() : Void
//    {
//        assertFalse(null);
//
//        _test.fillCollection([TestItems.object1, null, TestItems.object2]);
//
//        assertTrue(_test.collection.has(null));
//    }
    
    public function test_has() : Void
    {
        _test.fillCollection(TestItems.itemArray(4));
        
        assertTrue(_test.collection.has(TestItems.object1));
        assertTrue(_test.collection.has(TestItems.object2));
        assertTrue(_test.collection.has(TestItems.object3));
        assertTrue(_test.collection.has(TestItems.object4));
        
        assertFalse(_test.collection.has(TestItems.object5));
    }
    
    /*
		 * Test toArray
		 */
    
    public function test_toArray_withEmptyCollection() : Void
    {
        var array : Array<Dynamic> = _test.collection.toArray();
        
        assertTrue(Std.is(array, Array));
        
        assertEquals(0, array.length);
    }
    
    public function test_toArray() : Void
    {
        var items : Array<Dynamic> = TestItems.itemArray(5);
        _test.fillCollection(items);
        
        assertEquals(5, _test.collection.size);
        
        var array : Array<Dynamic> = _test.collection.toArray();
        
        assertEquals(5, array.length);
        
        assertTrue(_test.validateItems(array));
    }
    
    public function test_toArray_returnsCopy() : Void
    {
        _test.fillCollection(TestItems.itemArray(5));
        
        assertEquals(5, _test.collection.size);
        
        var array : Array<Dynamic> = _test.collection.toArray();
        array.splice(0, 2);
        
        assertEquals(3, array.length);
        
        assertEquals(5, _test.collection.size);
        
        assertEquals(5, _test.collection.toArray().length);
    }
    
    /*
		 * Test remove
		 */
    
    public function test_remove_withEmptySequence() : Void
    {
        assertFalse(_test.collection.remove(TestItems.object1));
    }
    
    public function test_remove_withWrongItem() : Void
    {
        _test.fillCollection(TestItems.itemArray(4));
        
        assertFalse(_test.collection.remove(TestItems.object5));
        
        assertTrue(_test.validateTestItems([1, 2, 3, 4], _test.collection.toArray()));
    }
    
    public function test_remove_withSingleItem() : Void
    {
        _test.fillCollection([TestItems.object1]);
        
        assertTrue(_test.collection.remove(TestItems.object1));
        assertTrue(_test.validateTestItems([], _test.collection.toArray()));
    }
    
    public function test_remove() : Void
    {
        _test.fillCollection(TestItems.itemArray(4));
        assertEquals(4, _test.collection.size);
        
        assertTrue(_test.collection.remove(TestItems.object1));
        assertEquals(3, _test.collection.size);
        assertTrue(_test.validateTestItems([2, 3, 4], _test.collection.toArray()));
        assertFalse(_test.collection.has(TestItems.object1));
        
        assertTrue(_test.collection.remove(TestItems.object4));
        assertEquals(2, _test.collection.size);
        assertTrue(_test.validateTestItems([2, 3], _test.collection.toArray()));
        assertFalse(_test.collection.has(TestItems.object4));
        
        assertTrue(_test.collection.remove(TestItems.object2));
        assertEquals(1, _test.collection.size);
        assertTrue(_test.validateTestItems([3], _test.collection.toArray()));
        assertFalse(_test.collection.has(TestItems.object2));
        
        assertFalse(_test.collection.remove(TestItems.object1));
        assertEquals(1, _test.collection.size);
        assertTrue(_test.validateTestItems([3], _test.collection.toArray()));
        
        assertTrue(_test.collection.remove(TestItems.object3));
        assertEquals(0, _test.collection.size);
        assertTrue(_test.validateTestItems([], _test.collection.toArray()));
        assertFalse(_test.collection.has(TestItems.object3));
    }
    
    public function test_remove_null() : Void
    {
        _test.fillCollection([TestItems.object1, TestItems.object2, null, TestItems.object3]);
        assertEquals(4, _test.collection.size);
        
        assertTrue(_test.collection.remove(null));
        assertEquals(3, _test.collection.size);
        assertTrue(_test.validateTestItems([1, 2, 3]));
    }
    
    /*
		 * Test clear
		 */
    
    public function test_clear() : Void
    {
        assertFalse(_test.collection.clear());
        
        _test.fillCollection(TestItems.itemArray(5));
        
        assertEquals(5, _test.collection.size);
        assertEquals(5, _test.collection.toArray().length);
        
        assertTrue(_test.collection.clear());
        
        assertEquals(0, _test.collection.size);
        assertEquals(0, _test.collection.toArray().length);
        
        // add items again
        
        var items : Array<Dynamic> = TestItems.itemArray(5);
        _test.fillCollection(items);
        
        assertEquals(5, _test.collection.size);
        assertEquals(5, _test.collection.toArray().length);
        
        assertTrue(_test.collection.clear());
        
        assertEquals(0, _test.collection.size);
        assertEquals(0, _test.collection.toArray().length);
        
        assertFalse(_test.collection.clear());
    }
    
    /*
		 * Test null
		 */
    
    public function test_null() : Void
    {
        _test.fillCollection([TestItems.object1, TestItems.object2, null, TestItems.object3, TestItems.object4]);
        
        assertEquals(5, _test.collection.size);
        assertEquals(5, _test.collection.toArray().length);
        assertTrue(_test.validateTestItems([1, 2, null, 3, 4]));
    }
}

