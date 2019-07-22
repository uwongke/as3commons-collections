package org.as3commons.collections.framework;

interface IMapIterator extends ICollectionIterator extends IBasicMapIterator {
    var previousKey(get, never):Dynamic;
    var nextKey(get, never):Dynamic;

}

