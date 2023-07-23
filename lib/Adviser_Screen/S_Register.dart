import 'package:adviseme/Adviser_Screen/S_Login.dart';
import 'package:adviseme/modules/staff_Auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Staff_Register extends StatefulWidget {
  const Staff_Register({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<Staff_Register> createState() => _Staff_RegisterState();
}

class _Staff_RegisterState extends State<Staff_Register> {
  final _staffidController = TextEditingController();
  final _fullnameController = TextEditingController();
  final _genderController = TextEditingController();
  final _advisorController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();
  var loading = false;
  final firestore = FirebaseFirestore.instance;
  // get firestore => null;
  //late final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return Column(
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Staff_Login()));
                  },
                  icon: Icon(Icons.login)),
            ],
          );
        }),
        title: Text(
          'Agent Registration',
          style: TextStyle(fontSize: 20.0),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 60,
          ),
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Please supply the neccessary information below',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.blue),
                      ),
                      SizedBox(height: 20),
                      CircleAvatar(
                        backgroundImage: AssetImage(
                            'assets/FeatureImage_real_estate_words.jpg'),
                        radius: 60,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        validator: _requiredValidator,
                        keyboardType: TextInputType.text,
                        controller: _staffidController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          label: Text('Fullname(s)'),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        validator: _requiredValidator,
                        keyboardType: TextInputType.text,
                        controller: _fullnameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          label: Text('Gender'),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        validator: _requiredValidator,
                        keyboardType: TextInputType.text,
                        controller: _genderController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          label: Text('Company Name'),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: _requiredValidator,
                        keyboardType: TextInputType.text,
                        controller: _advisorController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          label: Text('Company Address'),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        validator: _requiredValidator,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          label: Text('EmailAddress'),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: _requiredValidator,
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          label: Text('Phone Number'),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      if (loading) ...[
                        Center(child: CircularProgressIndicator()),
                      ],
                      if (!loading) ...[
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState != null) {
                              if (_formKey.currentState!.validate()) {
                                _staffRegistration();
                              }
                            }
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                          style: ButtonStyle(
                            textStyle: MaterialStateProperty.all(
                                TextStyle(fontSize: 20.0)),
                            elevation: MaterialStateProperty.all<double>(0.0),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.blueAccent),
                            //   shadowColor: MaterialStateProperty.all<Color>(Colors.amberAccent),
                            minimumSize:
                                MaterialStateProperty.all(Size(50, 50)),
                            fixedSize: MaterialStateProperty.all(Size(320, 50)),
                            side: MaterialStateProperty.all(
                                BorderSide(color: Colors.white)),
                          ),
                        ),
                      ],
                      // SizedBox(
                      //   height: 5.0,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              setState(() {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Staff_Login()));
                              });
                            },
                            child: Text('Already have an account..? click '
                                'here'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
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

  Future _staffRegistration() async {
    setState(() {
      loading = true;
    });
    try {
      final staffs = StaffReg(
          uid: widget.user.uid,
          staffid: _staffidController.text,
          fullname: _fullnameController.text,
          gender: _genderController.text,
          level: _advisorController.text,
          email: _emailController.text,
          phone: _phoneController.text);
      await firestore
          .collection('Advisor')
          .doc(staffs.uid)
          .set(staffs.toJson());
      // try {
      //   // await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //   //     email: _emailController.text, password: _passwordController.text);
      //   await FirebaseFirestore.instance.collection('Staffs').add({
      //     //  'uid': widget.user.uid,
      //     'email': _emailController.text,
      //     'staffid': _staffidController.text,
      //     'fullname': _fullnameController.text,
      //     'gender': _genderController.text,
      //     'advisor': _advisorController.text,
      //   });
      //show dialog to the user before signin in
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Data Saved'),
                content: Text('Account was created, proceed to login'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok'))
                ],
              ));
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Staff_Login()));
    } on FirebaseAuthException catch (e) {
      _handleSignupError(e);
      setState(() {
        loading = false;
      });
    }
  }

  void _handleSignupError(FirebaseAuthException e) {
    String? messageToDisplay;
    switch (e.code) {
      case 'email already in use':
        messageToDisplay = "This email is already in use";
        break;
      case 'invalid email':
        messageToDisplay = "This email you entered is invalid";
        break;
      case 'operation not allowed':
        messageToDisplay = "The operation not allowed";
        break;
    }
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(''),
              content: Text('Registration not Successfull'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'))
              ],
            ));
  }
}
//  uid: widget.user.uid,
// 'staffid': _staffidController.text,
// 'fullname': _fullnameController.text,
// 'gender': _genderController.text,
// 'advisor': _advisorController.text,
