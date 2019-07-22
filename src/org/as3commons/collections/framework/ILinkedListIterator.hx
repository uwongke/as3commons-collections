package org.as3commons.collections.framework;

interface ILinkedListIterator extends ICollectionIterator {
    var previousItem(get, never):Dynamic;
    var nextItem(get, never):Dynamic;
    function addBefore(item:Dynamic):Void;
    function addAfter(item:Dynamic):Void;
    function replace(item:Dynamic):Bool;
}