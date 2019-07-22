package org.as3commons.collections.framework;

interface IBinarySearchTree extends ISortOrder {
    function add(item:Dynamic):Bool;
    function lesser(item:Dynamic):Dynamic;
    function higher(item:Dynamic):Dynamic;
    function equalItem(item:Dynamic):Dynamic;
}
