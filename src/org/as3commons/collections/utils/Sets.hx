package org.as3commons.collections.utils;

import org.as3commons.collections.framework.ISortOrder;
import haxe.Constraints.Function;
import org.as3commons.collections.framework.ICollection;
import org.as3commons.collections.framework.IComparator;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.ISet;
import org.as3commons.collections.iterators.FilterIterator;

class Sets {

    public static function newSet(args : Array<Dynamic> = null) : Set {
        var theSet : Set = new Set();
        addFromArray(theSet, args);
        return theSet;
    }

    public static function newLinkedSet(args : Array<Dynamic> = null) : LinkedSet {
        var theSet : LinkedSet = new LinkedSet();
        addFromArray(theSet, args);
        return theSet;
    }

    public static function newSortedSet(comparator : IComparator, args : Array<Dynamic> = null) : SortedSet {
        var theSet : SortedSet = new SortedSet(comparator);
        addFromArray(theSet, args);
        return theSet;
    }

    public static function addFromArray(theSet : ISet, source : Array<Dynamic>) : Int {
        if (source == null) {
            return 0;
        }
        
        var numAdded : Int;
        var wrapper : Args;
        var i : Int;
        while (i < source.length) {
            if (Std.is(source[i], Args)) {
                wrapper = source[i];
                if (Std.is(wrapper.source, Array)) {
                    numAdded += addFromArray(theSet, cast wrapper.source);
                }
                else if (Std.is(wrapper.source, ICollection)) {
                    numAdded += addFromCollection(theSet, try cast(wrapper.source, ICollection) catch(e:Dynamic) null);
                }
                else if (theSet.add(wrapper.source)) {
                    numAdded++;
                }
            }
            else if (theSet.add(source[i])) {
                numAdded++;
            }
            i++;
        }
        return numAdded;
    }

    public static function addFromCollection(theSet : ISet, source : ICollection) : Int {
        if (source == null) {
            return 0;
        }
        
        var added : Int;
        var iterator : IIterator = source.iterator();
        while (iterator.hasNext()) {
            theSet.add(iterator.next());
            added++;
        }
        return added;
    }

    public static function addFromArgs(theSet : ISet, args : Array<Dynamic> = null) : Int {
        return addFromArray(theSet, args);
    }

    public static function clone(theSet : ISet, filter : Function = null) : ISet {
        var clone : ISet = Type.getClass(theSet);
        if (Std.is(theSet, ISortOrder)){
            ISortOrder(clone).comparator = ISortOrder(theSet).comparator;
        }

        var iterator : IIterator = new FilterIterator(theSet, filter);
        while (iterator.hasNext()) {
            clone.add(iterator.next());
        }
        return clone;
    }

    public static function copy(source : ISet, destination : ISet, filter : Function = null) : Int {
        var iterator : IIterator = new FilterIterator(source, filter);
        var numAdded : Int;
        while (iterator.hasNext()) {
            if (destination.add(iterator.next())) {
                numAdded++;
            }
        }
        return numAdded;
    }

    public function new() {}
}