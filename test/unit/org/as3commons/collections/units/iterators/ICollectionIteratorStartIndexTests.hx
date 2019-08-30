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
package org.as3commons.collections.units.iterators;

import org.as3commons.collections.framework.ICollectionIterator;
import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
import org.as3commons.collections.testhelpers.TestItems;

/**
	 * @author Jens Struwe 19.03.2010
	 */
class ICollectionIteratorStartIndexTests extends IIteratorStartIndexTests
{
    
    public function new(test : AbstractIteratorTestCase)
    {
        super(test);
    }
    
    /*
		 * Test start index
		 */
    
    public function test_startIndex_collectionIterator() : Void
    {
        _test.fillCollection(TestItems.itemArray(6));
        
        var iterator : ICollectionIterator = try cast(_test.getIterator(2), ICollectionIterator) catch(e:Dynamic) null;
        
        assertTrue(iterator.hasNext());
        assertTrue(iterator.hasPrevious());
        assertStrictlyEquals(TestItems.object3, iterator.next());
    }
    
    public function test_startIndex2() : Void
    {
        _test.fillCollection(TestItems.itemArray(6));
        
        var iterator : ICollectionIterator = try cast(_test.getIterator(2), ICollectionIterator) catch(e:Dynamic) null;
        
        assertTrue(iterator.hasNext());
        assertTrue(iterator.hasPrevious());
        assertStrictlyEquals(TestItems.object2, iterator.previous());
    }
    
    public function test_startIndex_wrong_collectionIterator() : Void
    {
        _test.fillCollection(TestItems.itemArray(6));
        
        var iterator : ICollectionIterator = try cast(_test.getIterator(12), ICollectionIterator) catch(e:Dynamic) null;
        
        assertTrue(iterator.hasPrevious());
        assertFalse(iterator.hasNext());
        assertStrictlyEquals(TestItems.object6, iterator.previous());
    }
    
    public function test_startIndex_rightAfterLast_collectionIterator() : Void
    {
        _test.fillCollection(TestItems.itemArray(6));
        
        var iterator : ICollectionIterator = try cast(_test.getIterator(6), ICollectionIterator) catch(e:Dynamic) null;
        
        assertTrue(iterator.hasPrevious());
        assertFalse(iterator.hasNext());
        assertStrictlyEquals(TestItems.object6, iterator.previous());
    }
    
    public function test_startIndex_atStart_collectionIterator() : Void
    {
        _test.fillCollection(TestItems.itemArray(6));
        
        var iterator : ICollectionIterator = try cast(_test.getIterator(0), ICollectionIterator) catch(e:Dynamic) null;
        
        assertFalse(iterator.hasPrevious());
        assertTrue(iterator.hasNext());
        assertStrictlyEquals(TestItems.object1, iterator.next());
    }
    
    public function test_startIndex_atEnd_collectionIterator() : Void
    {
        _test.fillCollection(TestItems.itemArray(6));
        
        var iterator : ICollectionIterator = try cast(_test.getIterator(5), ICollectionIterator) catch(e:Dynamic) null;
        
        assertTrue(iterator.hasPrevious());
        assertTrue(iterator.hasNext());
        assertStrictlyEquals(TestItems.object6, iterator.next());
    }
    
    public function test_startIndex_atEnd2() : Void
    {
        _test.fillCollection(TestItems.itemArray(6));
        
        var iterator : ICollectionIterator = try cast(_test.getIterator(5), ICollectionIterator) catch(e:Dynamic) null;
        
        assertTrue(iterator.hasPrevious());
        assertTrue(iterator.hasNext());
        assertStrictlyEquals(TestItems.object5, iterator.previous());
    }
}

