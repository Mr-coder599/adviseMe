import 'package:adviseme/Adviser_Screen/S_Login.dart';
import 'package:adviseme/screen/profile.dart';
import 'package:adviseme/screen/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  //const SignIn({Key? key, required User user}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  late final User user;
  String email = '';
  String password = '';
  late bool isPasswordTextField = true;
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   //   title: Text('CLIENT LOGIN'),
      //   elevation: 0.0,
      //   centerTitle: true,
      //   backgroundColor: Colors.blue,
      // ),
      body: //FutureBuilder(
          //future: _initializeFirebase(),
          //builder: (context, snapshot){
          // if (snapshot.connectionState == ConnectionState.done) {
          SingleChildScrollView(
        child: Center(
          child: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 26.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Supply Your Login Credentials',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset("assets/HL_M65_01.jpg"),
                  //   Image.asset("assets/studentbook.png"),
                  SizedBox(height: 30.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      child: Column(
                        children: [
                          Form(
                            key: _formkey,
                            child: Column(children: [
                              TextFormField(
                                  controller: _emailcontroller,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                    labelText: 'emailAddress',
                                  ),
                                  validator: (val) => val!.isEmpty
                                      ? 'Required email Address'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  }),
                              SizedBox(height: 20.0),
                              TextFormField(
                                  controller: passwordcontroller,
                                  obscureText:
                                      isPasswordTextField ? showPassword : true,
                                  validator: (val) =>
                                      val!.isEmpty ? "Required password" : null,
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
                                    border: OutlineInputBorder(),
                                    labelText: 'Password',
                                  ),
                                  onChanged: (val) {
                                    setState(() => password = val);
                                  }),
                              SizedBox(height: 10.0),
                              forgotpassword(context),
                              SizedBox(height: 20.0),
                              ElevatedButton(
                                onPressed: () async {
                                  try {
                                    final credential =
                                        await _auth.signInWithEmailAndPassword(
                                      email: _emailcontroller.text,
                                      password: passwordcontroller.text,
                                    );
                                    CircularProgressIndicator();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('Login Successfully')));
                                    final user = credential.user;
                                    if (user != null) {
                                      // Navigator.of(context)
                                      //     .push(MaterialPageRoute(
                                      //     builder: (context) =>
                                      //     )));
                                      CircularProgressIndicator();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Stud_Profile(
                                                    user: user,
                                                  )));
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(e.message ?? '')));
                                  }
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                                style: ButtonStyle(
                                  textStyle: MaterialStateProperty.all(
                                      TextStyle(fontSize: 20.0)),
                                  elevation:
                                      MaterialStateProperty.all<double>(10.0),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                  //   shadowColor: MaterialStateProperty.all<Color>(Colors.amberAccent),
                                  minimumSize:
                                      MaterialStateProperty.all(Size(30, 30)),
                                  fixedSize:
                                      MaterialStateProperty.all(Size(350, 50)),
                                  side: MaterialStateProperty.all(
                                      BorderSide(color: Colors.white)),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    S_SignUp()));
                                      });
                                    },
                                    child: Text(
                                      'Dont have an account..? click here',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: 0,
                                  // ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Staff_Login()));
                                      });
                                    },
                                    child: Text(
                                      'Agent Login?',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // };
      //return build(context);
      //},
      //),
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
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                          //   shadowColor: MaterialStateProperty.all<Color>(Colors.amberAccent),
                          minimumSize: MaterialStateProperty.all(Size(50, 50)),
                          fixedSize: MaterialStateProperty.all(Size(320, 50)),
                          side: MaterialStateProperty.all(
                              BorderSide(color: Colors.green)),
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
