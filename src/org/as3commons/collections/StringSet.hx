
package org.as3commons.collections;

import org.as3commons.collections.framework.core.SetIterator;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.ISet;

class StringSet implements ISet {
    public var size(get, never) : Int;

    private var _items : Dynamic;

    private var _size : Int = 0;

    public function new() {
        _items = {};
    }

    public function add(item : Dynamic) : Bool {
        if (Reflect.field(_items, Std.string(item)) != null) {
            return false;
        }
        Reflect.setField(_items, Std.string(item), item);
        
        _size++;
        return true;
    }

    private function get_size() : Int {
        return _size;
    }

    public function has(item : Dynamic) : Bool {
        return Reflect.field(_items, Std.string(item)) != null;
    }

    public function toArray() : Array<Dynamic> {
        var items : Array<Dynamic> = new Array<Dynamic>();
        var item : Dynamic;
        /** AS3HX WARNING could not determine type for var: item exp: EIdent(_items) type: Dynamic */
        for (item in _items) {
            items.push(item);
        }
        return items;
    }

    public function remove(item : Dynamic) : Bool {
        if (Reflect.field(_items, Std.string(item)) == null) {
            return false;
        }
        Reflect.deleteField(_items, Std.string(item));
        
        _size--;
        return true;
    }

    public function clear() : Bool {
        if (_size == 0) {
            return false;
        }
        _items = {};
        _size = 0;
        return true;
    }

    public function iterator(cursor : Dynamic = null) : IIterator {
        return new SetIterator(this);
    }
}