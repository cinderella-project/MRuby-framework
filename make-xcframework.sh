#!/bin/sh
set -xe

rm -rf ./CMRuby.xcframework
xcodebuild -create-xcframework \
    -library submodules/mruby/build/host/lib/libmruby.a -headers submodules/mruby/include \
    -library submodules/mruby/build/ios/lib/libmruby.a -headers submodules/mruby/include \
    -library submodules/mruby/build/ios_sim/lib/libmruby.a -headers submodules/mruby/include \
    -output ./CMRuby.xcframework