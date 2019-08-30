package ;
import haxe.PosInfos;
import haxe.unit.TestCase;
class TestCaseBase extends TestCase {
    public function new() {

        super();
    }
    function assertStrictlyEquals<T>( expected: T , actual: T,  ?c : PosInfos ) : Void {
        assertEquals(expected, actual, c);
    }
}
