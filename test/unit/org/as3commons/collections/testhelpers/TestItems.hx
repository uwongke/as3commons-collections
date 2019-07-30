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

import org.as3commons.collections.utils.ArrayUtils;

/**
	 * @author Jens Struwe 19.02.2010
	 */
class TestItems
{
    
    public static var object1Key : String;
    public static var object1 : Dynamic;
    
    public static var object2Key : String;
    public static var object2 : Dynamic;
    
    public static var object3Key : String;
    public static var object3 : Dynamic;
    
    public static var object4Key : String;
    public static var object4 : Dynamic;
    
    public static var object5Key : String;
    public static var object5 : Dynamic;
    
    public static var object6Key : String;
    public static var object6 : Dynamic;
    
    public static var object7Key : String;
    public static var object7 : Dynamic;
    
    public static var object8Key : String;
    public static var object8 : Dynamic;
    
    public static var object9Key : String;
    public static var object9 : Dynamic;
    
    public static var object10Key : String;
    public static var object10 : Dynamic;
    
    public static var object11Key : String;
    public static var object11 : Dynamic;
    
    public static function init() : Void
    {
        for (i in 1...11)
        {
            Reflect.setField(TestItems, "object" + i + "Key",  "object" + i + "key");

            var obj:Dynamic = null;
            obj = {
                index : i,
                name : "object" + i,
                toString : function() : String
                {
                    return Reflect.field(obj, "name");
                }};
            Reflect.setField(TestItems, "object" + i, obj);
        }
    }
    
    public static function cleanUp() : Void
    {
        for (i in 1...11)
        {
            Reflect.setField(TestItems, "object" + i + "Key",  null);
            Reflect.setField(TestItems, "object" + i, null);
        }
    }
    
    public static function itemArray(numItems : Int) : Array<Dynamic>
    {
        var array : Array<Dynamic> = new Array<Dynamic>();
        for (i in 1...numItems + 1)
        {
            array.push(Reflect.field(TestItems,"object" + i));
        }
        return array;
    }
    
    public static function itemArrayByIndices(indices : Array<Dynamic>) : Array<Dynamic>
    {
        var array : Array<Dynamic> = new Array<Dynamic>();
        for (i in 0...indices.length)
        {
            array.push(Reflect.field(TestItems,"object" + indices[i]));
        }
        return array;
    }
    
    public static function keyArrayByIndices(indices : Array<Dynamic>) : Array<Dynamic>
    {
        var array : Array<Dynamic> = new Array<Dynamic>();
        for (i in 0...indices.length)
        {
            array.push(Reflect.field(TestItems,"object" + indices[i] + "Key"));
        }
        return array;
    }
    
    public static function itemsEqual(indices : Array<Dynamic>, items : Array<Dynamic>) : Bool
    {
        var expectedArray : Array<Dynamic> = new Array<Dynamic>();
        for (i in 0...indices.length)
        {
            if (indices[i] == null)
            {
                expectedArray.push(null);
            }
            else
            {
                expectedArray.push(Reflect.field(TestItems,"object" + indices[i]));
            }
        }
        return ArrayUtils.arraysEqual(expectedArray, items);
    }
    
    public static function itemsMatch(indices : Array<Dynamic>, items : Array<Dynamic>) : Bool
    {
        var expectedArray : Array<Dynamic> = new Array<Dynamic>();
        for (i in 0...indices.length)
        {
            if (indices[i] == null)
            {
                expectedArray.push(null);
            }
            else
            {
                expectedArray.push(Reflect.field(TestItems,"object" + indices[i]));
            }
        }
        return ArrayUtils.arraysMatch(expectedArray, items);
    }
    
    public static function keysEqual(indices : Array<Dynamic>, keys : Array<Dynamic>) : Bool
    {
        var expectedArray : Array<Dynamic> = new Array<Dynamic>();
        for (i in 0...indices.length)
        {
            if (indices[i] == null)
            {
                expectedArray.push(null);
            }
            else
            {
                expectedArray.push(Reflect.field(TestItems,"object" + indices[i] + "Key"));
            }
        }
        return ArrayUtils.arraysEqual(expectedArray, keys);
    }
    
    public static function keysMatch(indices : Array<Dynamic>, keys : Array<Dynamic>) : Bool
    {
        var expectedArray : Array<Dynamic> = new Array<Dynamic>();
        for (i in 0...indices.length)
        {
            if (indices[i] == null)
            {
                expectedArray.push(null);
            }
            else
            {
                expectedArray.push(Reflect.field(TestItems,"object" + indices[i] + "Key"));
            }
        }
        return ArrayUtils.arraysMatch(expectedArray, keys);
    }

    public function new()
    {
    }
}

