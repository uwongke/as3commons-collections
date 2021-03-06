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
package org.as3commons.collections.testhelpers;

import org.as3commons.collections.ArrayList;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.IOrderedList;
import org.as3commons.collections.framework.IRecursiveIterator;

/**
	 * @author Jens Struwe 19.03.2010
	 */
class AbstractSpecialIteratorTestCase extends AbstractIteratorTestCase
{
    
    /*
		 * Test neutralisation
		 */
    
    override public function setUp() : Void
    {
        TestItems.init();
        collection = new ArrayList();
    }
    
    override public function tearDown() : Void
    {
        TestItems.cleanUp();
    }
    
    /*
		 * Test public interface
		 */
    
    override public function fillCollection(items : Array<Dynamic>) : Void
    {
        cast((collection), IOrderedList).array = items;
    }
    
    public function add(item : Dynamic) : Void
    {
        cast((collection), IOrderedList).add(item);
    }
    
    override public function toArray() : Array<Dynamic>
    {
        return cast((collection), IOrderedList).toArray();
    }
    
    public function getFilterIterator() : IIterator
    {
        return null;
    }
    
    public function getRecursiveIterator() : IRecursiveIterator
    {
        return null;
    }
    
    public function filter(item : Dynamic) : Bool
    {
        return Reflect.field(item, "index") % 2 == 0;
    }

    public function new()
    {
        super();
    }
}


