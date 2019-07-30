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

import org.as3commons.collections.framework.ICollectionIterator;
import org.as3commons.collections.fx.events.CollectionEvent;
import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
import org.as3commons.collections.testhelpers.CollectionEventListener;
import org.as3commons.collections.testhelpers.TestItems;
import org.as3commons.collections.units.ITestInsertionOrder;
import org.as3commons.collections.units.iterators.ITestIteratorInsertionOrder;
import org.as3commons.collections.utils.StringComparator;

/**
	 * @author Jens Struwe 22.03.2010
	 */
class IInsertionOrderFxTests extends IOrderBaseFxTests
{
    private var _insertionOrder(get, never) : ITestInsertionOrder;

    
    public function new(test : AbstractCollectionTestCase)
    {
        super(test);
    }
    
    private function get__insertionOrder() : ITestInsertionOrder
    {
        return try cast(_test.collection, ITestInsertionOrder) catch(e:Dynamic) null;
    }
    
    /*
		 * Initial state
		 */
    
    public function test_init_insertionOrder() : Void
    {
        assertTrue(Std.is(_test.collection, ITestInsertionOrder));
        assertTrue(Std.is(_test.collection.iterator(), ITestIteratorInsertionOrder));
    }
    
    /*
		 * Test add first, last
		 */
    
    public function test_addFirst() : Void
    {
        var listener : CollectionEventListener = new CollectionEventListener(_insertionOrder);
        
        // add to empty list
        
        assertFalse(listener.eventReceived);
        _insertionOrder.addFirstMock(TestItems.object2);
        assertTrue(listener.eventReceived);
        assertEquals(1, listener.numEvents);
        var event : CollectionEvent = listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object2, event.item);
        assertEquals(1, event.numItems);
        assertTrue(Std.is(event.iterator(), ICollectionIterator));
        assertStrictlyEquals(TestItems.object2, event.iterator().next());
        assertTrue(listener.validateSize(1));
        
        // add at start
        
        assertFalse(listener.eventReceived);
        _insertionOrder.addFirstMock(TestItems.object1);
        assertTrue(listener.eventReceived);
        assertEquals(1, listener.numEvents);
        event = listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object1, event.item);
        assertEquals(1, event.numItems);
        assertTrue(Std.is(event.iterator(), ICollectionIterator));
        assertStrictlyEquals(TestItems.object1, event.iterator().next());
        assertTrue(listener.validateSize(2));
        
        // add at start
        
        assertFalse(listener.eventReceived);
        _insertionOrder.addFirstMock(TestItems.object3);
        assertTrue(listener.eventReceived);
        assertEquals(1, listener.numEvents);
        event = listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object3, event.item);
        assertEquals(1, event.numItems);
        assertTrue(Std.is(event.iterator(), ICollectionIterator));
        assertStrictlyEquals(TestItems.object3, event.iterator().next());
        assertTrue(listener.validateSize(3));
    }
    
    public function test_addLast() : Void
    {
        var listener : CollectionEventListener = new CollectionEventListener(_insertionOrder);
        
        // add to empty list
        
        assertFalse(listener.eventReceived);
        _insertionOrder.addLastMock(TestItems.object2);
        assertTrue(listener.eventReceived);
        assertEquals(1, listener.numEvents);
        var event : CollectionEvent = listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object2, event.item);
        assertEquals(1, event.numItems);
        assertTrue(Std.is(event.iterator(), ICollectionIterator));
        assertStrictlyEquals(TestItems.object2, event.iterator().next());
        assertTrue(listener.validateSize(1));
        
        // add at end
        
        assertFalse(listener.eventReceived);
        _insertionOrder.addLastMock(TestItems.object1);
        assertTrue(listener.eventReceived);
        assertEquals(1, listener.numEvents);
        event = listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object1, event.item);
        assertEquals(1, event.numItems);
        assertTrue(Std.is(event.iterator(), ICollectionIterator));
        assertStrictlyEquals(TestItems.object1, event.iterator().next());
        assertTrue(listener.validateSize(2));
        
        // add at end
        
        assertFalse(listener.eventReceived);
        _insertionOrder.addLastMock(TestItems.object3);
        assertTrue(listener.eventReceived);
        assertEquals(1, listener.numEvents);
        event = listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object3, event.item);
        assertEquals(1, event.numItems);
        assertTrue(Std.is(event.iterator(), ICollectionIterator));
        assertStrictlyEquals(TestItems.object3, event.iterator().next());
        assertTrue(listener.validateSize(3));
    }
    
    /*
		 * Test sort
		 */
    
    public function test_sort() : Void
    {
        _test.fillCollection(["dog", "mouse", "cat", "Wolf", "Anaconda"]);
        
        var listener : CollectionEventListener = new CollectionEventListener(_insertionOrder);
        
        assertFalse(listener.eventReceived);
        _insertionOrder.sort(new StringComparator());
        assertTrue(listener.eventReceived);
        assertEquals(1, listener.numEvents);
        var event : CollectionEvent = listener.event;
        assertEquals(CollectionEvent.RESET, event.kind);
        assertTrue(event.item == null);
        assertEquals(-1, event.numItems);
    }
    
    public function test_sort_withEmptyCollection() : Void
    {
        var listener : CollectionEventListener = new CollectionEventListener(_insertionOrder);
        
        assertFalse(listener.eventReceived);
        _insertionOrder.sort(new StringComparator());
        assertFalse(listener.eventReceived);
        
        _test.fillCollection([TestItems.object1]);
        listener.event;  // clear add event  
        listener.eventReceived;  // clear add event  
        
        assertFalse(listener.eventReceived);
        _insertionOrder.sort(new StringComparator());
        assertFalse(listener.eventReceived);
    }
    
    /*
		 * Test reverse
		 */
    
    public function test_reverse() : Void
    {
        _test.fillCollection(["dog", "mouse", "cat", "Wolf", "Anaconda"]);
        
        var listener : CollectionEventListener = new CollectionEventListener(_insertionOrder);
        
        assertFalse(listener.eventReceived);
        _insertionOrder.reverse();
        assertTrue(listener.eventReceived);
        assertEquals(1, listener.numEvents);
        var event : CollectionEvent = listener.event;
        assertEquals(CollectionEvent.RESET, event.kind);
        assertTrue(event.item == null);
        assertEquals(-1, event.numItems);
    }
    
    public function test_reverse_withEmptyCollection() : Void
    {
        var listener : CollectionEventListener = new CollectionEventListener(_insertionOrder);
        
        assertFalse(listener.eventReceived);
        _insertionOrder.reverse();
        assertFalse(listener.eventReceived);
        
        _test.fillCollection([TestItems.object1]);
        listener.event;  // clear add event  
        listener.eventReceived;  // clear add event  
        
        assertFalse(listener.eventReceived);
        _insertionOrder.reverse();
        assertFalse(listener.eventReceived);
    }
    
    /*
		 * Test iterator add before
		 */
    
    public function test_iterator_addBefore() : Void
    {
        _test.fillCollection(TestItems.itemArray(3));
        
        var listener : CollectionEventListener = new CollectionEventListener(_test.collection);
        
        var iterator : ITestIteratorInsertionOrder = try cast(_test.collection.iterator(), ITestIteratorInsertionOrder) catch(e:Dynamic) null;
        var event : CollectionEvent;
        
        // add before at start
        
        assertFalse(listener.eventReceived);
        iterator.addBeforeMock(TestItems.object4);
        assertTrue(listener.eventReceived);
        assertEquals(1, listener.numEvents);
        event = listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object4, event.item);
        assertEquals(1, event.numItems);
        assertTrue(Std.is(event.iterator(), ICollectionIterator));
        assertStrictlyEquals(TestItems.object4, event.iterator().next());
        assertTrue(_test.validateTestItems([4, 1, 2, 3]));
        assertTrue(listener.validateSize(4));
        
        // add before after first
        
        assertFalse(listener.eventReceived);
        iterator.addBeforeMock(TestItems.object5);
        assertTrue(listener.eventReceived);
        assertEquals(1, listener.numEvents);
        event = listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object5, event.item);
        assertEquals(1, event.numItems);
        assertTrue(Std.is(event.iterator(), ICollectionIterator));
        assertStrictlyEquals(TestItems.object5, event.iterator().next());
        assertTrue(_test.validateTestItems([4, 5, 1, 2, 3]));
        assertTrue(listener.validateSize(5));
        
        // add before in between
        
        assertStrictlyEquals(TestItems.object1, iterator.next());
        assertStrictlyEquals(TestItems.object2, iterator.next());
        assertFalse(listener.eventReceived);
        iterator.addBeforeMock(TestItems.object6);
        assertTrue(listener.eventReceived);
        event = listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object6, event.item);
        assertEquals(1, event.numItems);
        assertTrue(Std.is(event.iterator(), ICollectionIterator));
        assertStrictlyEquals(TestItems.object6, event.iterator().next());
        assertTrue(_test.validateTestItems([4, 5, 1, 2, 6, 3]));
        assertTrue(listener.validateSize(6));
        
        // add before at end
        
        assertStrictlyEquals(TestItems.object3, iterator.next());
        assertTrue(null == iterator.next());
        assertFalse(listener.eventReceived);
        iterator.addBeforeMock(TestItems.object7);
        assertTrue(listener.eventReceived);
        assertEquals(1, listener.numEvents);
        event = listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object7, event.item);
        assertEquals(1, event.numItems);
        assertTrue(Std.is(event.iterator(), ICollectionIterator));
        assertStrictlyEquals(TestItems.object7, event.iterator().next());
        assertTrue(_test.validateTestItems([4, 5, 1, 2, 6, 3, 7]));
        assertTrue(listener.validateSize(7));
    }
    
    /*
		 * Test iterator add after
		 */
    
    public function test_iterator_addAfter() : Void
    {
        _test.fillCollection(TestItems.itemArray(3));
        
        var listener : CollectionEventListener = new CollectionEventListener(_test.collection);
        
        var iterator : ITestIteratorInsertionOrder = try cast(_test.collection.iterator(), ITestIteratorInsertionOrder) catch(e:Dynamic) null;
        var event : CollectionEvent;
        
        // add after at start
        
        assertFalse(listener.eventReceived);
        iterator.addAfterMock(TestItems.object4);
        assertTrue(listener.eventReceived);
        assertEquals(1, listener.numEvents);
        event = listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object4, event.item);
        assertEquals(1, event.numItems);
        assertTrue(_test.validateTestItems([4, 1, 2, 3]));
        assertTrue(listener.validateSize(4));
        
        // add after at start
        
        assertFalse(listener.eventReceived);
        iterator.addAfterMock(TestItems.object5);
        assertTrue(listener.eventReceived);
        assertEquals(1, listener.numEvents);
        event = listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object5, event.item);
        assertEquals(1, event.numItems);
        assertTrue(_test.validateTestItems([5, 4, 1, 2, 3]));
        assertTrue(listener.validateSize(5));
        
        // add after in between
        
        assertStrictlyEquals(TestItems.object5, iterator.next());
        assertStrictlyEquals(TestItems.object4, iterator.next());
        assertStrictlyEquals(TestItems.object1, iterator.next());
        assertStrictlyEquals(TestItems.object2, iterator.next());
        assertFalse(listener.eventReceived);
        iterator.addAfterMock(TestItems.object6);
        assertTrue(listener.eventReceived);
        assertEquals(1, listener.numEvents);
        event = listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object6, event.item);
        assertEquals(1, event.numItems);
        assertTrue(_test.validateTestItems([5, 4, 1, 2, 6, 3]));
        assertTrue(listener.validateSize(6));
        
        // add after at end
        
        assertStrictlyEquals(TestItems.object6, iterator.next());
        assertStrictlyEquals(TestItems.object3, iterator.next());
        assertTrue(null == iterator.next());
        assertFalse(listener.eventReceived);
        iterator.addAfterMock(TestItems.object7);
        assertTrue(listener.eventReceived);
        assertEquals(1, listener.numEvents);
        event = listener.event;
        assertEquals(CollectionEvent.ITEM_ADDED, event.kind);
        assertStrictlyEquals(TestItems.object7, event.item);
        assertEquals(1, event.numItems);
        assertTrue(_test.validateTestItems([5, 4, 1, 2, 6, 3, 7]));
        assertTrue(listener.validateSize(7));
    }
    
    public function test_iterator_replace() : Void
    {
        _test.fillCollection(TestItems.itemArray(4));
        
        var listener : CollectionEventListener = new CollectionEventListener(_test.collection);
        
        var iterator : ITestIteratorInsertionOrder = try cast(_test.collection.iterator(), ITestIteratorInsertionOrder) catch(e:Dynamic) null;
        var event : CollectionEvent;
        
        // replace at wrong position
        
        assertTrue(null == iterator.current);
        assertFalse(listener.eventReceived);
        assertFalse(iterator.replace(TestItems.object5));
        assertFalse(listener.eventReceived);
        assertTrue(_test.validateItems(TestItems.itemArray(4)));
        
        // replace at start
        
        assertStrictlyEquals(TestItems.object1, iterator.next());
        assertFalse(listener.eventReceived);
        assertTrue(iterator.replace(TestItems.object5));
        assertTrue(listener.eventReceived);
        assertEquals(1, listener.numEvents);
        event = listener.event;
        assertEquals(CollectionEvent.ITEM_REPLACED, event.kind);
        assertStrictlyEquals(TestItems.object5, event.item);
        assertEquals(1, event.numItems);
        assertTrue(_test.validateTestItems([5, 2, 3, 4]));
        
        // replace in between
        
        assertStrictlyEquals(TestItems.object2, iterator.next());
        assertStrictlyEquals(TestItems.object3, iterator.next());
        assertFalse(listener.eventReceived);
        assertTrue(iterator.replace(TestItems.object6));
        assertTrue(listener.eventReceived);
        assertEquals(1, listener.numEvents);
        event = listener.event;
        assertEquals(CollectionEvent.ITEM_REPLACED, event.kind);
        assertStrictlyEquals(TestItems.object6, event.item);
        assertEquals(1, event.numItems);
        assertTrue(_test.validateTestItems([5, 2, 6, 4]));
        
        // replace at end
        
        assertStrictlyEquals(TestItems.object4, iterator.next());
        assertFalse(listener.eventReceived);
        assertTrue(iterator.replace(TestItems.object7));
        assertTrue(listener.eventReceived);
        assertEquals(1, listener.numEvents);
        event = listener.event;
        assertEquals(CollectionEvent.ITEM_REPLACED, event.kind);
        assertStrictlyEquals(TestItems.object7, event.item);
        assertEquals(1, event.numItems);
        assertTrue(_test.validateTestItems([5, 2, 6, 7]));
        
        // replace at wrong position after last
        
        assertTrue(null == iterator.next());
        assertTrue(null == iterator.current);
        assertFalse(listener.eventReceived);
        assertFalse(iterator.replace(TestItems.object5));
        assertFalse(listener.eventReceived);
        assertTrue(_test.validateTestItems([5, 2, 6, 7]));
    }
}

