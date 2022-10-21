#!/bin/env sh
set -ex
trap "rm -rf tmp" ERR

git clone https://github.com/michal-z/zig-gamedev --depth 1 tmp

cp -r tmp/libs/zmath/src/* src/
cp -r tmp/libs/zmath/build.zig build.zig

echo -e "## NOTE\n
this is just a 1:1 copy of the [zmath](https://github.com/michal-z/zig-gamedev/blob/main/libs/zmath) library used for [mach-examples](https://github.com/hexops/mach-examples)
please don't create PRs for this repository\n" > README.md
cat tmp/libs/zmath/README.md >> README.md

rm -rf tmp