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
package org.as3commons.collections.fx;

import org.as3commons.collections.LinkedSetTest;
import org.as3commons.collections.framework.ICollection;
import org.as3commons.collections.framework.IOrderedSet;
import org.as3commons.collections.framework.IOrderedSetIterator;
import org.as3commons.collections.fx.events.CollectionEvent;
import org.as3commons.collections.fx.events.SetEvent;
import org.as3commons.collections.mocks.LinkedSetFxMock;
import org.as3commons.collections.testhelpers.CollectionEventListener;
import org.as3commons.collections.testhelpers.TestItems;
import org.as3commons.collections.units.fx.ICollectionFxTests;
import org.as3commons.collections.units.fx.IInsertionOrderFxTests;

/**
	 * @author Jens Struwe 29.03.2010
	 */
class LinkedSetFxTest extends LinkedSetTest
{
    private var _linkedSet(get, never) : IOrderedSet;

    
    /*
		 * AbstractCollectionTest
		 */
    
    override public function createCollection() : ICollection
    {
        return new LinkedSetFxMock();
    }
    
    private function get__linkedSet() : IOrderedSet
    {
        return try cast(collection, IOrderedSet) catch(e:Dynamic) null;
    }
    
    /*
		 * Test neutralisation
		 */
    
    private var _listener : CollectionEventListener;
    
    override public function setUp() : Void
    {
        super.setUp();
        setUpListener();
    }
    
    override public function tearDown() : Void
    {
        super.tearDown();
        _listener = null;
    }
    
    private function setUpListener() : Void
    {
        _listener = new CollectionEventListener(collection);
    }
    
    /*
		 * Units
		 */
    
    /*
		 * Collection tests
		 */
    
    public function test_set_fx() : Void
    {
        new ICollectionFxTests(this).runAllTests();
    }
    
    /*
		 * Order tests
		 */
    
    public function test_order_fx() : Void
    {
        new IInsertionOrderFxTests(this).runAllTests();
    }
    
    /*
		 * LinkedSetFx
		 */
    
    /*
		 * Test replace
		 */
    
    public function test_replace_fx() : Void
    {
        assertTrue(_linkedSet.add(TestItems.object1));
        assertTrue(_linkedSet.add(TestItems.object2));
        assertTrue(_linkedSet.add(TestItems.object3));
        assertTrue(_linkedSet.add(TestItems.object4));
        
        setUpListener();
        
        assertFalse(_listener.eventReceived);
        _linkedSet.replace(TestItems.object1, TestItems.object5);
        assertTrue(_listener.eventReceived);
        assertEquals(1, _listener.numEvents);
        var event : SetEvent = _listener.event;
        assertEquals(CollectionEvent.ITEM_REPLACED, event.kind);
        assertStrictlyEquals(TestItems.object5, event.item);
        assertEquals(1, event.numItems);
        assertTrue(Std.is(event.iterator(), IOrderedSetIterator));
        assertStrictlyEquals(TestItems.object5, event.iterator().next());
        assertTrue(_listener.validateSize(4));
        
        // replace for
        
        assertFalse(_listener.eventReceived);
        _linkedSet.replace(TestItems.object4, TestItems.object6);
        assertTrue(_listener.eventReceived);
        assertEquals(1, _listener.numEvents);
        event = _listener.event;
        assertEquals(CollectionEvent.ITEM_REPLACED, event.kind);
        assertStrictlyEquals(TestItems.object6, event.item);
        assertEquals(1, event.numItems);
        assertTrue(Std.is(event.iterator(), IOrderedSetIterator));
        assertStrictlyEquals(TestItems.object6, event.iterator().next());
        assertTrue(_listener.validateSize(4));
        
        // replace for
        
        assertFalse(_listener.eventReceived);
        _linkedSet.replace(TestItems.object3, TestItems.object7);
        assertTrue(_listener.eventReceived);
        assertEquals(1, _listener.numEvents);
        event = _listener.event;
        assertEquals(CollectionEvent.ITEM_REPLACED, event.kind);
        assertStrictlyEquals(TestItems.object7, event.item);
        assertEquals(1, event.numItems);
        assertTrue(Std.is(event.iterator(), IOrderedSetIterator));
        assertStrictlyEquals(TestItems.object7, event.iterator().next());
        assertTrue(_listener.validateSize(4));
    }
    
    public function test_replace_sameItem_fx() : Void
    {
        _linkedSet.add(TestItems.object1);
        
        setUpListener();
        
        assertFalse(_listener.eventReceived);
        _linkedSet.replace(TestItems.object1, TestItems.object1);
        assertFalse(_listener.eventReceived);
    }
    
    public function test_replace_containedItem_fx() : Void
    {
        _linkedSet.add(TestItems.object1);
        _linkedSet.add(TestItems.object2);
        
        setUpListener();
        
        assertFalse(_listener.eventReceived);
        _linkedSet.replace(TestItems.object1, TestItems.object2);
        assertFalse(_listener.eventReceived);
    }
    public function test_replace_wrongItem_fx() : Void
    {
        _linkedSet.add(TestItems.object1);
        
        setUpListener();
        
        assertFalse(_listener.eventReceived);
        _linkedSet.replace(TestItems.object2, TestItems.object2);
        assertFalse(_listener.eventReceived);
    }

    public function new()
    {
        super();
    }
}

