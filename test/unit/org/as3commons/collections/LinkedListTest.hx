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
package org.as3commons.collections;

import org.as3commons.collections.framework.ICollection;
import org.as3commons.collections.framework.ILinkedList;
import org.as3commons.collections.mocks.LinkedListMock;
import org.as3commons.collections.testhelpers.AbstractCollectionTestCase;
import org.as3commons.collections.units.ICollectionTests;

/**
	 * @author Jens Struwe 25.03.2010
	 */
class LinkedListTest extends AbstractCollectionTestCase {
    private var _linkedList(get, never):ILinkedList;


    /*
		 * AbstractCollectionTest
		 */

    override public function createCollection():ICollection {
        return new LinkedListMock();
    }

    override public function fillCollection(items:Array<Dynamic>):Void {
        collection.clear();

        for (item in items) {
            cast((collection), ILinkedList).add(item);
        }
    }

    private function get__linkedList():ILinkedList {
        return try cast(collection, ILinkedList) catch (e:Dynamic) null;
    }


    public function new() {
        super();
    }
}

