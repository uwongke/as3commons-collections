package org.as3commons.collections.utils;

import flexunit.framework.TestCase;
import org.as3commons.collections.LinkedList;
import org.as3commons.collections.framework.ILinkedList;

/**
	 * @author John Reeves.
	 */
class LinkedListBuilderTest extends TestCase
{
    
    public function test_buildLinkedList() : Void
    {
        var result : ILinkedList = LinkedListBuilder.newLinkedList().add("item1").build();
        
        assertEquals(Type.getClassName(LinkedList), Type.getClassName(result));  // Resulting IList is an instance of LinkedList
    }

    public function new()
    {
        super();
    }
}



