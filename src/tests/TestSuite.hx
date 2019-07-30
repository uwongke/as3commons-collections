package
import massive.munit.TestSuite;



/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */
class TestSuite extends massive.munit.TestSuite
{
	public function new()
	{
		super();

		add(ExampleTest);
		add(as3hx.TokenizerTest);
		add(as3hx.parsers.ImportParserTest);
		add(as3hx.parsers.ExprParserTest);
		add(as3hx.parsers.UseParserTest);
		add(as3hx.AS3HXTest);
		add(as3hx.ParserUtilsTest);
		add(as3hx.CompatTest);
	}
}
