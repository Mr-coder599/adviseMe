import 'package:adviseme/Adviser_Screen/Dashboard.dart';
import 'package:adviseme/Adviser_Screen/S_SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screen/signIn.dart';

class Staff_Login extends StatefulWidget {
  const Staff_Login({Key? key}) : super(key: key);

  @override
  State<Staff_Login> createState() => _Staff_LoginState();
}

class _Staff_LoginState extends State<Staff_Login> {
  // begining of the AuthService
  void checkSignedIn() async {}
  //end of the firebase Auth function
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  late final User user;
  late bool isPasswordTextField = true;
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Agent Login',
      //     style: TextStyle(fontSize: 15.0),
      //   ),
      //   elevation: 0,
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 70.0),
          child: Column(
            children: <Widget>[
              // SizedBox(
              //   height: 20,
              // ),
              // Text(
              //   'Supply Your Login Credentials',
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.blue,
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              Image.asset("assets/estateone.webp"),
              SizedBox(
                height: 5.0,
              ),
              TextField(
                controller: _emailcontroller,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email',
                  hoverColor: Colors.blue,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _passwordcontroller,
                obscureText: isPasswordTextField ? showPassword : true,
                maxLength: 12,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(Icons.remove_red_eye),
                  ),
                  hintText: 'Password should not greather than 12 characher',
                  hoverColor: Colors.blue,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              forgotpassword(context),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final credential = await _auth.signInWithEmailAndPassword(
                      email: _emailcontroller.text,
                      password: _passwordcontroller.text,
                    );
                    CircularProgressIndicator();
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Login Successfully')));
                    final user = credential.user;
                    if (user != null) {
                      // Navigator.of(context)
                      //     .push(MaterialPageRoute(
                      //     builder: (context) =>
                      //     )));
                      //    CircularProgressIndicator();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Dashboard(
                                user: user,
                                //  user: user,
                              )));
                    }
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.message ?? '')));
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  textStyle:
                      MaterialStateProperty.all(TextStyle(fontSize: 20.0)),
                  elevation: MaterialStateProperty.all<double>(0.0),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueAccent),
                  //   shadowColor: MaterialStateProperty.all<Color>(Colors.amberAccent),
                  minimumSize: MaterialStateProperty.all(Size(50, 50)),
                  fixedSize: MaterialStateProperty.all(Size(320, 50)),
                  side: MaterialStateProperty.all(
                      BorderSide(color: Colors.white)),
                ),
              ),

              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SSignUP()));
                      });
                    },
                    child: Text('Dont have an account..? click here'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
                      });
                    },
                    child: Text('Client login?'),
                  ),
                ],
              ),
              //end of previous
            ],
          ),
        ),
      ),
    );
  }

  Widget forgotpassword(BuildContext context) {
    final resetpasswordcontroller = TextEditingController();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: Text(
          'forgot Password',
          style: TextStyle(
            color: Colors.blueAccent,
          ),
          textAlign: TextAlign.right,
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Forgotten Password'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 15.0,
                      ),
                      TextField(
                        controller: resetpasswordcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'enter your emailaddress',
                          hoverColor: Colors.green,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _auth
                              .sendPasswordResetEmail(
                                  email: resetpasswordcontroller.text)
                              .then((value) => Navigator.of(context).pop());
                        },
                        child: Text('Reset Password'),
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 20.0)),
                          elevation: MaterialStateProperty.all<double>(0.0),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blueAccent),
                          //   shadowColor: MaterialStateProperty.all<Color>(Colors.amberAccent),
                          minimumSize: MaterialStateProperty.all(Size(50, 50)),
                          fixedSize: MaterialStateProperty.all(Size(320, 50)),
                          side: MaterialStateProperty.all(
                              BorderSide(color: Colors.blueAccent)),
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
