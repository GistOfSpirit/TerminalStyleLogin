#!/bin/bash

mkdir -p build
rm -R build/*
cp ./*.qml build/
cp -r components build/
cp metadata.desktop build/
cp preview.png build/
cp LICENSE build/
cp theme.conf build/
mv build/RealProxy.qml build/Proxy.qml
