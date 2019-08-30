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

import org.as3commons.collections.ArrayList;
import org.as3commons.collections.framework.core.ArrayListIterator;
import org.as3commons.collections.units.iterators.ITestIteratorInsertionOrder;
import org.as3commons.collections.units.iterators.ITestIteratorNextPreviousLookup;

/**
	 * @author Jens Struwe 19.03.2010
	 */
class ArrayListIteratorMock extends ArrayListIterator implements ITestIteratorInsertionOrder implements ITestIteratorNextPreviousLookup
{
    public var previousMock(get, never) : Dynamic;
    public var nextMock(get, never) : Dynamic;

    
    public function new(list : ArrayList, index : Int = 0)
    {
        super(list, index);
    }
    
    public function addBeforeMock(item : Dynamic) : Bool
    {
        var index : Int = addBefore(item);
        return index > -1;
    }
    
    public function addAfterMock(item : Dynamic) : Bool
    {
        var index : Int = addAfter(item);
        return index > -1;
    }
    
    public function replaceMock(item : Dynamic) : Bool
    {
        return replace(item);
    }
    
    private function get_previousMock() : Dynamic
    {
        return _array[previousIndex];
    }
    
    private function get_nextMock() : Dynamic
    {
        return _array[nextIndex];
    }
}

