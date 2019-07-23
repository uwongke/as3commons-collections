
package org.as3commons.collections.utils;

import org.as3commons.collections.framework.IComparator;
import org.as3commons.collections.framework.IMap;
import org.as3commons.collections.Map;

class MapBuilder {

    private var _map : IMap;

    public static function newMap() : MapBuilder {
        return new MapBuilder(new Map());
    }

    public static function newLinkedMap() : MapBuilder {
        return new MapBuilder(new LinkedMap());
    }

    public static function newSortedMap(comparator : IComparator) : MapBuilder {
        return new MapBuilder(new SortedMap(comparator));
    }

    public function new(underlyingMap : IMap) {
        _map = underlyingMap;
    }

    public function add(key : Dynamic, item : Dynamic) : MapBuilder {
        _map.add(key, item);
        return this;
    }

    public function build() : IMap {
        return _map;
    }
}