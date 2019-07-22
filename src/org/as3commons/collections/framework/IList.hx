package org.as3commons.collections.framework;

interface IList extends IOrder extends IDuplicates {
    var array(never, set):Array<Dynamic>;
    function add(item:Dynamic):Int;
    function firstIndexOf(item:Dynamic):Int;
    function lastIndexOf(item:Dynamic):Int;
    function itemAt(index:Int):Dynamic;
    function removeAt(index:Int):Dynamic;
    function removeAllAt(index:Int, numItems:Int):Array<Dynamic>;
}