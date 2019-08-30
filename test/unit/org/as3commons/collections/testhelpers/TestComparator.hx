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

import org.as3commons.collections.framework.IComparator;
import org.as3commons.collections.utils.NumericComparator;
import org.as3commons.collections.utils.StringComparator;
import org.as3commons.collections.utils.UncomparableType;

/**
	 * @author Jens Struwe 22.02.2010
	 */
class TestComparator implements IComparator
{
    
    private var types : Array<Dynamic> = [
        "number", 
        "string", 
        "boolean", 
        "function", 
        "xml", 
        "object"
    ];
    
    public function compare(item1 : Dynamic, item2 : Dynamic) : Int
    // equal
    {
        
        
        if (item1 == item2)
        {
            return 0;
        }
        
        // allow null
        if (item1 == null)
        {
            return -1;
        }
        if (item2 == null)
        {
            return 1;
        }
        
        // type
        
        var type1 : Int = Lambda.indexOf(types, as3hx.Compat.typeof(item1));
        var type2 : Int = Lambda.indexOf(types, as3hx.Compat.typeof(item2));
        
        if (type1 < type2)
        {
            return -1;
        }
        else if (type1 > type2)
        {
            return 1;
        }
        
        // string
        
        if (Std.is(item1, String))
        {
            return new StringComparator().compare(item1, item2);
        }
        
        // number
        
        if (Std.is(item1, Float))
        {
            return new NumericComparator().compare(item1, item2);
        }
        
        // boolean
        
        if (Std.is(item1, Bool))
        {
            if (item1 != null)
            {
                return -1;
            }
            if (item2 != null)
            {
                return 1;
            }
        }
        
        // function TODO:: fix
        
//        if (Std.is(item1, Function))
//        {
//            return 0;
//        }
//
        // xml
        
        if (Std.is(item1, FastXML))
        {
            return 0;
        }
        
        // test item
        
        // do not allow non objects
        if (!(Std.is(item1, Dynamic)))
        {
            throw new UncomparableType(Dynamic, item1);
        }
        if (!(Std.is(item2, Dynamic)))
        {
            throw new UncomparableType(Dynamic, item2);
        }
        
        if (Reflect.field(item1, "index") < Reflect.field(item2, "index"))
        {
            return -1;
        }
        else if (Reflect.field(item1, "index") > Reflect.field(item2, "index"))
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }

    public function new()
    {
    }
}

