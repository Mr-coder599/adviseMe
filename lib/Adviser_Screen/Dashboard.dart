import 'package:adviseme/Adviser_Screen/RentalPage.dart';
import 'package:adviseme/modules/AgentDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../modules/staff_Auth.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, required this.user}) : super(key: key);
  // final User user;

  //const Dashboard({super.key, required this.user});
  final User user;
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // late final User user;
  final firestore = FirebaseFirestore.instance;

  int currentIndex = 0;

  // get user => null;
  // var Screen = [
  //   // Dashboard(user: user),
  //   StudentPeople(),
  //   Post(),
  //   Settings(),
  // ];
  // static var user;

  //static get user => null;
  @override
  Widget build(BuildContext context) {
    //final User user;
    return Scaffold(
      drawer: DrawerAgent(
        user: widget.user,
      ),
      appBar: AppBar(
        title: Text('My Profile'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RentalPage(
                            user: widget.user,
                          )));
            },
            icon: Icon(Icons.post_add),
            //child:Text(''),
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream:
            firestore.collection('Advisor').doc(widget.user.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error?.toString() ?? ''),
            );
          }
          if (snapshot.hasData) {
            final data = snapshot.data?.data();
            if (data != null) {
              final staff = StaffReg.froJson(data);
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
                          height: 550,
                          width: 500,
                          child: Column(children: <Widget>[
                            SizedBox(
                              height: 40.0,
                            ),
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/set-of-cheerful.jpg'),
                              radius: 60.0,
                            ),
                            Divider(
                              thickness: 2,
                              color: Colors.green,
                            ),
                            SizedBox(
                              height: 35.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'FULLNAME:',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    wordSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Text(
                                  '${staff.staffid}',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      wordSpacing: 1.0),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            // another row for fulname
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'GENDER:',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    wordSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 95.0,
                                ),
                                Text(
                                  '${staff.fullname}',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      wordSpacing: 1.0),
                                ),
                              ],
                            ),
                            //another row for gender
                            SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'COMPANY NAME:',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    wordSpacing: 1.0,
                                    //  fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // SizedBox(
                                //   width: 155.0,
                                // ),
                                Text(
                                  // ${staff.gender}
                                  '${staff.gender}',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      wordSpacing: 1.0),
                                ),
                              ],
                            ),
                            //another row for phone
                            SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'Company Address',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    wordSpacing: 1.0,
                                  ),
                                ),
                                // SizedBox(
                                //   width: 15.0,
                                // ),
                                Text(
                                  // ${staff.level}
                                  '${staff.level}',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      wordSpacing: 1.0),
                                ),
                              ],
                            ),
                            //for phone number and level
                            SizedBox(
                              height: 30.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'Phone Number:',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    wordSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // SizedBox(
                                //   width: 95.0,
                                // ),
                                Text(
                                  '${staff.phone}',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      wordSpacing: 1.0),
                                ),
                                //numbesss
                                SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 50.0,
                                ),
                                Text(
                                  'EmailAddress:',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    wordSpacing: 1.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // SizedBox(
                                //   width: 115.0,
                                // ),
                                Text(
                                  '${staff.gender}',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      wordSpacing: 1.0),
                                ),
                              ],
                            ),
                          ]),
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
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.white70,
      //   selectedFontSize: 15,
      //   backgroundColor: Colors.lightBlue,
      //   currentIndex: currentIndex,
      //   onTap: tabBuilder,
      //   //(index) => setState(() => currentIndex = Screen as
      //   //  int),
      //   items: [
      //     // BottomNavigationBarItem(
      //     //   icon: (Icon(Icons.home)),
      //     //   label: 'Home',
      //     //   // backgroundColor: Colors.lightBlue,
      //     // ),
      //     BottomNavigationBarItem(
      //       icon: (Icon(Icons.people)),
      //       label: 'Student',
      //       tooltip: 'Student',
      //       //backgroundColor: Colors.deepPurple,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: (Icon(Icons.post_add)),
      //       label: 'Post',
      //       //backgroundColor: Colors.redAccent,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: (Icon(Icons.settings)),
      //       label: 'Setting',
      //       //  backgroundColor: Colors.redAccent,
      //     ),
      //   ],
      // ),

      //  tabBuilder:(BuildContext context, int index){
      //   return Screen;
      // }
    );
  }

  // tabBuilder(int index) {
  //   setState(() {
  //     currentIndex = index;
  //   });
  // }
}
