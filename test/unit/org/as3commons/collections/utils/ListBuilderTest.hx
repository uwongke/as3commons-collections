package org.as3commons.collections.utils;

import flexunit.framework.TestCase;
import org.as3commons.collections.ArrayList;
import org.as3commons.collections.SortedList;
import org.as3commons.collections.framework.IList;

/**
	 * @author John Reeves.
	 */
class ListBuilderTest extends TestCase
{
    
    public function test_buildArrayList() : Void
    {
        var result : IList = ListBuilder.newArrayList().add("item1").build();
        
        assertEquals(Type.getClassName(ArrayList), Type.getClassName(result));  // Resulting IList is an instance of ArrayList
    }
    
    public function test_buildSortedList() : Void
    {
        var result : IList = ListBuilder.newSortedList(new NumericComparator()).add(22).add(11).build();
        
        assertEquals(Type.getClassName(SortedList), Type.getClassName(result));  // Resulting IList is an instance of SortedList
    }

    public function new()
    {
        super();
    }
}



