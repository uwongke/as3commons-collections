package org.as3commons.collections.framework;

interface ICollectionIterator extends IIterator {
    var current(get, never):Dynamic;
    function hasPrevious():Bool;
    function previous():Dynamic;
    function start():Void;
    function end():Void;
    function remove():Bool;
}