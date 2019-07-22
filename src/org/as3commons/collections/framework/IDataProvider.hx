package org.as3commons.collections.framework;

interface IDataProvider {
    var size(get, never):Int;
    function itemAt(index:Int):Dynamic;
}
