package org.as3commons.collections.framework;

interface IMap extends IDuplicates {
    function add(key:Dynamic, item:Dynamic):Bool;
    function replaceFor(key:Dynamic, item:Dynamic):Bool;
    function hasKey(key:Dynamic):Bool;
    function itemFor(key:Dynamic):Dynamic;
    function keysToArray():Array<Dynamic>;
    function keyIterator():IIterator;
    function removeKey(key:Dynamic):Dynamic;
}
