package org.as3commons.collections.framework;

/** Iterable data structure definition. */
interface IIterable {
    /** Returns an iterator over the iterable data structure. */
    function iterator(cursor : Dynamic = null) : IIterator ;
}
