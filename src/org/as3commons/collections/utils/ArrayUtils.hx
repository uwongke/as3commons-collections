package org.as3commons.collections.utils;

import org.as3commons.collections.framework.IComparator;
import org.as3commons.collections.framework.IMap;
import org.as3commons.collections.Map;

class ArrayUtils {

    public static function arraysEqual(array1 : Array<Dynamic>, array2 : Array<Dynamic>) : Bool {
        if (array1 == array2) {
            return true;
        }
        
        var i : Int = array1.length;
        
        if (i != array2.length) {
            return false;
        }

        while (i-- !=0) {
            if (array1[i] != array2[i]) {
                return false;
            }
        }
        return true;
    }

    public static function arraysMatch(array1 : Array<Dynamic>, array2 : Array<Dynamic>) : Bool {
        if (array1 == array2) {
            return true;
        }
        
        var i : Float = array1.length;
        if (i != array2.length) {
            return false;
        }
        
        var map : IMap = new Map();
        while (i-- !=0) {
            if (map.hasKey(Reflect.field(array1, Std.string(i)))) {
                map.replaceFor(Reflect.field(array1, Std.string(i)), map.itemFor(Reflect.field(array1, Std.string(i))) + 1);
            }
            else {
                map.add(Reflect.field(array1, Std.string(i)), 1);
            }
        }
        
        i = array2.length;
        while (i-- !=0) {
            if (map.hasKey(Reflect.field(array2, Std.string(i)))) {
                if (map.itemFor(Reflect.field(array2, Std.string(i))) == 1) {
                    map.removeKey(Reflect.field(array2, Std.string(i)));
                }
                else {
                    map.replaceFor(Reflect.field(array2, Std.string(i)), map.itemFor(Reflect.field(array2, Std.string(i))) - 1);
                }
            }
            else {
                return false;
            }
        }
        
        return map.size == 0;
    }

    public static function insertionSort(array : Array<Dynamic>, comparator : IComparator) : Bool {
        if (array.length < 2) {
            return false;
        }
        var size : Int = array.length;
        for (i in 1...size) {
            var item : Dynamic = array[i];
            var j : Int;
            j = i;
            while (j > 0 && comparator.compare(array[j - 1], item) == 1) {
                array[j] = array[j - 1];
                --j;
            }
            array[j] = item;
        }
        return true;
    }

    public static function mergeSort(array : Array<Dynamic>, comparator : IComparator) : Bool {
        if (array.length < 2) {
            return false;
        }
        
        var firstHalf : Int = Math.floor(array.length / 2);
        var secondHalf : Int = as3hx.Compat.parseInt(array.length - firstHalf);
        var arr1 : Array<Dynamic> = new Array<Dynamic>(); //firstHalf
        var arr2 : Array<Dynamic> = new Array<Dynamic>(); //secondHalf
        
        var i : Int = 0;
        
        for (i in 0...firstHalf) {
            arr1[i] = array[i];
        }
        
        i = firstHalf;
        while (i < firstHalf + secondHalf) {
            arr2[i - firstHalf] = array[i];
            i++;
        }
        
        mergeSort(arr1, comparator);
        mergeSort(arr2, comparator);
        
        i = 0;
        var j : Int = 0;
        var k : Int = 0;
        
        while (arr1.length != j && arr2.length != k) {
            if (comparator.compare(arr1[j], arr2[k]) != 1) {
                array[i] = arr1[j];
                i++;
                j++;
            }
            else {
                array[i] = arr2[k];
                i++;
                k++;
            }
        }
        
        while (arr1.length != j) {
            array[i] = arr1[j];
            i++;
            j++;
        }
        
        while (arr2.length != k) {
            array[i] = arr2[k];
            i++;
            k++;
        }
        
        return true;
    }

    public static function shuffle(array : Array<Dynamic>) : Bool {
        var i : Int = array.length;
        
        if (i < 2) {
            return false;
        }
        
        var j : Int;
        var o : Dynamic;
        while (--i !=0) {
            j = Math.floor(Math.random() * (i + 1));
            o = array[i];
            array[i] = array[j];
            array[j] = o;
        }
        
        return true;
    }

    public function new() {
    }
}