import org.as3commons.collections.ArrayUtilsTest;
import org.as3commons.collections.units.IInsertionOrderDuplicatesTests;
import org.as3commons.collections.units.IDuplicatesTests;
import org.as3commons.collections.units.ICollectionTests;
import org.as3commons.collections.LinkedList;
import org.as3commons.collections.LinkedListTest;
import haxe.unit.TestRunner;


/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */
class TestSuite {
    private static var r:TestRunner;
    private static var oldPrint:Dynamic;

    public function new() {


    }

    //TODO:: finish tests for all classes
    //Actally LinkedList and Arrayutils
    public static function main():Void {
        r = new TestRunner();
        oldPrint = haxe.Log.trace;
        TestRunner.print = deafprint;
        r.add(new ICollectionTests(new LinkedListTest()));
        r.add(new IDuplicatesTests(new LinkedListTest()));
        r.add(new IInsertionOrderDuplicatesTests(new LinkedListTest()));
        //add ArrayUtilsTests
        r.add(new ArrayUtilsTest());
        r.run();
    }

    static function deafprint(v:Dynamic):Void {
        haxe.Log.trace = oldPrint;
        trace(v);
    }
}
