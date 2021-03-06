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
import org.as3commons.collections.framework.ISortedSet;
import org.as3commons.collections.mocks.SortedSetMock;
import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
import org.as3commons.collections.testhelpers.TestComparator;
import org.as3commons.collections.testhelpers.TestItems;
import org.as3commons.collections.units.ISetTests;
import org.as3commons.collections.units.ISortOrderDuplicateEqualsTests;

/**
	 * @author Jens Struwe 30.03.2010
	 */
class SortedSetTest extends AbstractCollectionTestCase
{
    private var _sortedSet(get, never) : ISortedSet;

    
    /*
		 * AbstractCollectionTest
		 */
    
    override public function createCollection() : ICollection
    {
        return new SortedSetMock(new TestComparator());
    }
    
    override public function fillCollection(items : Array<Dynamic>) : Void
    {
        collection.clear();
        
        for (item in items)
        {
            cast((collection), ISortedSet).add(item);
        }
    }
    
    private function get__sortedSet() : ISortedSet
    {
        return try cast(collection, ISortedSet) catch(e:Dynamic) null;
    }
    
    /*
		 * Units
		 */
    
    /*
		 * Set tests
		 */
    
    public function test_set() : Void
    {
        new ISetTests(this).runAllTests();
    }
    
    /*
		 * Order tests
		 */
    
    public function test_order() : Void
    {
        new ISortOrderDuplicateEqualsTests(this).runAllTests();
    }
    
    /*
		 * IOrderedMap
		 */
    
    /*
		 * Initial state
		 */
    
    public function test_init() : Void
    {
        assertTrue(Std.is(_sortedSet, ISortedSet));
    }
    
    /*
		 * Test next, previous
		 */
    
    public function test_nextPrevious() : Void
    // empty
    {
        
        
        assertTrue(null == _sortedSet.next(TestItems.object1Key));
        assertTrue(null == _sortedSet.previous(TestItems.object1Key));
        
        assertTrue(null == _sortedSet.next(TestItems.object2Key));
        assertTrue(null == _sortedSet.previous(TestItems.object2Key));
        
        assertTrue(null == _sortedSet.next(TestItems.object3Key));
        assertTrue(null == _sortedSet.previous(TestItems.object3Key));
        
        // key1
        
        _sortedSet.add(TestItems.object1Key);
        
        assertTrue(null == _sortedSet.next(TestItems.object1Key));
        assertTrue(null == _sortedSet.previous(TestItems.object1Key));
        
        assertTrue(null == _sortedSet.next(TestItems.object2Key));
        assertTrue(null == _sortedSet.previous(TestItems.object2Key));
        
        assertTrue(null == _sortedSet.next(TestItems.object3Key));
        assertTrue(null == _sortedSet.previous(TestItems.object3Key));
        
        // key1, key2
        
        _sortedSet.add(TestItems.object2Key);
        
        assertStrictlyEquals(TestItems.object2Key, _sortedSet.next(TestItems.object1Key));
        assertTrue(null == _sortedSet.previous(TestItems.object1Key));
        
        assertTrue(null == _sortedSet.next(TestItems.object2Key));
        assertStrictlyEquals(TestItems.object1Key, _sortedSet.previous(TestItems.object2Key));
        
        assertTrue(null == _sortedSet.next(TestItems.object3Key));
        assertTrue(null == _sortedSet.previous(TestItems.object3Key));
        
        // key1, key2, key3
        
        _sortedSet.add(TestItems.object3Key);
        
        assertStrictlyEquals(TestItems.object2Key, _sortedSet.next(TestItems.object1Key));
        assertTrue(null == _sortedSet.previous(TestItems.object1Key));
        
        assertStrictlyEquals(TestItems.object3Key, _sortedSet.next(TestItems.object2Key));
        assertStrictlyEquals(TestItems.object1Key, _sortedSet.previous(TestItems.object2Key));
        
        assertTrue(null == _sortedSet.next(TestItems.object3Key));
        assertStrictlyEquals(TestItems.object2Key, _sortedSet.previous(TestItems.object3Key));
    }

    public function new()
    {
        super();
    }
}

