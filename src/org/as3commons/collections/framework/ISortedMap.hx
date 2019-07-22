package org.as3commons.collections.framework;

interface ISortedMap extends IMap extends ISortOrder {
    var firstKey(get, never) : Dynamic;
    var lastKey(get, never) : Dynamic;
    function nextKey(key : Dynamic) : Dynamic ;
    function previousKey(key : Dynamic) : Dynamic ;
    function lesserKey(item : Dynamic) : Dynamic ;
    function higherKey(item : Dynamic) : Dynamic ;
    function equalKeys(item : Dynamic) : Array<Dynamic> ;
}