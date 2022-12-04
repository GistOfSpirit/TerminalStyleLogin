#!/bin/bash

SCRIPT_LOC=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_LOC")

rm -Rf "$SCRIPT_DIR"/../build
mkdir -p "$SCRIPT_DIR"/../build
cp "$SCRIPT_DIR"/../*.qml "$SCRIPT_DIR"/../build/
cp -r "$SCRIPT_DIR"/../components "$SCRIPT_DIR"/../build/
cp "$SCRIPT_DIR"/../metadata.desktop "$SCRIPT_DIR"/../build/
cp "$SCRIPT_DIR"/../preview.png "$SCRIPT_DIR"/../build/
cp "$SCRIPT_DIR"/../LICENSE "$SCRIPT_DIR"/../build/
cp "$SCRIPT_DIR"/../theme.conf "$SCRIPT_DIR"/../build/
mv "$SCRIPT_DIR"/../build/RealProxy.qml "$SCRIPT_DIR"/../build/Proxy.qml
