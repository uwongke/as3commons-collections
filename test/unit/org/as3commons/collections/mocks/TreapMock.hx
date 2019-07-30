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

import org.as3commons.collections.Treap;
import org.as3commons.collections.framework.IComparator;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.core.TreapNode;
import org.as3commons.collections.units.ITestSortOrder;

/**
	 * @author Jens Struwe 29.03.2010
	 */
class TreapMock extends Treap implements ITestSortOrder
{
    public function new(comparator : IComparator = null)
    {
        super(comparator);
    }
    
    override public function iterator(cursor : Dynamic = null) : IIterator
    {
        var node : TreapNode = (cursor == null) ? null : getNode(cursor);
        return new TreapIteratorMock(this, node);
    }
    
    public function addMock(item : Dynamic) : Void
    {
        add(item);
    }
    
    public function equalItems(item : Dynamic) : Array<Dynamic>
    {
        var equalItems : Array<Dynamic> = new Array<Dynamic>();
        var equal : Dynamic = equalItem(item);
        if (equal != null)
        {
            equalItems.push(equal);
        }
        return equalItems;
    }
}

