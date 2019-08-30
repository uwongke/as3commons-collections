
package org.as3commons.collections.utils;

import openfl.errors.Error;
import openfl.errors.TypeError;

class UncomparableType  {

    public function new(expectedType : Dynamic, failedValue : Dynamic) {
        var failedType : Dynamic;
        var className : String = Type.getClassName(failedValue);
        try {
            failedType = Type.resolveClass(className);
        } catch (e : Dynamic) {
            failedType = "[class " + className + "]";
        }
        
        //super("Type not supported - expected: " + expectedType + " found: " + failedType);
    }
}