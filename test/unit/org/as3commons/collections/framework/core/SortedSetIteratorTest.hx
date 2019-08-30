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

import org.as3commons.collections.SortedSet;
import org.as3commons.collections.framework.ICollectionIterator;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.ISortedSet;
import org.as3commons.collections.framework.core.SortedNode;
import org.as3commons.collections.framework.core.As3commonsCollections;
import org.as3commons.collections.mocks.SortedSetMock;
import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
import org.as3commons.collections.testhelpers.TestComparator;
import org.as3commons.collections.units.iterators.ICollectionIteratorStartIndexTests;
import org.as3commons.collections.units.iterators.ISetIteratorTests;

/**
	 * @author Jens Struwe 30.03.2010
	 */
class SortedSetIteratorTest extends AbstractIteratorTestCase
{
    
    
    
    /*
		 * AbstractIteratorTest
		 */
    
    override public function createCollection() : Dynamic
    {
        return new SortedSetMock(new TestComparator());
    }
    
    override public function fillCollection(items : Array<Dynamic>) : Void
    {
        cast((collection), ISortedSet).clear();
        
        for (item in items)
        {
            cast((collection), ISortedSet).add(item);
        }
    }
    
    override public function getIterator(index : Int = 0) : IIterator
    {
        var item : Dynamic;
        if (index != 0)
        {
            var sortedSet : SortedSet = try cast(collection, SortedSet) catch(e:Dynamic) null;
            var i : Int = 0;
            var node : SortedNode = sortedSet.mostLeftNode_internal();
            
            while (node)
            {
                if (i == index)
                {
                    item = node.item;
                    break;
                }
                node = sortedSet.nextNode_internal(node);
                i++;
            }
        }
        
        var iterator : ICollectionIterator = try cast(cast((collection), SortedSetMock).iterator(item), ICollectionIterator) catch(e:Dynamic) null;
        if (index != 0 && item == null)
        {
            iterator.end();
        }
        
        return iterator;
    }
    
    override public function toArray() : Array<Dynamic>
    {
        return cast((collection), ISortedSet).toArray();
    }
    
    /*
		 * Units
		 */
    
    /*
		 * SetIterator tests
		 */
    
    public function test_setIterator() : Void
    {
        new ISetIteratorTests(this).runAllTests();
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

