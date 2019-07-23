
package org.as3commons.collections.utils;

import org.as3commons.collections.framework.IComparator;

class StringComparator implements IComparator {

    public static inline var ORDER_ASC : String = "asc";

    public static inline var ORDER_DESC : String = "desc";

    public static inline var OPTION_CASESENSITIVE : String = "casesensitive";

    public static inline var OPTION_CASEINSENSITIVE : String = "caseinsensitive";

    private var _order : String;

    private var _option : String;

    public function new(order : String = "asc", option : String = "casesensitive") {
        _order = order;
        _option = option;
    }

    public function compare(item1 : Dynamic, item2 : Dynamic) : Int {
        if (!(Std.is(item1, String))) {
            throw new UncomparableType(String, item1);
        }
        if (!(Std.is(item2, String))) {
            throw new UncomparableType(String, item2);
        }
        
        var s1 : String = (_order == ORDER_ASC) ? item1 : item2;
        var s2 : String = (_order == ORDER_ASC) ? item2 : item1;
        
        if (_option == OPTION_CASEINSENSITIVE) {
            s1 = s1.toLowerCase();
            s2 = s2.toLowerCase();
        }
        
        if (s1 < s2) {
            return -1;
        }
        else if (s1 > s2) {
            return 1;
        }
        else {
            return 0;
        }
    }
}