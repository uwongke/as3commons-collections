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

import org.as3commons.collections.SortedMap;
import org.as3commons.collections.framework.ICollectionIterator;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.ISortedMap;
import org.as3commons.collections.framework.core.SortedMapNode;
import org.as3commons.collections.framework.core.SortedNode;
import org.as3commons.collections.framework.core.As3commonsCollections;
import org.as3commons.collections.mocks.SortedMapMock;
import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
import org.as3commons.collections.testhelpers.TestComparator;
import org.as3commons.collections.testhelpers.UniqueMapKey;
import org.as3commons.collections.units.iterators.ICollectionIteratorStartIndexTests;
import org.as3commons.collections.units.iterators.IMapIteratorTests;

/**
	 * @author Jens Struwe 30.03.2010
	 */
class SortedMapIteratorTest extends AbstractIteratorTestCase
{
    
    
    
    /*
		 * AbstractIteratorTest
		 */
    
    override public function createCollection() : Dynamic
    {
        return new SortedMapMock(new TestComparator());
    }
    
    override public function fillCollection(items : Array<Dynamic>) : Void
    {
        cast((collection), SortedMapMock).clear();
        for (item in items)
        {
            cast((collection), SortedMapMock).add(UniqueMapKey.key, item);
        }
    }
    
    override public function getIterator(index : Int = 0) : IIterator
    {
        var key : Dynamic;
        if (index != 0)
        {
            var sortedMap : SortedMap = try cast(collection, SortedMap) catch(e:Dynamic) null;
            var i : Int = 0;
            var node : SortedNode = sortedMap.mostLeftNode_internal();
            
            while (node)
            {
                if (i == index)
                {
                    key = cast((node), SortedMapNode).key;
                    break;
                }
                node = sortedMap.nextNode_internal(node);
                i++;
            }
        }
        
        var iterator : ICollectionIterator = try cast(cast((collection), SortedMapMock).iterator(key), ICollectionIterator) catch(e:Dynamic) null;
        if (index != 0 && key == null)
        {
            iterator.end();
        }
        
        return iterator;
    }
    
    override public function toArray() : Array<Dynamic>
    {
        return cast((collection), ISortedMap).toArray();
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
		 * StartIndexTests tests
		 */
    
    public function test_collectionIteratorStartIndex() : Void
    {
        new ICollectionIteratorStartIndexTests(this).runAllTests();
    }

    public function new()
    {
        super();
    }
}

