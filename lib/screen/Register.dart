import 'package:adviseme/modules/studAuth.dart';
import 'package:adviseme/screen/signIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //initial selected value for level
  // String dropdownvalue = 'NDI';
  // var items = ['NDI', 'NDII', 'HNDI', 'HNDII'];
  //end of level

  final _formKey = new GlobalKey<FormState>();
  final _matricnoText = TextEditingController();
  final _fullnameText = TextEditingController();
  final _genderText = TextEditingController();
  final _departText = TextEditingController();
  final _levelText = TextEditingController();
  final _phoneText = TextEditingController();
  //final address = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('REGISTRATION'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 15.0),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/estateone.webp'),
                      radius: 50,
                    ),
                    //   Image.asset('assets/educationpng.png'),
                    SizedBox(height: 15.0),
                    TextFormField(
                      controller: _matricnoText,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.bookmark_add, size: 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          labelText: 'FullName(s)'),
                      validator: (val) =>
                          val!.isEmpty ? 'enter valid entry' : null,
                      // onChanged: (val) {
                      //   // setState(()=> names=val);
                      // }
                    ),
                    SizedBox(height: 15.0),

                    TextFormField(
                      controller: _fullnameText,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person, size: 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'Home Address'),
                      validator: (val) =>
                          val!.isEmpty ? 'enter valid entry' : null,
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      controller: _genderText,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person, size: 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'Gender'),
                      validator: (val) =>
                          val!.isEmpty ? 'enter valid entry' : null,
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      controller: _departText,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.local_fire_department, size: 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'Occupation'),
                      validator: (val) =>
                          val!.isEmpty ? 'enter valid entry' : null,
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      controller: _levelText,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.local_fire_department, size: 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'Email Address'),
                      validator: (val) =>
                          val!.isEmpty ? 'enter valid entry' : null,
                    ),
                    // Padding(padding: EdgeInsets.()),
                    // DropdownButton(
                    //     isExpanded: true,
                    //     hint: Text('Select your level'),
                    //     value: dropdownvalue,
                    //     icon: Icon(Icons.keyboard_arrow_down),
                    //     items: items.map((String items) {
                    //       return DropdownMenuItem(
                    //         value: items,
                    //         child: Text(items),
                    //       );
                    //     }).toList(),
                    //     onChanged: (String? newValue) {
                    //       setState(() {
                    //         dropdownvalue = newValue!;
                    //         _levelText.text = newValue;
                    //       });
                    //     }),
                    // TextFormField(
                    //   controller: _levelText,
                    //   keyboardType: TextInputType.text,
                    //   decoration: InputDecoration(
                    //       prefixIcon: Icon(Icons.leaderboard, size: 20.0),
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10.0),
                    //       ),
                    //       labelText: 'Level'),
                    //   validator: (val) =>
                    //       val!.isEmpty ? 'enter valid entry' : null,
                    // ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      controller: _phoneText,
                      keyboardType: TextInputType.phone,
                      maxLength: 11,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone, size: 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'Phone Number'),
                      validator: (val) =>
                          val!.isEmpty ? 'enter valid entry' : null,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            final student = StudReg(
                                uid: widget.user.uid,
                                matricno: _matricnoText.text,
                                name: _fullnameText.text,
                                gender: _genderText.text,
                                depart: _departText.text,
                                level: _levelText.text,
                                phone: _phoneText.text);
                            await firestore
                                .collection('Student')
                                .doc(student.uid)
                                .set(student.toJson());
                            CircularProgressIndicator();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Data Updated Successfully',
                                style: TextStyle(
                                    color: Colors.pink, fontSize: 25.0),
                              ),
                            ));
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignIn()));
                          } on FirebaseException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.message ?? '')));
                          }
                        }
                      },
                      child: Text(
                        'Register',
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
                        fixedSize: MaterialStateProperty.all(Size(250, 50)),
                        side: MaterialStateProperty.all(
                            BorderSide(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
