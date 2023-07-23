import 'dart:async';

import 'package:adviseme/screen/profile.dart';
import 'package:adviseme/screen/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );

  // var user;

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    // home: SignUp(),ConversationChat

    home: Splash_Screen(),
  ));
}

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  late final StreamSubscription _subscription;
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10), () {
      _subscription = FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user != null) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Stud_Profile(
                    user: user,
                  )));
          // } else if (user != null) {
          //   Navigator.of(context).pushReplacement(
          //
          //       MaterialPageRoute(builder: (context) => Dashboard(user: user)));
          return;
        } else {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SignIn()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(),
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error?.toString() ?? ''),
                );
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Estate Management System',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Image.asset(
                      'assets/buy.jpg',
                      width: 250.0,
                      height: 250.0,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   //mainAxisSize: MainAxisSize.min,
                    //   children: <Widget>[
                    //     // CircleAvatar(
                    //     //   backgroundImage: AssetImage('assets/buy.jpg'),
                    //     //   radius: 60.0,
                    //     // ),
                    //
                    //     // SizedBox(
                    //     //   width: 10.0,
                    //     // ),
                    //
                    //   ],
                    // ),
                    SizedBox(
                      height: 20.0,
                    ),
                    IconButton(
                      onPressed: () {
                        CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.0,
                        );
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
                      },
                      color: Colors.blueAccent,
                      icon: (Icon(Icons.arrow_forward)),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Supervised by:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.blueAccent),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Allahji. Kawonise',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.blueAccent),
                    ),
                  ],
                ),
              );
            }));
  }
}
