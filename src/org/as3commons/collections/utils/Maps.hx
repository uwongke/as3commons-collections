package org.as3commons.collections.utils;

import org.as3commons.collections.framework.ISortOrder;
import flash.errors.ArgumentError;
import haxe.Constraints.Function;
import org.as3commons.collections.framework.IBasicMapIterator;
import org.as3commons.collections.framework.IComparator;
import org.as3commons.collections.framework.IMap;
import org.as3commons.collections.framework.IMapIterator;
import org.as3commons.collections.iterators.MapFilterIterator;
import org.as3commons.collections.Map;

class Maps {

    public static function newMap(args : Array<Dynamic> = null) : Map {
        var map : Map = new Map();
        addFromArray(map, args);
        return map;
    }

    public static function newLinkedMap(args : Array<Dynamic> = null) : LinkedMap {
        var map : LinkedMap = new LinkedMap();
        addFromArray(map, args);
        return map;
    }

    public static function newSortedMap(comparator : IComparator, args : Array<Dynamic> = null) : SortedMap {
        var map : SortedMap = new SortedMap(comparator);
        addFromArray(map, args);
        return map;
    }

    public static function addFromArray(map : IMap, source : Array<Dynamic>) : Int {
        if (source == null) {
            return 0;
        }
        
        var numAdded : Int;
        var wrapper : Args;
        var item : Dynamic;
        var i : Int;
        while (i < source.length) {
            if (Std.is(source[i], Args)) {
                wrapper = source[i];
                if (Std.is(wrapper.source, Array)) {
                    numAdded += addFromArray(map, try cast(wrapper.source, Array<Dynamic>) catch(e:Dynamic) null);
                }
                else if (Std.is(wrapper.source, IMap)) {
                    numAdded += addFromMap(map, try cast(wrapper.source, IMap) catch(e:Dynamic) null);
                }
                else if (Std.is(wrapper.source, Dynamic)) {
                    numAdded += addFromObject(map, wrapper.source);
                }
            }
            // skip key without item
            else {
                
                if (i == source.length - 1) {
                    break;
                }
                // ignore args wrapper for items
                item = (Std.is(source[i + 1], Args)) ? cast((source[i + 1]), Args).source : source[i + 1];
                if (map.add(source[i], item)) {
                    numAdded++;
                }
                i++;
            }
            i++;
        }
        return numAdded;
    }

    public static function addFromMap(map : IMap, source : IMap) : Int {
        if (source == null) {
            return 0;
        }
        
        var numAdded : Int;
        var iterator : IMapIterator = try cast(source.iterator(), IMapIterator) catch(e:Dynamic) null;
        while (iterator.next() != null) {
            if (map.add(iterator.key, iterator.current)) {
                numAdded++;
            }
        }
        return numAdded;
    }

    public static function addFromObject(map : IMap, source : Dynamic) : Int {
        if (source == null) {
            return 0;
        }
        
        var numAdded : Int;
        for (key in Reflect.fields(source)) {
            if (map.add(key, Reflect.field(source, key))) {
                numAdded++;
            }
        }
        return numAdded;
    }

    public static function addFromArgs(map : IMap, args : Array<Dynamic> = null) : Int {
        return addFromArray(map, args);
    }

    public static function clone(map : IMap, keyFilter : Function = null, itemFilter : Function = null) : IMap {
        var clone : IMap = Type.getClass(map);
        if (Std.is(map, ISortOrder)) {
            ISortOrder(clone).comparator = ISortOrder(map).comparator;
        }

        var iterator : IBasicMapIterator = new MapFilterIterator(map, keyFilter, itemFilter);
        var item : Dynamic;
        while (iterator.hasNext()) {
            item = iterator.next();
            clone.add(iterator.key, item);
        }
        return clone;
    }

    public static function copy(source : IMap, destination : IMap, keyFilter : Function = null, itemFilter : Function = null) : Int {
        var iterator : IBasicMapIterator = new MapFilterIterator(source, keyFilter, itemFilter);
        var item : Dynamic;
        var numAdded : Int;
        while (iterator.hasNext()) {
            item = iterator.next();
            if (destination.add(iterator.key, item)) {
                numAdded++;
            }
        }
        return numAdded;
    }

    public static function itemForOrError(map : IMap, key : Dynamic, errorMessage : String = null) : Dynamic {
        if (!map.hasKey(key)) {
            throw new ArgumentError(errorMessage || key + " does not exist in supplied map");
        }
        return map.itemFor(key);
    }

    public static function itemForOrValue(map : IMap, key : Dynamic, defaultValue : Dynamic) : Dynamic {
        if (!map.hasKey(key)) {
            return defaultValue;
        }
        return map.itemFor(key);
    }

    public static function itemForOrAdd(map : IMap, key : Dynamic, item : Dynamic) : Dynamic {
        if (!map.hasKey(key)) {
            map.add(key, item);
        }
        return map.itemFor(key);
    }

    public function new() {}
}