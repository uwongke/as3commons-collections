package org.as3commons.collections.framework;

interface ISortedSet extends ISet extends ISortOrder {
    function next(item : Dynamic) : Dynamic ;
    function previous(item : Dynamic) : Dynamic ;
    function lesser(item : Dynamic) : Dynamic ;
    function higher(item : Dynamic) : Dynamic ;
    function equalItems(item : Dynamic) : Array<Dynamic> ;
}