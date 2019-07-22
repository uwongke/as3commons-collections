package org.as3commons.collections.framework;

interface IOrderedList extends IList extends IInsertionOrder {
    function addFirst(item:Dynamic):Void;
    function addLast(item:Dynamic):Void;
    function addAt(index:Int, item:Dynamic):Bool;
    function addAllAt(index:Int, items:Array<Dynamic>):Bool;
    function replaceAt(index:Int, item:Dynamic):Bool;
}
