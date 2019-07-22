package org.as3commons.collections.framework;

interface ILinkedList extends IInsertionOrder extends IDuplicates {
    function add(item:Dynamic):Void;
    function addFirst(item:Dynamic):Void;
    function addLast(item:Dynamic):Void;
}
