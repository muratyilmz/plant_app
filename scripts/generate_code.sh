#!/bin/bash
set -e

cd ..
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
