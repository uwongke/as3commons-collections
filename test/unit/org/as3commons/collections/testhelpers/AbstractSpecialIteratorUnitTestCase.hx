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


/**
	 * @author Jens Struwe 19.03.2010
	 */
class AbstractSpecialIteratorUnitTestCase extends AbstractIteratorUnitTestCase
{
    private var _specialIteratorTest(get, never) : AbstractSpecialIteratorTestCase;

    
    public function new(test : AbstractIteratorTestCase)
    {
        super(test);
    }
    
    private function get__specialIteratorTest() : AbstractSpecialIteratorTestCase
    {
        return try cast(_test, AbstractSpecialIteratorTestCase) catch(e:Dynamic) null;
    }
}

