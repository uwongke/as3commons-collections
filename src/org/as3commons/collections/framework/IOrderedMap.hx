package org.as3commons.collections.framework;

interface IOrderedMap extends IMap extends IInsertionOrder {
    var firstKey(get, never) : Dynamic;
    var lastKey(get, never) : Dynamic;
    function addFirst(key : Dynamic, item : Dynamic) : Bool ;
    function addLast(key : Dynamic, item : Dynamic) : Bool ;
    function addBefore(nextKey : Dynamic, key : Dynamic, item : Dynamic) : Bool ;
    function addAfter(previousKey : Dynamic, key : Dynamic, item : Dynamic) : Bool ;
    function nextKey(key : Dynamic) : Dynamic ;
    function previousKey(key : Dynamic) : Dynamic ;
}
