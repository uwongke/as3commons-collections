/**
 * Copyright 2010 The original author or authors.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.as3commons.collections.utils;

import flexunit.framework.TestCase;
import org.as3commons.collections.framework.IComparator;

/**
	 * @author Jens Struwe 13.03.2009
	 */
class StringComparatorTest extends TestCase
{
    
    
    public function test_ascendingCasesensitive() : Void
    {
        var comparator : IComparator = new StringComparator(StringComparator.ORDER_ASC, StringComparator.OPTION_CASESENSITIVE);
        
        // case
        
        assertEquals(
                -1, 
                comparator.compare("A", "a")
        );  // null
        
        assertEquals(
                1, 
                comparator.compare("a", "A")
        );  // null
        
        assertEquals(
                -1, 
                comparator.compare("namE", "name")
        );  // null
        
        assertEquals(
                1, 
                comparator.compare("name", "namE")
        );  // null
        
        // empty string
        
        assertEquals(
                -1, 
                comparator.compare("", "a")
        );  // null
        
        assertEquals(
                1, 
                comparator.compare("a", "")
        );  // null
        
        assertEquals(
                0, 
                comparator.compare("", "")
        );  // null
        
        // different length
        
        assertEquals(
                -1, 
                comparator.compare("name", "namee")
        );  // null
        
        assertEquals(
                1, 
                comparator.compare("namee", "name")
        );  // null
        
        // case and length
        
        assertEquals(
                1, 
                comparator.compare("name", "nAmee")
        );  // null
        
        assertEquals(
                -1, 
                comparator.compare("nAmee", "name")
        );  // null
        
        // numbers as strings
        
        assertEquals(
                -1, 
                comparator.compare("name1", "name2")
        );  // null
        
        assertEquals(
                1, 
                comparator.compare("name2", "name1")
        );  // null
        
        // numbers vs strings
        
        assertEquals(
                -1, 
                comparator.compare("1", "A")
        );  // null
        
        assertEquals(
                1, 
                comparator.compare("A", "1")
        );  // null
    }
    
    public function test_ascendingCaseinsensitive() : Void
    {
        var comparator : IComparator = new StringComparator(StringComparator.ORDER_ASC, StringComparator.OPTION_CASEINSENSITIVE);
        
        // case
        
        assertEquals(
                0, 
                comparator.compare("A", "a")
        );  // null
        
        assertEquals(
                0, 
                comparator.compare("a", "A")
        );  // null
        
        assertEquals(
                0, 
                comparator.compare("namE", "name")
        );  // null
        
        assertEquals(
                0, 
                comparator.compare("name", "namE")
        );  // null
        
        // empty string
        
        assertEquals(
                -1, 
                comparator.compare("", "a")
        );  // null
        
        assertEquals(
                1, 
                comparator.compare("a", "")
        );  // null
        
        assertEquals(
                0, 
                comparator.compare("", "")
        );  // null
        
        // different length
        
        assertEquals(
                -1, 
                comparator.compare("name", "namee")
        );  // null
        
        assertEquals(
                1, 
                comparator.compare("namee", "name")
        );  // null
        
        // case and length
        
        assertEquals(
                -1, 
                comparator.compare("name", "nAmee")
        );  // null
        
        assertEquals(
                1, 
                comparator.compare("nAmee", "name")
        );  // null
        
        // numbers as strings
        
        assertEquals(
                -1, 
                comparator.compare("name1", "name2")
        );  // null
        
        assertEquals(
                1, 
                comparator.compare("name2", "name1")
        );  // null
        
        // numbers vs strings
        
        assertEquals(
                -1, 
                comparator.compare("1", "A")
        );  // null
        
        assertEquals(
                1, 
                comparator.compare("A", "1")
        );  // null
    }
    
    public function test_descendingCasesensitive() : Void
    {
        var comparator : IComparator = new StringComparator(StringComparator.ORDER_DESC, StringComparator.OPTION_CASESENSITIVE);
        
        // case
        
        assertEquals(
                1, 
                comparator.compare("A", "a")
        );  // null
        
        assertEquals(
                -1, 
                comparator.compare("a", "A")
        );  // null
        
        assertEquals(
                1, 
                comparator.compare("namE", "name")
        );  // null
        
        assertEquals(
                -1, 
                comparator.compare("name", "namE")
        );  // null
        
        // empty string
        
        assertEquals(
                1, 
                comparator.compare("", "a")
        );  // null
        
        assertEquals(
                -1, 
                comparator.compare("a", "")
        );  // null
        
        assertEquals(
                0, 
                comparator.compare("", "")
        );  // null
        
        // different length
        
        assertEquals(
                1, 
                comparator.compare("name", "namee")
        );  // null
        
        assertEquals(
                -1, 
                comparator.compare("namee", "name")
        );  // null
        
        // case and length
        
        assertEquals(
                -1, 
                comparator.compare("name", "nAmee")
        );  // null
        
        assertEquals(
                1, 
                comparator.compare("nAmee", "name")
        );  // null
        
        // numbers as strings
        
        assertEquals(
                1, 
                comparator.compare("name1", "name2")
        );  // null
        
        assertEquals(
                -1, 
                comparator.compare("name2", "name1")
        );  // null
        
        // numbers vs strings
        
        assertEquals(
                1, 
                comparator.compare("1", "A")
        );  // null
        
        assertEquals(
                -1, 
                comparator.compare("A", "1")
        );  // null
    }
    
    public function test_descendingCaseinsensitive() : Void
    {
        var comparator : IComparator = new StringComparator(StringComparator.ORDER_DESC, StringComparator.OPTION_CASEINSENSITIVE);
        
        // case
        
        assertEquals(
                0, 
                comparator.compare("A", "a")
        );  // null
        
        assertEquals(
                0, 
                comparator.compare("a", "A")
        );  // null
        
        assertEquals(
                0, 
                comparator.compare("namE", "name")
        );  // null
        
        assertEquals(
                0, 
                comparator.compare("name", "namE")
        );  // null
        
        // empty string
        
        assertEquals(
                1, 
                comparator.compare("", "a")
        );  // null
        
        assertEquals(
                -1, 
                comparator.compare("a", "")
        );  // null
        
        assertEquals(
                0, 
                comparator.compare("", "")
        );  // null
        
        // different length
        
        assertEquals(
                1, 
                comparator.compare("name", "namee")
        );  // null
        
        assertEquals(
                -1, 
                comparator.compare("namee", "name")
        );  // null
        
        // case and length
        
        assertEquals(
                1, 
                comparator.compare("name", "nAmee")
        );  // null
        
        assertEquals(
                -1, 
                comparator.compare("nAmee", "name")
        );  // null
        
        // numbers as strings
        
        assertEquals(
                1, 
                comparator.compare("name1", "name2")
        );  // null
        
        assertEquals(
                -1, 
                comparator.compare("name2", "name1")
        );  // null
        
        // numbers vs strings
        
        assertEquals(
                1, 
                comparator.compare("1", "A")
        );  // null
        
        assertEquals(
                -1, 
                comparator.compare("A", "1")
        );  // null
    }

    public function new()
    {
        super();
    }
}

