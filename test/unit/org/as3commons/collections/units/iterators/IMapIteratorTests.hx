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

import org.as3commons.collections.framework.IMap;
import org.as3commons.collections.framework.IMapIterator;
import org.as3commons.collections.testhelpers.AbstractIteratorTestCase;
import org.as3commons.collections.testhelpers.TestItems;

/**
	 * @author Jens Struwe 25.03.2010
	 */
class IMapIteratorTests extends ICollectionIteratorTests
{
    
    public function new(test : AbstractIteratorTestCase)
    {
        super(test);
    }
    
    /*
		 * Units
		 */
    
    /*
		 * NextPreviousLookup tests
		 */
    
    public function test_nextPreviousLookup() : Void
    {
        new IIteratorNextPreviousLookupTests(_test).runAllTests();
    }
    
    /*
		 * IMapIterator
		 */
    
    /*
		 * Initial state
		 */
    
    public function test_init_listIterator() : Void
    {
        assertTrue(Std.is(_test.getIterator(), IMapIterator));
    }
    
    /*
		 * Test key
		 */
    
    public function test_key() : Void
    {
        _test.fillCollection(TestItems.itemArray(3));
        
        var iterator : IMapIterator = try cast(_test.getIterator(), IMapIterator) catch(e:Dynamic) null;
        var items : Array<Dynamic> = _test.allItems(iterator);
        var keys : Array<Dynamic> = _test.allKeys(iterator);
        
        assertTrue(null == iterator.key);
        
        assertStrictlyEquals(items[0], iterator.next());
        assertEquals(keys[0], iterator.key);
        
        assertStrictlyEquals(items[1], iterator.next());
        assertEquals(keys[1], iterator.key);
        
        assertStrictlyEquals(items[2], iterator.next());
        assertEquals(keys[2], iterator.key);
        
        assertTrue(null == iterator.next());
        assertTrue(null == iterator.key);
        
        assertStrictlyEquals(items[2], iterator.previous());
        assertEquals(keys[2], iterator.key);
        
        assertStrictlyEquals(items[1], iterator.previous());
        assertEquals(keys[1], iterator.key);
        
        assertStrictlyEquals(items[0], iterator.previous());
        assertEquals(keys[0], iterator.key);
        
        assertTrue(null == iterator.previous());
        assertTrue(null == iterator.key);
    }
    
    public function test_key2() : Void
    {
        cast((_test.collection), IMap).add(1, "one");
        
        var iterator : IMapIterator = try cast(_test.getIterator(), IMapIterator) catch(e:Dynamic) null;
        
        assertTrue(null == iterator.key);
        assertStrictlyEquals("one", iterator.next());
        assertEquals(1, iterator.key);
    }
    
    public function test_key_resetAfterRemoveStartEnd() : Void
    {
        _test.fillCollection(TestItems.itemArray(3));
        
        var iterator : IMapIterator = try cast(_test.getIterator(), IMapIterator) catch(e:Dynamic) null;
        
        var items : Array<Dynamic> = _test.allItems(iterator);
        var keys : Array<Dynamic> = _test.allKeys(iterator);
        
        assertStrictlyEquals(items[0], iterator.next());
        assertStrictlyEquals(items[1], iterator.next());
        assertEquals(keys[1], iterator.key);
        
        iterator.start();
        assertTrue(null == iterator.key);
        
        assertStrictlyEquals(items[0], iterator.next());
        assertStrictlyEquals(items[1], iterator.next());
        assertEquals(keys[1], iterator.key);
        
        iterator.end();
        assertTrue(null == iterator.key);
        
        assertStrictlyEquals(items[2], iterator.previous());
        assertStrictlyEquals(items[1], iterator.previous());
        assertEquals(keys[1], iterator.key);
        
        iterator.remove();
        assertTrue(null == iterator.key);
        
        assertStrictlyEquals(items[0], iterator.previous());
        assertEquals(keys[0], iterator.key);
    }
}

