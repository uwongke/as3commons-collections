package org.as3commons.collections.framework;

interface ISetIterator extends ICollectionIterator {
    var previousItem(get, never) : Dynamic;
    var nextItem(get, never) : Dynamic;
}