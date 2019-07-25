
package org.as3commons.collections;

import org.as3commons.collections.framework.core.MapIterator;
import openfl.utils.Dictionary;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.IMap;
import org.as3commons.collections.iterators.ArrayIterator;

class Map implements IMap {

    public var size(get, never) : Int;

    private var _keys : Dictionary<Dynamic, Dynamic>;

    private var _items : Dictionary<Dynamic, Dynamic>;

    private var _stringMap : Dynamic;

    private var _size : Int = 0;

    public function new() {
        _items = new Dictionary();
        _keys = new Dictionary();
        _stringMap = {};
    }

    public function add(key : Dynamic, item : Dynamic) : Bool {
        if (Std.is(key, String)) {
            if (Reflect.field(_stringMap, Std.string(key)) != null) {
                return false;
            }
            Reflect.setField(_stringMap, Std.string(key), item);
        }
        else {
            if (Reflect.field(_keys, Std.string(key)) != null) {
                return false;
            }
            Reflect.setField(_keys, Std.string(key), key);
            Reflect.setField(_items, Std.string(key), item);
        }
        
        _size++;
        return true;
    }

    public function replaceFor(key : Dynamic, item : Dynamic) : Bool {
        if (Std.is(key, String)) {
            if (Reflect.field(_stringMap, Std.string(key)) == null) {
                return false;
            }
            if (Reflect.field(_stringMap, Std.string(key)) == item) {
                return false;
            }
            Reflect.setField(_stringMap, Std.string(key), item);
        }
        else {
            if (Reflect.field(_keys, Std.string(key)) == null) {
                return false;
            }
            if (Reflect.field(_items, Std.string(key)) == item) {
                return false;
            }
            Reflect.setField(_items, Std.string(key), item);
        }
        return true;
    }

    ////omit
    public function count(item : Dynamic) : Int {
//        var count : Int = 0;
//        var thisItem : Dynamic;
//        /** AS3HX WARNING could not determine type for var: thisItem exp: EIdent(_stringMap) type: Dynamic */
//        for(i in 0..._stringMap)
//        for (thisItem in _stringMap) {
//            if (thisItem == item) {
//                count++;
//            }
//        }
//
//        /** AS3HX WARNING could not determine type for var: thisItem exp: EIdent(_items) type: Dictionary */
//        for (thisItem in _items) {
//            if (thisItem == item) {
//                count++;
//            }
//        }
//        return count;
        return 0;
    }

    public function hasKey(key : Dynamic) : Bool {
        return (Std.is(key, String)) ? Reflect.field(_stringMap, Std.string(key)) != null : Reflect.field(_keys, Std.string(key)) != null;
    }

    public function itemFor(key : Dynamic) : Dynamic {
        if (Std.is(key, String)) {
            return Reflect.field(_stringMap, Std.string(key));
        }
        return Reflect.field(_items, Std.string(key));
    }

    public function keysToArray() : Array<Dynamic> {
        var keys : Array<Dynamic> = new Array<Dynamic>();
        for (string in Reflect.fields(_stringMap)) {
            keys.push(string);
        }

        /* AS3HX WARNING could not determine type for var: key exp: EIdent(_keys) type: Dictionary */
        for (key in _keys) {
            keys.push(key);
        }
        return keys;
    }

    public function keyIterator() : IIterator {
        return new ArrayIterator(keysToArray());
    }

    public function removeKey(key : Dynamic) : Dynamic {
        var item : Dynamic;
        if (Std.is(key, String)) {
            if (Reflect.field(_stringMap, Std.string(key)) == null) {
                return null;
            }
            item = Reflect.field(_stringMap, Std.string(key));
            Reflect.deleteField(_stringMap, Std.string(key));
        }
        else {
            if (Reflect.field(_keys, Std.string(key)) == null) {
                return null;
            }
            item = Reflect.field(_items, Std.string(key));
            //This is an intentional compilation error. See the README for handling the delete keyword
            //delete _keys[key];
            //This is an intentional compilation error. See the README for handling the delete keyword
            //delete _items[key];
        }
        
        _size--;
        return item;
    }

    public function removeAll(item : Dynamic) : Int {
        var count : Int = 0;
        for (string in Reflect.fields(_stringMap)) {
            if (Reflect.field(_stringMap, string) == item) {
                Reflect.deleteField(_stringMap, string);
                _size--;
                
                itemRemoved(string, item);  // notify subclasses  
                
                count++;
            }
        }
        for (key in Reflect.fields(_items)) {
            //if (Reflect.field(_items, key) == item) {
                //This is an intentional compilation error. See the README for handling the delete keyword
                //delete _keys[key];
                //This is an intentional compilation error. See the README for handling the delete keyword
                //delete _items[key];
                //_size--;
                
                //itemRemoved(string, item);  // notify subclasses
                
                //count++;
            //}
        }
        return count;
    }

    private function get_size() : Int {
        return _size;
    }

    public function has(item : Dynamic) : Bool {
        var thisItem : Dynamic;

        /** AS3HX WARNING could not determine type for var: thisItem exp: EIdent(_stringMap) type: Dynamic */
//        for (thisItem in _stringMap) {
//            if (thisItem == item) {
//                return true;
//            }
//        }
//
//        /** AS3HX WARNING could not determine type for var: thisItem exp: EIdent(_items) type: Dictionary */
//        for (thisItem in _items) {
//            if (thisItem == item) {
//                return true;
//            }
//        }
        return false;
    }

    public function toArray() : Array<Dynamic> {
        var items : Array<Dynamic> = new Array<Dynamic>();
        var item : Dynamic;

        /** AS3HX WARNING could not determine type for var: item exp: EIdent(_stringMap) type: Dynamic */
//        for (item in _stringMap) {
//            items.push(item);
//        }
//
//        /** AS3HX WARNING could not determine type for var: item exp: EIdent(_items) type: Dictionary */
//        for (item in _items) {
//            items.push(item);
//        }
        return items;
    }

    public function remove(item : Dynamic) : Bool {
        for (string in Reflect.fields(_stringMap)) {
            if (Reflect.field(_stringMap, string) == item) {
                Reflect.deleteField(_stringMap, string);
                _size--;
                
                itemRemoved(string, item);  // notify subclasses  
                
                return true;
            }
        }
        for (key in Reflect.fields(_items)) {
            if (Reflect.field(_items, key) == item) {
                //This is an intentional compilation error. See the README for handling the delete keyword
                //delete _keys[key];
                //This is an intentional compilation error. See the README for handling the delete keyword
                //delete _items[key];
                _size--;
                
                //itemRemoved(string, item);  // notify subclasses
                
                return true;
            }
        }
        return false;
    }

    public function clear() : Bool {
        if (_size == 0) {
            return false;
        }
        _keys = new Dictionary();
        _items = new Dictionary();
        _stringMap = {};
        _size = 0;
        return true;
    }

    public function iterator(cursor : Dynamic = null) : IIterator {
        return new MapIterator(this);
    }

    private function itemRemoved(key : Dynamic, item : Dynamic) : Void {
        
    }
}

