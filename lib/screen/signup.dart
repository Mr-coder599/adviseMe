import 'package:adviseme/screen/Register.dart';
import 'package:adviseme/screen/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class S_SignUp extends StatefulWidget {
  const S_SignUp({Key? key}) : super(key: key);

  @override
  State<S_SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<S_SignUp> {
  final emailaddress = TextEditingController();
  final password = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late final User user;
  late bool isPasswordTextField = true;
  bool showPassword = true;
  GlobalKey _formKey = new GlobalKey<FormState>();
  late String pass = "";
  late String emails = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Client Sign Up'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 40.0),
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 60.0,
                    ),
                    // Text(
                    //   'Student Signing Up',
                    //   style: TextStyle(
                    //     color: Colors.green,
                    //     fontSize: 20.0,
                    //     fontWeight: FontWeight.w200,
                    //     fontFamily: 'Times New Roman',
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 30.0,
                    // ),
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage("assets/educationpng.png"),
                      //  color: Colors.white,
                    ),
                    //  Image.asset("assets/educationpng.png"),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      validator: _requiredValidator,
                      controller: emailaddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                        label: Text('EmailAddress'),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      // validator: (val) =>
                      //     val!.isEmpty ? 'Required emailAddress' : null,
                      // onChanged: (val) {
                      //   setState(() => emails = val);
                      // }
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      validator: _requiredValidator,
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
                      // validator: (val) =>
                      //     val!.isEmpty ? 'Required password' : null,
                      // onChanged: (val) {
                      //   setState(() => pass = val);
                      // }
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
                                builder: (_) => Register(user: user)));
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
                            MaterialStateProperty.all<Color>(Colors.green),
                        //   shadowColor: MaterialStateProperty.all<Color>(Colors.amberAccent),
                        minimumSize: MaterialStateProperty.all(Size(50, 50)),
                        fixedSize: MaterialStateProperty.all(Size(300, 50)),
                        side: MaterialStateProperty.all(
                            BorderSide(color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => SignIn()));
                      },
                      child: Text(
                        'Already have an account.. click here',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.pink,
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

  String? _requiredValidator(String? text) {
    if (text == null || text.trim().isEmpty) {
      return "This field is required";
    }
    return null;
  }
}
