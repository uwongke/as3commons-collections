package org.as3commons.collections.framework;

/** Base iterator definition. */
interface IIterator {
    /** Returns true if there are succeeding items to be enumerated. */
    function hasNext():Bool;

    /** Returns the next item and places the internal cursor after that item. */
    function next():Dynamic;
}
