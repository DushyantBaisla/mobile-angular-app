#!/bin/bash

#Define the Android project path and destination folder
PROJECT_PATH="$HOME/projects"
ANDROID_PROJECT_PATH="$PROJECT_PATH/mobile-angular-app/android"
HOME_DIR="$PROJECT_PATH/mobile-angular-app"


# Ensure the script stops on any error
set -e

echo "===================================="
echo "Starting the build process..."
echo "===================================="

echo "Removing the Android platform folder..."
rm -rf "$ANDROID_PROJECT_PATH"

# Delete the `dist` folder (Angular's build output)
echo "Removing the dist folder..."
rm -rf "$PROJECT_PATH/mobile-angular-app/dist"  # Adjust if necessary to your build output directory
rm -f "$HOME_DIR/*.apk"

# Step 1: Build the Angular project (dist folder)
echo "Building Angular dist folder..."
$HOME_DIR/node_modules/.bin/ng build
echo "Angular dist folder build completed."

echo "===================================="
echo "Starting APK build process..."
echo "===================================="

# Step 2: Add Android platform using Capacitor
echo "Adding Android platform using Capacitor..."
npx cap add android
echo "Android platform added."

# Step 3: Synchronize the Capacitor project with native Android
echo "Synchronizing Capacitor with native Android..."
npx cap sync
echo "Capacitor synchronization completed."

# Step 5: Navigate to the Android project directory
echo "Navigating to Android project directory: $ANDROID_PROJECT_PATH"
cd "$ANDROID_PROJECT_PATH" || { echo "Error: Android project directory not found at $ANDROID_PROJECT_PATH."; exit 1; }

# Step 7: Build the APK (debug version)
echo "Building the APK (debug version)..."
$ANDROID_PROJECT_PATH/gradlew assembleDebug
  echo "APK build completed."

# Step 8: Verify if the APK was generated
APK_PATH="$ANDROID_PROJECT_PATH/app/build/outputs/apk/debug/app-debug.apk"
if [ ! -f "$APK_PATH" ]; then
  echo "Error: APK not found. Build failed."
  exit 1
fi
echo "APK found at: $APK_PATH"

# Step 9: Copy the APK to the home directory
random_name=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16)
echo "Copying the APK to the home directory ($HOME_DIR)..."
cp "$APK_PATH" "$HOME_DIR/$random_name.apk"
echo "APK successfully copied to $HOME_DIR."

# Step 10: Confirm the APK has been copied
if [ -f "$HOME_DIR/$random_name.apk" ]; then
  echo "APK successfully copied to $HOME_DIR"
else
  echo "Error: Failed to copy the APK."
  exit 1
fi

echo "===================================="
echo "Build process completed successfully!"
echo "APK available at: $HOME_DIR/app-debug.apk"
echo "===================================="

# Step 11: Cleanup - Delete the Android and dist folders
echo "===================================="
echo "Cleaning up the project..."

# Delete the `android` folder (or just the Android-specific build files)
echo "Removing the Android platform folder..."
rm -rf "$ANDROID_PROJECT_PATH"

# Delete the `dist` folder (Angular's build output)
echo "Removing the dist folder..."
rm -rf "$PROJECT_PATH/mobile-angular-app/dist"  # Adjust if necessary to your build output directory

echo "Cleanup completed."
echo "===================================="
