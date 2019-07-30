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

import org.as3commons.collections.framework.ICollectionFx;
import org.as3commons.collections.framework.IListIterator;
import org.as3commons.collections.fx.events.CollectionEvent;
import org.as3commons.collections.fx.events.ListEvent;
import org.as3commons.collections.fx.events.MapEvent;

/**
	 * @author Jens Struwe 01.03.2010
	 */
class CollectionEventListener
{
    public var eventReceived(get, never) : Bool;
    public var event(get, never) : Dynamic;
    public var numEvents(get, never) : Int;
    public var events(get, never) : Array<Dynamic>;

    
    private var _collection : ICollectionFx;
    private var _eventReceived : Bool = false;
    private var _event : CollectionEvent;
    private var _events : Array<Dynamic>;
    private var _sizes : Array<Dynamic>;
    
    public function new(collection : Dynamic)
    {
        _collection = collection;
        _events = new Array<Dynamic>();
        _sizes = new Array<Dynamic>();
        _collection.addEventListener(CollectionEvent.COLLECTION_CHANGED, collectionChanged);
    }
    
    private function collectionChanged(event : CollectionEvent) : Void
    {
        _eventReceived = true;
        _event = event;
        _events.push(event);
        _sizes.push(_collection.size);
    }
    
    private function get_eventReceived() : Bool
    {
        var received : Bool = _eventReceived;
        _eventReceived = false;
        return received;
    }
    
    private function get_event() : Dynamic
    {
        var event : CollectionEvent = _event;
        _events = new Array<Dynamic>();
        _event = null;
        return event;
    }
    
    private function get_numEvents() : Int
    {
        return _events.length;
    }
    
    private function get_events() : Array<Dynamic>
    {
        var events : Array<Dynamic> = _events;
        _events = new Array<Dynamic>();
        _event = null;
        return events;
    }
    
    public function cleanUp() : Void
    {
        _collection.removeEventListener(CollectionEvent.COLLECTION_CHANGED, collectionChanged);
    }
    
    public function validateSize(expectedSize : Int) : Bool
    {
        eventReceived;  // clear  
        var size : Int = _sizes[0];
        _sizes = new Array<Dynamic>();
        return size == expectedSize;
    }
    
    public function validateSizes(expectedSizes : Array<Dynamic>) : Bool
    {
        eventReceived;  // clear  
        for (i in 0..._sizes.length)
        {
            if (expectedSizes[i] != _sizes[i])
            {
                return false;
            }
        }
        _sizes = new Array<Dynamic>();
        return true;
    }
    
    public function validateIndex(expectedIndex : Int) : Bool
    {
        eventReceived;  // clear  
        var listEvent : ListEvent = event;
        if (expectedIndex != listEvent.index)
        {
            return false;
        }
        
        if (expectedIndex > -1)
        {
            if (!(Std.is(listEvent.iterator(), IListIterator)))
            {
                return false;
            }
            if (listEvent.list.itemAt(listEvent.index) != listEvent.iterator().next())
            {
                return false;
            }
        }
        else if (listEvent.iterator())
        {
            return false;
        }
        return true;
    }
    
    public function validateIndices(expectedIndices : Array<Dynamic>) : Bool
    {
        eventReceived;  // clear  
        var events : Array<Dynamic> = events;
        for (i in 0...events.length)
        {
            var listEvent : ListEvent = events[i];
            if (expectedIndices[i] != listEvent.index)
            {
                return false;
            }
            
            if (!(Std.is(listEvent.iterator(), IListIterator)))
            {
                return false;
            }
            if (listEvent.list.itemAt(listEvent.index) != listEvent.iterator().next())
            {
                return false;
            }
        }
        return true;
    }
    
    public function validateKey(expectedKey : Dynamic) : Bool
    {
        eventReceived;  // clear  
        var mapEvent : MapEvent = event;
        if (expectedKey != mapEvent.key)
        {
            return false;
        }
        return true;
    }
    
    public function validateKeys(expectedKeys : Array<Dynamic>) : Bool
    {
        eventReceived;  // clear  
        var events : Array<Dynamic> = events;
        for (i in 0...events.length)
        {
            var mapEvent : MapEvent = events[i];
            if (expectedKeys[i] != mapEvent.key)
            {
                return false;
            }
        }
        return true;
    }
    
    public function eventKeys() : Array<Dynamic>
    {
        var keys : Array<Dynamic> = new Array<Dynamic>();
        eventReceived;  // clear  
        var events : Array<Dynamic> = events;
        for (i in 0...events.length)
        {
            keys.push(cast((events[i]), MapEvent).key);
        }
        return keys;
    }
}

