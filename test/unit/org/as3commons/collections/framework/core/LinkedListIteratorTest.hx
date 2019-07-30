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

import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.ILinkedList;
import org.as3commons.collections.framework.ILinkedListIterator;
import org.as3commons.collections.mocks.LinkedListMock;
import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
import org.as3commons.collections.units.iterators.ICollectionIteratorTests;
import org.as3commons.collections.units.iterators.IIteratorInsertionOrderTests;
import org.as3commons.collections.units.iterators.IIteratorNextPreviousLookupTests;

/**
	 * @author Jens Struwe 19.03.2010
	 */
class LinkedListIteratorTest extends AbstractIteratorTestCase
{
    
    /*
		 * AbstractIteratorTest
		 */
    
    override public function createCollection() : Dynamic
    {
        return new LinkedListMock();
    }
    
    override public function fillCollection(items : Array<Dynamic>) : Void
    {
        cast((collection), ILinkedList).clear();
        
        for (item in items)
        {
            cast((collection), ILinkedList).add(item);
        }
    }
    
    override public function getIterator(index : Int = 0) : IIterator
    {
        return cast((collection), ILinkedList).iterator(index);
    }
    
    override public function toArray() : Array<Dynamic>
    {
        return cast((collection), ILinkedList).toArray();
    }
    
    /*
		 * Units
		 */
    
    /*
		 * CollectionIterator tests
		 */
    
    public function test_collectionIterator() : Void
    {
        new ICollectionIteratorTests(this).runAllTests();
    }
    
    /*
		 * IIteratorInsertionOrderTests tests
		 */
    
    public function test_iteratorInsertionOrder() : Void
    {
        new IIteratorInsertionOrderTests(this).runAllTests();
    }
    
    /*
		 * NextPreviousLookup tests
		 */
    
    public function test_nextPreviousLookup() : Void
    {
        new IIteratorNextPreviousLookupTests(this).runAllTests();
    }
    
    /*
		 * ILinkedListIterator
		 */
    
    /*
		 * Initial state
		 */
    
    public function test_init() : Void
    {
        assertTrue(Std.is(getIterator(), ILinkedListIterator));
    }

    public function new()
    {
        super();
    }
}

