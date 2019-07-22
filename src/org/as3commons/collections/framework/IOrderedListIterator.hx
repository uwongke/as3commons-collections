package org.as3commons.collections.framework;

interface IOrderedListIterator extends IListIterator {
    function addBefore(item:Dynamic):Int;
    function addAfter(item:Dynamic):Int;
    function replace(item:Dynamic):Bool;
}