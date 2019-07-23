package org.as3commons.collections.utils;

import org.as3commons.collections.iterators.RecursiveIterator;
import org.as3commons.collections.framework.IIterable;
import org.as3commons.collections.framework.IRecursiveIterator;

class CollectionUtils {

    public static function dumpAsString(data : IIterable) : String {
        var info : String = data + "\n";
        var iterator : IRecursiveIterator = cast new RecursiveIterator(data);
        var i : Int = 0;
        var j : Int = 0;
        var next : Dynamic;
        var prefix : String;
        while (iterator.hasNext()) {
            next = iterator.next();
            
            prefix = "";
            j = 0;
            while (j < iterator.depth + 1) {
                prefix += ".......";
                j++;
            }
            
            info += prefix + next;
            if (iterator.hasNext()) {
                info += "\n";
            }
            i++;
        }
        return info;
    }

    public function new() {
    }
}

