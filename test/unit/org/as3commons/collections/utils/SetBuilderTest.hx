package org.as3commons.collections.utils;

import flexunit.framework.TestCase;
import org.as3commons.collections.LinkedSet;
import org.as3commons.collections.Set;
import org.as3commons.collections.SortedSet;
import org.as3commons.collections.framework.ISet;

/**
	 * @author John Reeves.
	 */
class SetBuilderTest extends TestCase
{
    
    public function test_buildSet() : Void
    {
        var result : ISet = SetBuilder.newSet().add("item1").add("item2").build();
        
        assertEquals(2, result.size);  // Resulting ISet has 2 entries
        assertTrue(result.has("item1"));  // Resulting ISet has the supplied entry
        assertTrue(result.has("item2"));  // Resulting ISet has the supplied entry
        assertEquals(Type.getClassName(Set), Type.getClassName(result));  // Resulting ISet is an instance of Set
    }
    
    public function test_buildLinkedSet() : Void
    {
        var result : ISet = SetBuilder.newLinkedSet().add("item1").build();
        
        assertEquals(Type.getClassName(LinkedSet), Type.getClassName(result));  // Resulting ISet is an instance of LinkedSet
    }
    
    public function test_buildSortedSet() : Void
    {
        var result : ISet = SetBuilder.newSortedSet(new NumericComparator()).add(22).add(11).build();
        
        assertEquals(Type.getClassName(SortedSet), Type.getClassName(result));  // Resulting ISet is an instance of SortedSet
    }

    public function new()
    {
        super();
    }
}



