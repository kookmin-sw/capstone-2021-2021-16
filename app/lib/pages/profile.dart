import 'dart:io';

import 'package:app/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'message.dart';
import 'notification.dart';

GoogleSignIn _googleSignIn = GoogleSignIn();
GoogleSignInAccount _currentUser;

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<void> _handleSignOut() async {
    // await _googleSignIn.disconnect();

    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    setState(() {
      _currentUser = null;
    });
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()),
            (Route<dynamic> route) => false);
  }

  @override
  Widget _appbarWidget() {
    return AppBar(
      // AppBar
      elevation: 0,
      title: GestureDetector(
        onTap: () {
          // 클릭했을 때 Callback이 이 쪽으로 옴
          print("click");
        },
        child: Row(
          children: [
            SizedBox(width: 5), //Padding이랑 같은 효과
            Text("프로필"),
          ],
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MessagesList()), // Move to Message
              );
            },
            icon: Image.asset('assets/images/message.png')),
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotesList()), // Move to Notice
              );
            },
            icon: Image.asset('assets/images/bell.png'))
      ], // 가운데 이름
    );
  }

  Widget _buildCard(BuildContext context) {
    return Card(
          child: ListTile(
        //leading: Image.network('https://d1nhio0ox7pgb.cloudfront.net/_img/o_collection_png/green_dark_grey/512x512/plain/user.png'),
          leading: Image.asset("assets/images/user.png"),
            title: Text('함석민'),
           subtitle: Text('hahmsm@kookmin.ac.kr'),

        trailing: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            // Navigator.pushNamed(context, '/profile-edit', arguments: user);
          },
        ),
      ),

    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildCard(context),
            //_buildSignOut(context),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbarWidget(),
        body: Container(
            child: Center(
              child: Column(
                children: [
                  _buildBody(context),
                  RaisedButton(
                    onPressed: () {
                      print('로그아웃');
                      _handleSignOut();
                    },
                    child: Text('로그아웃'),
                  ),
                ],
              ),
            )
        ));
  }
}


