import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/RouterGenerator.dart';
import 'package:whatsapp/interface/home.dart';
import 'package:whatsapp/interface/login.dart';

import 'package:whatsapp/interface/register.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "MyApp",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      onGenerateRoute: RouterGererator.genareteRoute,
      // home: Login(),
    ),
  );
}
