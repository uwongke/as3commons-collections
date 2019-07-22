package org.as3commons.collections.framework;

interface IOrderedMapIterator extends IMapIterator {
    function addBefore(key : Dynamic, item : Dynamic) : Bool;
    function addAfter(key : Dynamic, item : Dynamic) : Bool ;
    function replace(item : Dynamic) : Bool ;
}