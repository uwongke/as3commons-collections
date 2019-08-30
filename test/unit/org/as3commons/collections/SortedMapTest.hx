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
import org.as3commons.collections.framework.ISortedMap;
import org.as3commons.collections.mocks.SortedMapMock;
import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
import org.as3commons.collections.testhelpers.TestComparator;
import org.as3commons.collections.testhelpers.TestItems;
import org.as3commons.collections.testhelpers.UniqueMapKey;
import org.as3commons.collections.units.IMapTests;
import org.as3commons.collections.units.ISortOrderDuplicatesTests;

/**
	 * @author Jens Struwe 30.03.2010
	 */
class SortedMapTest extends AbstractCollectionTestCase
{
    private var _sortedMap(get, never) : ISortedMap;

    
    /*
		 * AbstractCollectionTest
		 */
    
    override public function createCollection() : ICollection
    {
        return new SortedMapMock(new TestComparator());
    }
    
    override public function fillCollection(items : Array<Dynamic>) : Void
    {
        collection.clear();
        for (item in items)
        {
            cast((collection), ISortedMap).add(UniqueMapKey.key, item);
        }
    }
    
    private function get__sortedMap() : ISortedMap
    {
        return try cast(collection, ISortedMap) catch(e:Dynamic) null;
    }
    
    /*
		 * Units
		 */
    
    /*
		 * Map tests
		 */
    
    public function test_map() : Void
    {
        new IMapTests(this).runAllTests();
    }
    
    /*
		 * Order tests
		 */
    
    public function test_order() : Void
    {
        new ISortOrderDuplicatesTests(this).runAllTests();
    }
    
    /*
		 * IOrderedMap
		 */
    
    /*
		 * Initial state
		 */
    
    public function test_init() : Void
    {
        assertTrue(Std.is(_sortedMap, ISortedMap));
    }
    
    /*
		 * Test firstKey, lastKey
		 */
    
    public function test_firstKeylastKey() : Void
    {
        assertTrue(null == _sortedMap.firstKey);
        assertTrue(null == _sortedMap.lastKey);
        
        _sortedMap.add(TestItems.object1Key, TestItems.object1);
        
        assertStrictlyEquals(TestItems.object1Key, _sortedMap.firstKey);
        assertStrictlyEquals(TestItems.object1Key, _sortedMap.lastKey);
        
        _sortedMap.add(TestItems.object2Key, TestItems.object2);
        _sortedMap.add(TestItems.object3Key, TestItems.object3);
        
        assertStrictlyEquals(TestItems.object1Key, _sortedMap.firstKey);
        assertStrictlyEquals(TestItems.object3Key, _sortedMap.lastKey);
    }
    
    /*
		 * Test nextKey, previousKey
		 */
    
    public function test_nextKeyPreviousKey() : Void
    // empty
    {
        
        
        assertTrue(null == _sortedMap.nextKey(TestItems.object1Key));
        assertTrue(null == _sortedMap.previousKey(TestItems.object1Key));
        
        assertTrue(null == _sortedMap.nextKey(TestItems.object2Key));
        assertTrue(null == _sortedMap.previousKey(TestItems.object2Key));
        
        assertTrue(null == _sortedMap.nextKey(TestItems.object3Key));
        assertTrue(null == _sortedMap.previousKey(TestItems.object3Key));
        
        // key1
        
        _sortedMap.add(TestItems.object1Key, TestItems.object1);
        
        assertTrue(null == _sortedMap.nextKey(TestItems.object1Key));
        assertTrue(null == _sortedMap.previousKey(TestItems.object1Key));
        
        assertTrue(null == _sortedMap.nextKey(TestItems.object2Key));
        assertTrue(null == _sortedMap.previousKey(TestItems.object2Key));
        
        assertTrue(null == _sortedMap.nextKey(TestItems.object3Key));
        assertTrue(null == _sortedMap.previousKey(TestItems.object3Key));
        
        // key1, key2
        
        _sortedMap.add(TestItems.object2Key, TestItems.object2);
        
        assertStrictlyEquals(TestItems.object2Key, _sortedMap.nextKey(TestItems.object1Key));
        assertTrue(null == _sortedMap.previousKey(TestItems.object1Key));
        
        assertTrue(null == _sortedMap.nextKey(TestItems.object2Key));
        assertStrictlyEquals(TestItems.object1Key, _sortedMap.previousKey(TestItems.object2Key));
        
        assertTrue(null == _sortedMap.nextKey(TestItems.object3Key));
        assertTrue(null == _sortedMap.previousKey(TestItems.object3Key));
        
        // key1, key2, key3
        
        _sortedMap.add(TestItems.object3Key, TestItems.object3);
        
        assertStrictlyEquals(TestItems.object2Key, _sortedMap.nextKey(TestItems.object1Key));
        assertTrue(null == _sortedMap.previousKey(TestItems.object1Key));
        
        assertStrictlyEquals(TestItems.object3Key, _sortedMap.nextKey(TestItems.object2Key));
        assertStrictlyEquals(TestItems.object1Key, _sortedMap.previousKey(TestItems.object2Key));
        
        assertTrue(null == _sortedMap.nextKey(TestItems.object3Key));
        assertStrictlyEquals(TestItems.object2Key, _sortedMap.previousKey(TestItems.object3Key));
    }

    public function new()
    {
        super();
    }
}

