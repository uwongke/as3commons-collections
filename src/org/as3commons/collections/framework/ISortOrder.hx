package org.as3commons.collections.framework;

interface ISortOrder extends IOrder {
    var comparator(get, set):IComparator;
    function hasEqual(item:Dynamic):Bool;
}
