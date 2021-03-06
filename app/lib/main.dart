import 'package:app/app.dart';
import 'package:app/initapp.dart';
import 'package:app/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/blocs/application_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context) => ApplicationBloc(),
      // 최상단에 있는 것
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.white,
          // primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: initApp(),
      ),
    );
  }
}
