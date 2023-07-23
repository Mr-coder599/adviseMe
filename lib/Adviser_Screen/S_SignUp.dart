import 'package:adviseme/Adviser_Screen/S_Login.dart';
import 'package:adviseme/Adviser_Screen/S_Register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SSignUP extends StatefulWidget {
  const SSignUP({Key? key}) : super(key: key);

  @override
  State<SSignUP> createState() => _SSignUPState();
}

class _SSignUPState extends State<SSignUP> {
  final emailaddress = TextEditingController();
  final password = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late final User user;
  late bool isPasswordTextField = true;
  bool showPassword = true;
  GlobalKey _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(''),
      // ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 80.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Suply your valid Email and Password',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircleAvatar(
                      radius: 70.0,
                      backgroundImage: AssetImage("assets/set-of-cheerful.jpg"),
                      //  color: Colors.white,
                    ),
                    //   Image.asset("assets/set-of-cheerful.jpg"),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      controller: emailaddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                        label: Text('EmailAddress'),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      obscureText: isPasswordTextField ? showPassword : true,
                      controller: password,
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
                        label: Text('Password'),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          final credential =
                              await _auth.createUserWithEmailAndPassword(
                                  email: emailaddress.text,
                                  password: password.text);
                          final user = credential.user;
                          if (user != null) {
                            //    CircularProgressIndicator();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => Staff_Register(user: user)));
                          }
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.message ?? '')));
                        }
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                            TextStyle(fontSize: 20.0)),
                        elevation: MaterialStateProperty.all<double>(0.0),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        //   shadowColor: MaterialStateProperty.all<Color>(Colors.amberAccent),
                        minimumSize: MaterialStateProperty.all(Size(50, 50)),
                        fixedSize: MaterialStateProperty.all(Size(400, 50)),
                        side: MaterialStateProperty.all(
                            BorderSide(color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Staff_Login()));
                      },
                      child: Text(
                        'Already have an account.. click here',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
