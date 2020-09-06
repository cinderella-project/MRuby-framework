#!/bin/sh
set -xe

rm -rf frameworks
for target in host iphoneos iphonesimulator
do
    mkdir -p frameworks/$target/libmruby.framework/{Headers,Modules}
    cp -r submodules/mruby/include/ frameworks/$target/libmruby.framework/Headers
    cp module.modulemap frameworks/$target/libmruby.framework/Modules
    cp submodules/mruby/build/$target/lib/libmruby.a frameworks/$target/libmruby.framework/libmruby
    pushd frameworks/$target/libmruby.framework/Headers
    find ./mruby -type f | xargs sed -Ei '' 's/# *include [<"]mruby\/(.+)[">]/#include "\1"/g'
    find ./mruby -type f | xargs sed -Ei '' 's/# *include <(mruby\.h)>/#include "..\/\1"/g'
    find . -type f | xargs sed -Ei '' 's/# *include <(mruby.+)>/#include "\1"/g' 
    find . -type f | xargs sed -Ei '' 's/# *include/#include/g' 
    echo '#include "mruby.h"' > mruby-all.h
    find ./mruby -type f | sed 's/\.\//#include "/g' | sed 's/$/"/g' | grep -v boxing_nan | grep -v boxing_word | grep -v ops | grep -v opcode >> mruby-all.h
    popd
done

rm -rf ./libmruby.xcframework
xcodebuild -create-xcframework \
    -framework frameworks/host/libmruby.framework \
    -framework frameworks/iphoneos/libmruby.framework \
    -framework frameworks/iphonesimulator/libmruby.framework \
    -output ./libmruby.xcframework
cp submodules/mruby/build/host/LEGAL ./libmruby.xcframework/