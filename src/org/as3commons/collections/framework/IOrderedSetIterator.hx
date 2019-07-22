package org.as3commons.collections.framework;

interface IOrderedSetIterator extends ISetIterator {
    function addBefore(item : Dynamic) : Bool ;
    function addAfter(item : Dynamic) : Bool ;
    function replace(item : Dynamic) : Bool ;
}