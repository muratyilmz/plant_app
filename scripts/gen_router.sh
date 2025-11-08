#!/bin/bash
set -e

cd ..

flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs --build-filter=lib/app/router/router.gr.dart