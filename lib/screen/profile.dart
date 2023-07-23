import 'package:adviseme/modules/ClientDrawer.dart';
import 'package:adviseme/modules/studAuth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Stud_Profile extends StatefulWidget {
  final User user;
  // const Stud_Profile({Key? key}) : super(key: key);
  const Stud_Profile({required this.user});

  @override
  State<Stud_Profile> createState() => _Stud_ProfileState();
}

class _Stud_ProfileState extends State<Stud_Profile> {
  final firestore = FirebaseFirestore.instance;
  late User _currentUser;
  int currentIndex = 0;
  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ClientNavigation(
        user: widget.user,
      ),
      // NavigationDrawerWidget(
      //   user: widget.user,
      // ),
      appBar: AppBar(
        title: Text('Profile'),
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream:
            firestore.collection('Student').doc(widget.user.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error?.toString() ?? ''),
            );
          }
          if (snapshot.hasData) {
            final data = snapshot.data?.data();
            if (data != null) {
              final student = StudReg.froJson(data);
              return SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                    child: Center(
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                          ),
                        ),
                        child: SizedBox(
                          height: 500,
                          width: 500,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 40.0,
                              ),
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/rentpic.jpg'),
                                radius: 40.0,
                              ),
                              Divider(
                                thickness: 2,
                                color: Colors.green,
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'FullName:',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      wordSpacing: 1.0,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: 15.0,
                                  // ),
                                  Text(
                                    '${student.matricno}',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        wordSpacing: 1.0),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              // another row for fulname
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Address:',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      wordSpacing: 1.0,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: 15.0,
                                  // ),
                                  Text(
                                    '${student.name}',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        wordSpacing: 1.0),
                                  ),
                                ],
                              ),
                              //another row for gender
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Gender:',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      wordSpacing: 1.0,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Text(
                                    '${student.gender}',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        wordSpacing: 1.0),
                                  ),
                                ],
                              ),
                              //another row for phone
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Occupation:',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      wordSpacing: 1.0,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Text(
                                    '${student.depart}',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        wordSpacing: 1.0),
                                  ),
                                ],
                              ),
                              //for phone number and level
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'EmailAddress:',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      wordSpacing: 1.0,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: 15.0,
                                  // ),
                                  Text(
                                    '${student.level}',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        wordSpacing: 1.0),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Phone Number:',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      wordSpacing: 1.0,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Text(
                                    '${student.phone}',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        wordSpacing: 1.0),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: 20.0,
                              // ),
                              // Center(
                              //   child: TextButton(
                              //     onPressed: () async {
                              //       await FirebaseAuth.instance.signOut();
                              //       Navigator.of(context).pushReplacement(
                              //           MaterialPageRoute(
                              //               builder: (context) => SignIn()));
                              //     },
                              //     child: Text(
                              //       'Sign Out',
                              //       style: TextStyle(
                              //         color: Colors.green,
                              //         fontWeight: FontWeight.bold,
                              //         fontSize: 20.0,
                              //       ),
                              //     ),
                              //   ),
                              // )
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
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
