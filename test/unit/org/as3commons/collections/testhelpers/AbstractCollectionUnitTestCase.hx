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

import haxe.Constraints.Function;


/**
	 * @author Jens Struwe 24.02.2010
	 */
class AbstractCollectionUnitTestCase extends TestCaseBase
{
    
    private var _test : AbstractCollectionTestCase;
    
    public function new(test : AbstractCollectionTestCase)
    {
        super();
        _test = test;
    }

    override  public function setup()
    {
        _test.setUp();
    }
    override public function tearDown()
    {
        _test.tearDown();
    }
//    public function runAllTests(tests:Array<Function>) : Void
//    //			var unitTest : String = "[" + getQualifiedClassName(this).replace(/^.*::/, "") + "]";
//    {
//
//        //			var collectionTest : String = "[" + getQualifiedClassName(_test).replace(/^.*::/, "") + "]";
//       // var description : FastXML = describeType(this);
//
//        //var list : FastXMLList = description.node.descendants.innerData("method").att.name;
//        for (method in tests)
//        {
//            if (Std.string(method).indexOf("test") == 0)
//            {
//                _test.setUp();
//                setUp();
//                method();
//                //this[Std.string(method)]();
//                //					trace (collectionTest + "::" + unitTest + "::" + method + "()");
//                //					trace (collectionTest + "::" + method + "()");
//
//                tearDown();
//                _test.tearDown();
//            }
//        }
//    }
}

