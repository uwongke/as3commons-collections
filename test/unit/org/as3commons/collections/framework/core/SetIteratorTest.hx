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

import org.as3commons.collections.Set;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.core.As3commonsCollections;
import org.as3commons.collections.mocks.SetMock;
import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
import org.as3commons.collections.units.iterators.ISetIteratorTests;

/**
	 * @author Jens Struwe 23.03.2010
	 */
class SetIteratorTest extends AbstractIteratorTestCase
{
    
    
    
    /*
		 * AbstractIteratorTest
		 */
    
    override public function createCollection() : Dynamic
    {
        return new SetMock();
    }
    
    override public function fillCollection(items : Array<Dynamic>) : Void
    {
        cast((collection), Set).clear();
        for (item in items)
        {
            cast((collection), Set).add(item);
        }
    }
    
    override public function getIterator(index : Int = 0) : IIterator
    {
        return cast((collection), Set).iterator(index);
    }
    
    override public function toArray() : Array<Dynamic>
    {
        return cast((collection), Set).toArray();
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

    public function new()
    {
        super();
    }
}

