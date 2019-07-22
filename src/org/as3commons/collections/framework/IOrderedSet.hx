package org.as3commons.collections.framework;

interface IOrderedSet extends ISet extends IInsertionOrder {
    function addFirst(item : Dynamic) : Bool ;
    function addLast(item : Dynamic) : Bool ;
    function addBefore(nextItem : Dynamic, item : Dynamic) : Bool ;
    function addAfter(previousItem : Dynamic, item : Dynamic) : Bool ;
    function replace(oldItem : Dynamic, item : Dynamic) : Bool ;
    function next(item : Dynamic) : Dynamic ;
    function previous(item : Dynamic) : Dynamic ;
}
