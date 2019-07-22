package org.as3commons.collections.framework;

interface IListIterator extends ICollectionIterator {
    var previousIndex(get, never):Int;
    var nextIndex(get, never):Int;
    var index(get, never):Int;
}
