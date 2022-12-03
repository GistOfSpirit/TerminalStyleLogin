#!/bin/bash

mkdir -p build
rm build/*
cp ./*.qml build/
cp metadata.desktop build/
cp preview.png build/
mv build/RealProxy.qml build/Proxy.qml
