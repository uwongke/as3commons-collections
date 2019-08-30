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
package org.as3commons.collections.iterators;

import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.mocks.ArrayIteratorMock;
import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
import org.as3commons.collections.units.iterators.IListIteratorTests;

/**
	 * @author Jens Struwe 19.03.2010
	 */
class ArrayIteratorTest extends AbstractIteratorTestCase
{
    
    /*
		 * AbstractIteratorTest
		 */
    
    override public function createCollection() : Dynamic
    {
        return new Array<Dynamic>();
    }
    
    override public function fillCollection(items : Array<Dynamic>) : Void
    {
        collection = items;
    }
    
    override public function getIterator(index : Int = 0) : IIterator
    {
        return new ArrayIteratorMock(collection, index);
    }
    
    override public function toArray() : Array<Dynamic>
    {
        return collection;
    }
    
    /*
		 * Units
		 */
    
    /*
		 * CollectionIterator tests
		 */
    
    public function test_listIterator() : Void
    {
        new IListIteratorTests(this).runAllTests();
    }

    public function new()
    {
        super();
    }
}

