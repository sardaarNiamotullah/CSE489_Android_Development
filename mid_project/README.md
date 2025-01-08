# mid_project_19301151

A Flutter project for Mid, 19301151

# Flutter App with API Integration

## Overview
This project is a Flutter application that integrates with a RESTful API to perform CRUD operations. The app provides three main functionalities:

1. **Map Screen**: Displays a map interface.
2. **Form Screen**: Allows users to add a new entity by providing a title, latitude, longitude, and optional image.
3. **List Screen**: Fetches and displays a list of entities from the API and provides an option to edit them.

The app has been tested and verified on **iPhone 16** in simulation mode only.

---

## Features

- **Interactive Drawer**: Navigate between the Map, Form, and List screens using the app drawer.
- **API Integration**: Fetch, create, and update entities through API endpoints.
- **Form Validation**: Ensures that the data entered by the user is valid before submitting.
- **Responsive UI**: Designed for seamless interaction and navigation.

---

## Prerequisites

Before building and running the application, ensure the following:

1. **Flutter SDK**: Install the Flutter SDK. You can download it from [Flutter's official website](https://flutter.dev/docs/get-started/install).
2. **iOS Development Setup**: Set up your system for iOS development by following [Flutter's guide for iOS](https://flutter.dev/docs/get-started/install/macos).
3. **Xcode**: Install Xcode from the Mac App Store.
4. **API Configuration**: Ensure the API endpoints (`https://labs.anontech.info/cse489/t3/api.php`) are reachable.

---

## Installation Instructions

### Step 1: Clone the Repository
Clone the project repository to your local machine:
```bash
git clone <repository-url>
cd <repository-folder>
```

### Step 2: Install Dependencies
Run the following command to install the necessary dependencies:
```bash
flutter pub get
```

### Step 3: Launch the iOS Simulator
1. Open Xcode and ensure you have the iPhone 16 simulator installed.
2. Run the simulator.

Alternatively, you can launch the simulator from the terminal:
```bash
open -a Simulator
```

### Step 4: Run the Application
Run the app using the Flutter CLI:
```bash
flutter run
```
Ensure the simulator is running before executing this command.

---

## API Details
The app interacts with the following API endpoints:

1. **Fetch Entities**
    - **Method**: `GET`
    - **Endpoint**: `https://labs.anontech.info/cse489/t3/api.php`

2. **Create Entity**
    - **Method**: `POST`
    - **Endpoint**: `https://labs.anontech.info/cse489/t3/api.php`
    - **Parameters**:
        - `title` (string)
        - `lat` (double)
        - `lon` (double)
        - `image` (file)

3. **Update Entity**
    - **Method**: `PUT`
    - **Endpoint**: `https://labs.anontech.info/cse489/t3/api.php`
    - **Parameters**:
        - `id` (integer)
        - `title` (string)
        - `lat` (double)
        - `lon` (double)

---

## Notes
- The app has only been tested on **iPhone 16 in simulation mode**. For optimal performance, run it in this environment.
- Ensure stable network connectivity to interact with the API.
- If you encounter issues with API responses, verify the server status or endpoint configuration.

---

## Troubleshooting

### Common Issues

1. **Dependencies Not Found**
    - Run `flutter pub get` to fetch missing packages.

2. **App Fails to Launch**
    - Verify that the iOS simulator is running.
    - Ensure your Flutter environment is correctly set up.

3. **API Errors**
    - Verify that the API server is up and the endpoints are accessible.

---

## License
This project is licensed under the MIT License. See the LICENSE file for more details.

---

## Screenshots
Feel free to add screenshots after every major step in the documentation to visually demonstrate the app's functionality.
