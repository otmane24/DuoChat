# App Name
 Duo Chat

## Prerequisites

- Flutter SDK ("Using Flutter version 3.19.3")
- Dart SDK ("Dart version 3.3.1")
- Android Studio or VS Code with Flutter plugin
- Firebase account

## Installation

1. Clone the repository:

    git clone https://github.com/otmane24/DuoChat.git
  
2. Navigate to the project directory:
 
    cd repository
 
3. Get the dependencies:

    flutter pub get


## Firebase Setup

1. Go to the [Firebase console](https://console.firebase.google.com/).
2. Click on "Add project" and follow the instructions to create a new Firebase project.
3. Once the project is created, click on "Add Firebase to your Android app" and follow the instructions to register your app.
4. Download the `google-services.json` file and place it in the `android/app` directory of your Flutter project.
5. Click on "Add Firebase to your iOS app" in the Firebase console and follow the instructions to register your app.
6. Download the `GoogleService-Info.plist` file.
7. Open your iOS project in Xcode (located in `ios/Runner.xcworkspace` in your Flutter project).
8. Right-click on the Runner directory in Xcode and select "Add Files to Runner".
9. Select the `GoogleService-Info.plist` file that you downloaded and make sure the "Copy items if needed" checkbox is checked.

## Getting SHA-1 Fingerprint

Firebase uses the SHA-1 fingerprint to authenticate requests from your Android application. Here's how you can get it:

1. Open Terminal in Android Studio (View -> Tool Windows -> Terminal).
2. Navigate to the `android` directory in your project:
 
    cd android

3. Run the following command:

    ./gradlew signingReport

4. Copy the SHA-1 fingerprint and paste it in the Firebase console where required.

## Running the App

1. Start an Android emulator or connect a physical Android device to your computer.
2. Run the app:
 
    flutter run

## Important

For the purpose of testing, I have left my Firebase configuration in this repository. Please do not use it for any other purposes. In a real-world scenario, these sensitive details should be kept private and not be committed to the repository.

## Note

Please be aware that this repository is currently public only for the purpose of testing. It may become private in the future.

## Firebase Architecture

In this project, Firebase is used as the database. It has the following collections:

1. `users`: This collection contains the user IDs.
2. `discussion`: This collection contains discussions. Each discussion has the following fields:
     - `message`: An object that contains the message details. It has the following fields:
         - `message`: The text of the message.
         - `isSeen`: A boolean indicating whether the message has been seen.
         - `ownerId`: The ID of the user who sent the message.
         - `createdAt`: The timestamp when the message was created.
     - `createdAt`: The timestamp when the discussion was created.
     - `createdBy`: The ID of the user who created the discussion.
     - `name`: The name of the discussion.

Here is the structure of the Firebase database:

```json
{
    "users": ["userId", "userID"],
    "discussion": {
        "message": {
            "message": "",
            "isSeen": false,
            "ownerId": "",
            "createdAt": ""
        },
        "createdAt": "",
        "createdBy": "userId",
        "name": ""
    }
}



