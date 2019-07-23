
package org.as3commons.collections.utils;

import org.as3commons.collections.framework.IComparator;

class NullComparator implements IComparator {
    public function compare(item1 : Dynamic, item2 : Dynamic) : Int {
        return 0;
    }

    public function new() {
    }
}

