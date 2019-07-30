package org.as3commons.collections;
import org.as3commons.collections.utils.NumericComparator;
import org.as3commons.collections.utils.ArrayUtils;
import haxe.unit.TestCase;
class ArrayUtilsTest extends TestCase {
    public function new() {
        super();
    }

    public function test_ArraysEqual() : Void
    {
        assertTrue(ArrayUtils.arraysEqual([1, 2, 3], [1, 2, 3]));
        assertFalse(ArrayUtils.arraysEqual([1, 2, 3], [2, 2, 3]));
        assertTrue(ArrayUtils.arraysEqual(["1", "2", "3"], ["1", "2", "3"]));


    }

    public function test_arraysMatch() : Void
    {
        assertTrue(ArrayUtils.arraysMatch([1, 3, 2], [1, 2, 3]));
        assertFalse(ArrayUtils.arraysMatch([1, 2, 3, 4], [2, 2, 3]));
        assertTrue(ArrayUtils.arraysMatch(["1", "2", "3"], ["1", "2", "3"]));


    }

    public function test_insertionSort() : Void
    {
        var arr:Array<Int> = [1, 4, 2, 4, 3];
        var arr2:Array<Int> = [1, 2, 3, 4, 4];
        assertTrue(ArrayUtils.insertionSort(arr, new NumericComparator()));
        assertTrue(ArrayUtils.arraysEqual(arr2, arr));

    }

    public function test_mergeSort() : Void
    {
        var arr:Array<Int> = [1, 4, 2, 4, 3];
        var arr2:Array<Int> = [1, 2, 3, 4, 4];
        assertTrue(ArrayUtils.mergeSort(arr, new NumericComparator()));
        assertTrue(ArrayUtils.arraysEqual(arr2, arr));
        assertTrue(ArrayUtils.mergeSort(arr, new NumericComparator()));
        assertTrue(ArrayUtils.arraysEqual(arr2, arr));

    }
}
