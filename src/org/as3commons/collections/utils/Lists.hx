package org.as3commons.collections.utils;

import org.as3commons.collections.framework.ISortOrder;
import openfl.utils.Object;
import haxe.Constraints.Function;
import org.as3commons.collections.framework.ICollection;
import org.as3commons.collections.framework.IComparator;
import org.as3commons.collections.framework.IIterator;
import org.as3commons.collections.framework.IList;
import org.as3commons.collections.iterators.FilterIterator;

class Lists {
    public static function newArrayList(args : Array<Dynamic> = null) : ArrayList {
        var list : ArrayList = new ArrayList();
        addFromArray(list, args);
        return list;
    }

    public static function newSortedList(comparator : IComparator, args : Array<Dynamic> = null) : SortedList {
        var list : SortedList = new SortedList(comparator);
        addFromArray(list, args);
        return list;
    }

    public static function addFromArray(list : IList, source : Array<Dynamic>) : Int {
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
                    numAdded += addFromArray(list, try cast(wrapper.source, Array<Dynamic>) catch(e:Dynamic) null);
                }
                else if (Std.is(wrapper.source, ICollection)) {
                    numAdded += addFromCollection(list, try cast(wrapper.source, ICollection) catch(e:Dynamic) null);
                }
                else {
                    list.add(wrapper.source);
                    numAdded++;
                }
            }
            else {
                list.add(source[i]);
                numAdded++;
            }
            i++;
        }
        return numAdded;
    }

    public static function addFromCollection(list : IList, source : ICollection) : Int {
        if (source == null) {
            return 0;
        }
        
        var added : Int;
        var iterator : IIterator = source.iterator();
        while (iterator.hasNext()) {
            list.add(iterator.next());
            added++;
        }
        return added;
    }

    public static function addFromArgs(list : IList, args : Array<Dynamic> = null) : Int {
        return addFromArray(list, args);
    }

    /** TODO@Wolfie -> Test this... */
    public static function clone(list : IList, filter : Function = null) : IList {
        var clone : IList = Type.getClass(list);

        if (Std.is(list, ISortOrder)){
            ISortOrder(clone).comparator = ISortOrder(list).comparator;
        }

        var iterator : IIterator = new FilterIterator(list, filter);
        while (iterator.hasNext()) {
        clone.add(iterator.next());
        }
        return clone;
    }

    public static function copy(source : IList, destination : IList, filter : Function = null) : Int {
        var iterator : IIterator = new FilterIterator(source, filter);
        var numAdded : Int;
        while (iterator.hasNext()) {
            destination.add(iterator.next());
            numAdded++;
        }
        return numAdded;
    }

    public function new() {}
}

