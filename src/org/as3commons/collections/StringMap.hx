
package org.as3commons.collections;

import org.as3commons.collections.framework.core.MapIterator;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.IMap;
import org.as3commons.collections.iterators.ArrayIterator;

class StringMap implements IMap {
    public var size(get, never) : Int;

    private var _map : Dynamic;

    private var _size : Int = 0;

    public function new() {
        _map = {};
    }

    public function add(key : Dynamic, item : Dynamic) : Bool {
        if (Reflect.field(_map, Std.string(key)) != null) {
            return false;
        }
        Reflect.setField(_map, Std.string(key), item);
        
        _size++;
        return true;
    }

    public function replaceFor(key : Dynamic, item : Dynamic) : Bool {
        if (Reflect.field(_map, Std.string(key)) == null) {
            return false;
        }
        if (Reflect.field(_map, Std.string(key)) == item) {
            return false;
        }
        Reflect.setField(_map, Std.string(key), item);
        return true;
    }

    public function count(item : Dynamic) : Int {
        var count : Int = 0;
        var thisItem : Dynamic;
        for (thisItem in _map) {
            if (thisItem == item) {
                count++;
            }
        }
        return count;
    }

    public function hasKey(key : Dynamic) : Bool {
        return Reflect.field(_map, Std.string(key)) != null;
    }

    public function itemFor(key : Dynamic) : Dynamic {
        return Reflect.field(_map, Std.string(key));
    }

    public function keysToArray() : Array<Dynamic> {
        var keys : Array<Dynamic> = new Array<Dynamic>();
        for (string in Reflect.fields(_map)) {
            keys.push(string);
        }
        return keys;
    }

    public function keyIterator() : IIterator {
        return new ArrayIterator(keysToArray());
    }

    public function removeKey(key : Dynamic) : Dynamic {
        if (Reflect.field(_map, Std.string(key)) == null) {
            return null;
        }
        var item : Dynamic = Reflect.field(_map, Std.string(key));
        Reflect.deleteField(_map, Std.string(key));
        
        _size--;
        return item;
    }

    public function removeAll(item : Dynamic) : Int {
        var count : Int = 0;
        for (string in Reflect.fields(_map)) {
            if (Reflect.field(_map, string) == item) {
                Reflect.deleteField(_map, string);
                _size--;
                
                itemRemoved(string, item);  // notify subclasses  
                
                count++;
            }
        }
        return count;
    }

    private function get_size() : Int {
        return _size;
    }

    public function has(item : Dynamic) : Bool {
        var thisItem : Dynamic;
        for (thisItem in _map) {
            if (thisItem == item) {
                return true;
            }
        }
        return false;
    }

    public function toArray() : Array<Dynamic> {
        var items : Array<Dynamic> = new Array<Dynamic>();
        var item : Dynamic;
        for (item in _map) {
            items.push(item);
        }
        return items;
    }

    public function remove(item : Dynamic) : Bool {
        for (string in Reflect.fields(_map)) {
            if (Reflect.field(_map, string) == item) {
                Reflect.deleteField(_map, string);
                _size--;
                
                itemRemoved(string, item);  // notify subclasses  
                
                return true;
            }
        }
        return false;
    }

    public function clear() : Bool {
        if (_size == 0) {
            return false;
        }
        _map = {};
        _size = 0;
        return true;
    }

    public function iterator(cursor : Dynamic = null) : IIterator {
        return new MapIterator(this);
    }

    private function itemRemoved(key : Dynamic, item : Dynamic) : Void {
        
    }
}