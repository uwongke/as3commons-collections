
package org.as3commons.collections.utils;

import org.as3commons.collections.framework.IComparator;
import org.as3commons.collections.framework.ISet;
import org.as3commons.collections.LinkedSet;
import org.as3commons.collections.Set;

class SetBuilder {

    private var _set : ISet;

    public static function newSet() : SetBuilder {
        return new SetBuilder(new Set());
    }

    public static function newLinkedSet() : SetBuilder {
        return new SetBuilder(new LinkedSet());
    }

    public static function newSortedSet(comparator : IComparator) : SetBuilder {
        return new SetBuilder(new SortedSet(comparator));
    }

    public function new(underlyingSet : ISet) {
        _set = underlyingSet;
    }

    public function add(item : Dynamic) : SetBuilder {
        _set.add(item);
        return this;
    }

    public function build() : ISet {
        return _set;
    }
}