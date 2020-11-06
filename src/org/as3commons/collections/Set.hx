package org.as3commons.collections;

import flash.utils.Dictionary;
import org.as3commons.collections.framework.core.SetIterator;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.ISet;

class Set implements ISet {
    public var size(get, never) : Int;

    private var _items : Dictionary;

    private var _stringItems : Dynamic;

    private var _size : Int = 0;

    public function new() {
        _items = new Dictionary();
        _stringItems = {};
    }

    public function add(item : Dynamic) : Bool {
        if (Std.is(item, String)) {
            if (Reflect.field(_stringItems, Std.string(item)) != null) {
                return false;
            }
            Reflect.setField(_stringItems, Std.string(item), item);
        }
        else {
            if (Reflect.field(_items, Std.string(item)) != null) {
                return false;
            }
            Reflect.setField(_items, Std.string(item), item);
        }
        
        _size++;
        return true;
    }

    private function get_size() : Int {
        return _size;
    }

    public function has(item : Dynamic) : Bool {
        if (Std.is(item, String)) {
            return Reflect.field(_stringItems, Std.string(item)) != null;
        }
        return Reflect.field(_items, Std.string(item)) != null;
    }

    public function toArray() : Array<Dynamic> {
        var items : Array<Dynamic> = new Array<Dynamic>();
        var item : Dynamic;
        for (item in _stringItems) {
            items.push(item);
        }
        for (item in _items) {
            items.push(item);
        }
        return items;
    }

    public function remove(item : Dynamic) : Bool {
        if (Std.is(item, String)) {
            if (Reflect.field(_stringItems, Std.string(item)) == null) {
                return false;
            }
            Reflect.deleteField(_stringItems, Std.string(item));
        }
        else {
            if (Reflect.field(_items, Std.string(item)) == null) {
                return false;
            }
            //This is an intentional compilation error. See the README for handling the delete keyword
            //delete _items[item];
        }
        
        _size--;
        return true;
    }

    public function clear() : Bool {
        if (_size == 0) {
            return false;
        }
        _items = new Dictionary();
        _stringItems = {};
        _size = 0;
        return true;
    }

    public function iterator(cursor : Dynamic = null) : IIterator {
        return new SetIterator(this);
    }
}