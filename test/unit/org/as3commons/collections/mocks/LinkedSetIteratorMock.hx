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
package org.as3commons.collections.mocks;

import org.as3commons.collections.LinkedSet;
import org.as3commons.collections.framework.core.LinkedNode;
import org.as3commons.collections.framework.core.LinkedSetIterator;
import org.as3commons.collections.units.iterators.ITestIteratorInsertionOrder;
import org.as3commons.collections.units.iterators.ITestIteratorNextPreviousLookup;

/**
	 * @author Jens Struwe 25.03.2010
	 */
class LinkedSetIteratorMock extends LinkedSetIterator implements ITestIteratorInsertionOrder implements ITestIteratorNextPreviousLookup
{
    public var previousMock(get, never) : Dynamic;
    public var nextMock(get, never) : Dynamic;

    public function new(map : LinkedSet, next : LinkedNode = null)
    {
        super(map, next);
    }
    
    public function addBeforeMock(item : Dynamic) : Bool
    {
        return addBefore(item);
    }
    
    public function addAfterMock(item : Dynamic) : Bool
    {
        return addAfter(item);
    }
    
    private function get_previousMock() : Dynamic
    {
        return previousItem;
    }
    
    private function get_nextMock() : Dynamic
    {
        return nextItem;
    }
}

