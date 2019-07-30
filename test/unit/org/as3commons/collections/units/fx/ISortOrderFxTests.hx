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
import org.as3commons.collections.testhelpers.CollectionEventListener;
import org.as3commons.collections.testhelpers.TestItems;
import org.as3commons.collections.units.ITestSortOrder;

/**
	 * @author Jens Struwe 22.03.2010
	 */
class ISortOrderFxTests extends IOrderBaseFxTests
{
    private var _sortOrder(get, never) : ITestSortOrder;

    
    public function new(test : AbstractCollectionTestCase)
    {
        super(test);
    }
    
    private function get__sortOrder() : ITestSortOrder
    {
        return try cast(_test.collection, ITestSortOrder) catch(e:Dynamic) null;
    }
    
    /*
		 * Initial state
		 */
    
    public function test_init_sortOrder() : Void
    {
        assertTrue(Std.is(_test.collection, ITestSortOrder));
        assertTrue(Std.is(_test.collection, ICollectionFx));
    }
    
    /*
		 * Test add
		 */
    
    public function test_add() : Void
    {
        var listener : CollectionEventListener = new CollectionEventListener(_sortOrder);
        
        assertFalse(listener.eventReceived);
        _sortOrder.addMock(TestItems.object2);
        assertTrue(listener.eventReceived);
        assertEquals(1, listener.numEvents);
        event = listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object2, event.item);
        assertEquals(1, event.numItems);
        assertTrue(Std.is(event.iterator(), ICollectionIterator));
        assertStrictlyEquals(TestItems.object2, event.iterator().next());
        assertTrue(listener.validateSize(1));
        
        assertFalse(listener.eventReceived);
        _sortOrder.addMock(TestItems.object1);
        assertTrue(listener.eventReceived);
        assertEquals(1, listener.numEvents);
        var event : CollectionEvent = listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object1, event.item);
        assertEquals(1, event.numItems);
        assertTrue(Std.is(event.iterator(), ICollectionIterator));
        assertStrictlyEquals(TestItems.object1, event.iterator().next());
        assertTrue(listener.validateSize(2));
    }
}

