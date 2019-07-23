package org.as3commons.collections.utils;

class Args {
    public var source : Dynamic;

    public static function from(source : Dynamic) : Args {
        var args : Args = new Args();
        args.source = source;
        return args;
    }

    public function new() {
    }
}