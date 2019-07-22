package org.as3commons.collections.framework;

interface IOrder extends ICollection {
    var first(get, never):Dynamic;
    var last(get, never):Dynamic;
    function removeFirst():Dynamic;
    function removeLast():Dynamic;
}
