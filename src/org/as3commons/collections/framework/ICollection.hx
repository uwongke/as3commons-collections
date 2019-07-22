package org.as3commons.collections.framework;

/** Base collection definition. */
interface ICollection extends IIterable {
    var size(get, never):Int;
    function has(item:Dynamic):Bool;
    function toArray():Array<Dynamic>;
    function remove(item:Dynamic):Bool;
    function clear():Bool;
}
