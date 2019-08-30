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

import org.as3commons.collections.Map;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.mocks.MapMock;
import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
import org.as3commons.collections.testhelpers.UniqueMapKey;
import org.as3commons.collections.units.iterators.IMapIteratorTests;

/**
	 * @author Jens Struwe 23.03.2010
	 */
class MapIteratorTest extends AbstractIteratorTestCase
{
    
    /*
		 * AbstractIteratorTest
		 */
    
    override public function createCollection() : Dynamic
    {
        return new MapMock();
    }
    
    override public function fillCollection(items : Array<Dynamic>) : Void
    {
        cast((collection), Map).clear();
        for (item in items)
        {
            cast((collection), Map).add(UniqueMapKey.key, item);
        }
    }
    
    override public function getIterator(index : Int = 0) : IIterator
    {
        return cast((collection), Map).iterator(index);
    }
    
    override public function toArray() : Array<Dynamic>
    {
        return cast((collection), Map).toArray();
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

    public function new()
    {
        super();
    }
}

