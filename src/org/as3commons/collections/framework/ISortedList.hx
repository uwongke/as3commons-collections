package org.as3commons.collections.framework;

interface ISortedList extends IList extends ISortOrder {
    function lesserIndex(item : Dynamic) : Int ;
    function higherIndex(item : Dynamic) : Int ;
    function equalIndices(item : Dynamic) : Array<Dynamic> ;
}