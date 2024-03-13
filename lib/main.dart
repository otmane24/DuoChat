import 'package:duochat/app/app.dart';
import 'package:duochat/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  // Ensure that widget binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the default options for the current platform
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run the app
  runApp(const MyApp());
}
