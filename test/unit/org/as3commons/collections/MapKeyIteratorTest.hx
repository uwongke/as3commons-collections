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

import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
import org.as3commons.collections.units.iterators.IIteratorTests;

/**
	 * @author Jens Struwe 14.04.2010
	 */
class MapKeyIteratorTest extends AbstractIteratorTestCase
{
    
    /*
		 * AbstractIteratorTest
		 */
    
    override public function createCollection() : Dynamic
    {
        return new Map();
    }
    
    override public function fillCollection(items : Array<Dynamic>) : Void
    {
        cast((collection), Map).clear();
        for (item in items)
        {
            cast((collection), Map).add(item, item);
        }
    }
    
    override public function getIterator(index : Int = 0) : IIterator
    {
        return cast((collection), Map).keyIterator();
    }
    
    override public function toArray() : Array<Dynamic>
    {
        return cast((collection), Map).keysToArray();
    }
    
    /*
		 * Units
		 */
    
    /*
		 * IIterator tests
		 */
    
    public function test_iterator() : Void
    {
        new IIteratorTests(this).runAllTests();
    }

    public function new()
    {
        super();
    }
}

