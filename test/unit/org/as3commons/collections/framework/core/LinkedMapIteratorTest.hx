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
package org.as3commons.collections.framework.core;

import org.as3commons.collections.LinkedMap;
import org.as3commons.collections.framework.ICollectionIterator;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.IOrderedMapIterator;
import org.as3commons.collections.framework.core.LinkedMapNode;
import org.as3commons.collections.framework.core.LinkedNode;
import org.as3commons.collections.framework.core.As3commonsCollections;
import org.as3commons.collections.mocks.LinkedMapMock;
import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
import org.as3commons.collections.testhelpers.TestItems;
import org.as3commons.collections.testhelpers.UniqueMapKey;
import org.as3commons.collections.units.iterators.ICollectionIteratorStartIndexTests;
import org.as3commons.collections.units.iterators.IIteratorInsertionOrderTests;
import org.as3commons.collections.units.iterators.IMapIteratorTests;

/**
	 * @author Jens Struwe 23.03.2010
	 */
class LinkedMapIteratorTest extends AbstractIteratorTestCase
{
    
    
    
    /*
		 * AbstractIteratorTest
		 */
    
    override public function createCollection() : Dynamic
    {
        return new LinkedMapMock();
    }
    
    override public function fillCollection(items : Array<Dynamic>) : Void
    {
        cast((collection), LinkedMap).clear();
        for (item in items)
        {
            cast((collection), LinkedMap).add(UniqueMapKey.key, item);
        }
    }
    
    override public function getIterator(index : Int = 0) : IIterator
    {
        var key : Dynamic;
        var i : Int = 0;
        if (index != 0)
        {
            var node : LinkedNode = cast((collection), LinkedMap).firstNode_internal;
            while (node)
            {
                if (index == i)
                {
                    key = cast((node), LinkedMapNode).key;
                    break;
                }
                node = node.right;
                i++;
            }
        }
        
        var iterator : ICollectionIterator = try cast(cast((collection), LinkedMap).iterator(key), ICollectionIterator) catch(e:Dynamic) null;
        if (index != 0 && key == null)
        {
            iterator.end();
        }
        return iterator;
    }
    
    override public function toArray() : Array<Dynamic>
    {
        return cast((collection), LinkedMap).toArray();
    }
    
    /*
		 * Units
		 */
    
    /*
		 * MapIterator tests
		 */
    
    public function test_mapIterator() : Void
    {
        new IMapIteratorTests(this).runAllTests();
    }
    
    /*
		 * IIteratorInsertionOrderTests tests
		 */
    
    public function test_iteratorInsertionOrder() : Void
    {
        new IIteratorInsertionOrderTests(this).runAllTests();
    }
    
    /*
		 * StartIndexTests tests
		 */
    
    public function test_collectionIteratorStartIndex() : Void
    {
        new ICollectionIteratorStartIndexTests(this).runAllTests();
    }
    
    /*
		 * LinkedMapIterator
		 */
    
    /*
		 * Test add
		 */
    
    public function test_addBefore_withExistingKey() : Void
    {
        fillCollection(TestItems.itemArray(3));
        
        var iterator : IOrderedMapIterator = try cast(getIterator(), IOrderedMapIterator) catch(e:Dynamic) null;
        
        assertStrictlyEquals(TestItems.object1, iterator.next());
        assertStrictlyEquals(TestItems.object2, iterator.next());  // 1 2 | 3  
        
        assertTrue(iterator.addBefore(10, TestItems.object4));  // 1 2 4 | 3
        assertFalse(iterator.addBefore(10, TestItems.object5));
        assertTrue(iterator.addBefore(11, TestItems.object5));
    }
    
    public function test_addAfter_withExistingKey() : Void
    {
        fillCollection(TestItems.itemArray(3));
        
        var iterator : IOrderedMapIterator = try cast(getIterator(), IOrderedMapIterator) catch(e:Dynamic) null;
        
        assertStrictlyEquals(TestItems.object1, iterator.next());
        assertStrictlyEquals(TestItems.object2, iterator.next());  // 1 2 | 3  
        
        assertTrue(iterator.addAfter(10, TestItems.object4));  // 1 2 | 4 3
        assertFalse(iterator.addAfter(10, TestItems.object5));
        assertTrue(iterator.addAfter(11, TestItems.object5));
    }

    public function new()
    {
        super();
    }
}

