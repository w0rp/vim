import std.algorithm;
import std.range;
import std.array;
import std.path : dirName, absolutePath, buildPath;
import std.file : readText, fileExists = exists, chdir;
import std.json;
import std.stdio;
import std.process;

/// A range with successively generates new values by applying a predicate
/// to the previous value, in order to generate the next.
struct GeneratorRange(alias pred, E) {
    enum empty = false;

    private E _value;

    @disable this();

    this(E value) {
        _value = value;
    }

    @property
    typeof(this) save() {
        return this;
    }

    @property
    ref inout(E) front() inout {
        return _value;
    }

    void popFront() {
        writeln(_value);

        _value = pred(_value);
    }
}

auto generate(alias fun, E)(E value) {
    return GeneratorRange!(fun, E)(value);
}

int main(string[] argv) {
    if (argv.length != 2) {
        stderr.writeln("A single D source filename should be supplied.");
        return 1;
    }

    // Find the first dub.json file while searching through parent directories.
    auto filenameRange =
    dirName(absolutePath(argv[1]))
    .generate!dirName
    .until!(path => path == "/")
    .map!(path => buildPath(path, "dub.json"))
    .find!fileExists;

    if (filenameRange.empty) {
        stderr.writeln("No dub.json file could be found.");
        return 1;
    }

    string dubFilename = filenameRange.front;

    // Switch to the directory with the dub describe file, to run it there.
    chdir(dirName(dubFilename));

    // Run dub to get the data.
    auto pipes = pipeProcess(["dub", "describe"], Redirect.stdout);

    if (wait(pipes.pid)) {
        stderr.writeln("'dub describe' failed.");
        return 1;
    }

    auto json = parseJSON(pipes.stdout.byChunk(4096).joiner());

    // Write all of the paths to stdout.
    json["packages"].array
    .map!(pack =>
        pack["importPaths"].array.map!(f => pack["path"].str ~ f.str)
    )
    .joiner
    .each!writeln;

    return 0;
}

