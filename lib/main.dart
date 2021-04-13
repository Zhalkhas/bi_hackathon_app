import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_bi_musorapp/consts.dart';
import 'package:hackathon_bi_musorapp/intro.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // http.post("$baseURL/bihack/rest/users/new/", body: jsonEncode({"name":}));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.green,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? AppIntroSlider()
          : AppHome(),
    );
  }
}
