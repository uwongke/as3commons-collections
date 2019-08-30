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
package org.as3commons.collections.units.fx;

import org.as3commons.collections.framework.ICollectionFx;
import org.as3commons.collections.framework.ICollectionIterator;
import org.as3commons.collections.fx.events.CollectionEvent;
import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
import org.as3commons.collections.testhelpers.AbstractCollectionUnitTestCase;
import org.as3commons.collections.testhelpers.CollectionEventListener;
import org.as3commons.collections.testhelpers.TestItems;
import org.as3commons.collections.units.ITestCollection;
import org.as3commons.collections.units.ITestOrder;

/**
	 * @author Jens Struwe 22.03.2010
	 */
class ICollectionFxTests extends AbstractCollectionUnitTestCase
{
    private var _collectionAdd(get, never) : ITestCollection;

    
    public function new(test : AbstractCollectionTestCase)
    {
        super(test);
    }
    
    private function get__collectionAdd() : ITestCollection
    {
        return try cast(_test.collection, ITestCollection) catch(e:Dynamic) null;
    }
    
    /*
		 * Test neutralisation
		 */
    
    private var _listener : CollectionEventListener;
    
    override public function setUp() : Void
    {
        setUpListener();
    }
    
    override public function tearDown() : Void
    {
        _listener.cleanUp();
        _listener = null;
    }
    
    private function setUpListener() : Void
    {
        _listener = new CollectionEventListener(_test.collection);
    }
    
    /*
		 * Initial state
		 */
    
    public function test_init() : Void
    {
        assertTrue(Std.is(_test.collection, ICollectionFx));
        assertTrue(Std.is(_test.collection, ITestCollection));
    }
    
    /*
		 * Test add
		 */
    
    public function test_add() : Void
    {
        assertFalse(_listener.eventReceived);
        _collectionAdd.addMock(TestItems.object2);
        assertTrue(_listener.eventReceived);
        assertEquals(1, _listener.numEvents);
        var event : CollectionEvent = _listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object2, event.item);
        assertEquals(1, event.numItems);
        if (Std.is(_test.collection, ITestOrder))
        {
            assertTrue(Std.is(event.iterator(), ICollectionIterator));
            assertStrictlyEquals(TestItems.object2, event.iterator().next());
        }
        else
        {
            Assert.isNull(event.iterator());
        }
        assertTrue(_listener.validateSize(1));
        
        assertFalse(_listener.eventReceived);
        _collectionAdd.addMock(TestItems.object7);
        assertTrue(_listener.eventReceived);
        assertEquals(1, _listener.numEvents);
        event = _listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object7, event.item);
        assertEquals(1, event.numItems);
        if (Std.is(_test.collection, ITestOrder))
        {
            assertTrue(Std.is(event.iterator(), ICollectionIterator));
            assertStrictlyEquals(TestItems.object7, event.iterator().next());
        }
        else
        {
            Assert.isNull(event.iterator());
        }
        assertTrue(_listener.validateSize(2));
        
        assertFalse(_listener.eventReceived);
        _collectionAdd.addMock(TestItems.object4);
        assertTrue(_listener.eventReceived);
        assertEquals(1, _listener.numEvents);
        event = _listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object4, event.item);
        assertEquals(1, event.numItems);
        if (Std.is(_test.collection, ITestOrder))
        {
            assertTrue(Std.is(event.iterator(), ICollectionIterator));
            assertStrictlyEquals(TestItems.object4, event.iterator().next());
        }
        else
        {
            Assert.isNull(event.iterator());
        }
        assertTrue(_listener.validateSize(3));
        
        assertFalse(_listener.eventReceived);
        _collectionAdd.addMock(TestItems.object1);
        assertTrue(_listener.eventReceived);
        assertEquals(1, _listener.numEvents);
        event = _listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object1, event.item);
        assertEquals(1, event.numItems);
        if (Std.is(_test.collection, ITestOrder))
        {
            assertTrue(Std.is(event.iterator(), ICollectionIterator));
            assertStrictlyEquals(TestItems.object1, event.iterator().next());
        }
        else
        {
            Assert.isNull(event.iterator());
        }
        assertTrue(_listener.validateSize(4));
        
        assertFalse(_listener.eventReceived);
        _collectionAdd.addMock(TestItems.object3);
        assertTrue(_listener.eventReceived);
        assertEquals(1, _listener.numEvents);
        event = _listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object3, event.item);
        assertEquals(1, event.numItems);
        if (Std.is(_test.collection, ITestOrder))
        {
            assertTrue(Std.is(event.iterator(), ICollectionIterator));
            assertStrictlyEquals(TestItems.object3, event.iterator().next());
        }
        else
        {
            Assert.isNull(event.iterator());
        }
        assertTrue(_listener.validateSize(5));
        
        assertFalse(_listener.eventReceived);
        _collectionAdd.addMock(TestItems.object6);
        assertTrue(_listener.eventReceived);
        assertEquals(1, _listener.numEvents);
        event = _listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object6, event.item);
        assertEquals(1, event.numItems);
        if (Std.is(_test.collection, ITestOrder))
        {
            assertTrue(Std.is(event.iterator(), ICollectionIterator));
            assertStrictlyEquals(TestItems.object6, event.iterator().next());
        }
        else
        {
            Assert.isNull(event.iterator());
        }
        assertTrue(_listener.validateSize(6));
        
        assertFalse(_listener.eventReceived);
        _collectionAdd.addMock(TestItems.object5);
        assertTrue(_listener.eventReceived);
        assertEquals(1, _listener.numEvents);
        event = _listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object5, event.item);
        assertEquals(1, event.numItems);
        if (Std.is(_test.collection, ITestOrder))
        {
            assertTrue(Std.is(event.iterator(), ICollectionIterator));
            assertStrictlyEquals(TestItems.object5, event.iterator().next());
        }
        else
        {
            Assert.isNull(event.iterator());
        }
        assertTrue(_listener.validateSize(7));
    }
    
    /*
		 * Test remove
		 */
    
    public function test_remove() : Void
    {
        _test.fillCollection(TestItems.itemArray(2));
        
        setUpListener();
        
        assertFalse(_listener.eventReceived);
        _test.collection.remove(TestItems.object1);
        assertTrue(_listener.eventReceived);
        assertEquals(1, _listener.numEvents);
        var event : CollectionEvent = _listener.event;
        assertEquals(CollectionEvent.ITEM_REMOVED, event.kind);
        assertStrictlyEquals(TestItems.object1, event.item);
        assertEquals(1, event.numItems);
        if (Std.is(_test.collection, ITestOrder))
        {
            assertTrue(Std.is(event.iterator(), ICollectionIterator));
            assertStrictlyEquals(TestItems.object2, event.iterator().next());
        }
        else
        {
            Assert.isNull(event.iterator());
        }
        assertTrue(_listener.validateSize(1));
        
        // remove twice
        
        assertFalse(_listener.eventReceived);
        _test.collection.remove(TestItems.object1);
        assertFalse(_listener.eventReceived);
    }
    
    /*
		 * Test clear
		 */
    
    public function test_clear() : Void
    {
        _test.fillCollection(TestItems.itemArray(3));
        
        setUpListener();
        
        assertFalse(_listener.eventReceived);
        _test.collection.clear();
        assertTrue(_listener.eventReceived);
        assertEquals(1, _listener.numEvents);
        var event : CollectionEvent = _listener.event;
        assertEquals(CollectionEvent.RESET, event.kind);
        assertTrue(event.item == null);
        assertEquals(-1, event.numItems);
        Assert.isNull(event.iterator());
        assertTrue(_listener.validateSize(0));
        
        // clear again
        
        assertFalse(_listener.eventReceived);
        _test.collection.clear();
        assertFalse(_listener.eventReceived);
    }
    
    /*
		 * Test iterator remove
		 */
    
    public function test_iterator_remove() : Void
    {
        _test.fillCollection(TestItems.itemArray(5));
        
        setUpListener();
        
        var iterator : ICollectionIterator = try cast(_test.collection.iterator(), ICollectionIterator) catch(e:Dynamic) null;
        var items : Array<Dynamic> = _test.allItems(iterator);
        var event : CollectionEvent;
        
        // remove wrong item
        
        assertTrue(null == iterator.current);
        assertFalse(_listener.eventReceived);
        assertFalse(iterator.remove());
        assertFalse(_listener.eventReceived);
        assertTrue(_test.validateItems(TestItems.itemArray(5)));
        
        // remove at start
        
        assertStrictlyEquals(items[0], iterator.next());
        assertStrictlyEquals(items[0], iterator.current);
        assertFalse(_listener.eventReceived);
        assertTrue(iterator.remove());
        assertTrue(_listener.eventReceived);
        assertEquals(1, _listener.numEvents);
        event = _listener.event;
        assertEquals(CollectionEvent.ITEM_REMOVED, event.kind);
        assertStrictlyEquals(items[0], event.item);
        assertEquals(1, event.numItems);
        if (Std.is(_test.collection, ITestOrder))
        {
            assertTrue(Std.is(event.iterator(), ICollectionIterator));
            assertStrictlyEquals(items[1], event.iterator().next());
        }
        else
        {
            Assert.isNull(event.iterator());
        }
        assertTrue(_listener.validateSize(4));
        assertTrue(_test.validateItems([items[1], items[2], items[3], items[4]]));
        
        // remove in between
        
        assertStrictlyEquals(items[1], iterator.next());
        assertStrictlyEquals(items[2], iterator.next());
        assertStrictlyEquals(items[2], iterator.current);
        assertFalse(_listener.eventReceived);
        assertTrue(iterator.remove());
        assertTrue(_listener.eventReceived);
        assertEquals(1, _listener.numEvents);
        event = _listener.event;
        assertEquals(CollectionEvent.ITEM_REMOVED, event.kind);
        assertStrictlyEquals(items[2], event.item);
        assertEquals(1, event.numItems);
        if (Std.is(_test.collection, ITestOrder))
        {
            assertTrue(Std.is(event.iterator(), ICollectionIterator));
            assertStrictlyEquals(items[3], event.iterator().next());
        }
        else
        {
            Assert.isNull(event.iterator());
        }
        assertTrue(_listener.validateSize(3));
        assertTrue(_test.validateItems([items[1], items[3], items[4]]));
        
        // remove at end
        
        assertStrictlyEquals(items[3], iterator.next());
        assertStrictlyEquals(items[4], iterator.next());
        assertStrictlyEquals(items[4], iterator.current);
        assertFalse(_listener.eventReceived);
        assertTrue(iterator.remove());
        assertTrue(_listener.eventReceived);
        assertEquals(1, _listener.numEvents);
        event = _listener.event;
        assertEquals(CollectionEvent.ITEM_REMOVED, event.kind);
        assertStrictlyEquals(items[4], event.item);
        assertEquals(1, event.numItems);
        if (Std.is(_test.collection, ITestOrder))
        {
            assertTrue(Std.is(event.iterator(), ICollectionIterator));
            assertTrue(null == event.iterator().next());
        }
        else
        {
            Assert.isNull(event.iterator());
        }
        assertTrue(_listener.validateSize(2));
        assertTrue(_test.validateItems([items[1], items[3]]));
        
        // remove wrong item
        
        assertTrue(null == iterator.current);
        assertFalse(_listener.eventReceived);
        assertFalse(iterator.remove());
        assertFalse(_listener.eventReceived);
        assertTrue(_test.validateItems([items[1], items[3]]));
        
        // remove at end
        
        assertStrictlyEquals(items[3], iterator.previous());
        assertStrictlyEquals(items[3], iterator.current);
        assertFalse(_listener.eventReceived);
        assertTrue(iterator.remove());
        assertTrue(_listener.eventReceived);
        assertEquals(1, _listener.numEvents);
        event = _listener.event;
        assertEquals(CollectionEvent.ITEM_REMOVED, event.kind);
        assertStrictlyEquals(items[3], event.item);
        assertEquals(1, event.numItems);
        if (Std.is(_test.collection, ITestOrder))
        {
            assertTrue(Std.is(event.iterator(), ICollectionIterator));
            assertTrue(null == event.iterator().next());
        }
        else
        {
            Assert.isNull(event.iterator());
        }
        assertTrue(_listener.validateSize(1));
        assertTrue(_test.validateItems([items[1]]));
        
        // remove sole item
        
        assertStrictlyEquals(items[1], iterator.previous());
        assertStrictlyEquals(items[1], iterator.current);
        assertFalse(_listener.eventReceived);
        assertTrue(iterator.remove());
        assertTrue(_listener.eventReceived);
        assertEquals(1, _listener.numEvents);
        event = _listener.event;
        assertEquals(CollectionEvent.ITEM_REMOVED, event.kind);
        assertStrictlyEquals(items[1], event.item);
        assertEquals(1, event.numItems);
        if (Std.is(_test.collection, ITestOrder))
        {
            assertTrue(Std.is(event.iterator(), ICollectionIterator));
            assertTrue(null == event.iterator().next());
        }
        else
        {
            Assert.isNull(event.iterator());
        }
        assertTrue(_listener.validateSize(0));
        assertTrue(_test.validateItems([]));
    }
}

