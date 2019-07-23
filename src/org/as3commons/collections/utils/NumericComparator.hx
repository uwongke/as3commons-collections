package org.as3commons.collections.utils;

import org.as3commons.collections.framework.IComparator;

class NumericComparator implements IComparator {

    public static inline var ORDER_ASC : String = "asc";

    public static inline var ORDER_DESC : String = "desc";

    private var _order : String;

    public function new(order : String = "asc") {
        _order = order;
    }

    public function compare(item1 : Dynamic, item2 : Dynamic) : Int {
        if (Math.isNaN(item1)) {
            throw new UncomparableType(Float, item1);
        }
        if (Math.isNaN(item2)) {
            throw new UncomparableType(Float, item2);
        }
        
        var n1 : Float = (_order == ORDER_ASC) ? item1 : item2;
        var n2 : Float = (_order == ORDER_ASC) ? item2 : item1;
        
        if (n1 < n2) {
            return -1;
        }
        else if (n1 > n2) {
            return 1;
        }
        else {
            return 0;
        }
    }
}

