import 'package:adviseme/screen/settings.dart';
import 'package:adviseme/screen/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Adviser_Screen/studentRecieved.dart';
import '../screen/Student_List.dart';
import '../screen/profile.dart';

class NavigationDrawerWidget extends StatelessWidget {
  NavigationDrawerWidget({Key? key, required this.user}) : super(key: key);
  final User user;
  final padding = EdgeInsets.symmetric(horizontal: 20);
  VoidCallback? onClicked;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.blue,
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(
              height: 48,
            ),
            buildMenuItem(
              text: 'My Profile',
              icon: Icons.person,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(
              height: 20,
            ),
            buildMenuItem(
              text: 'Available Client',
              icon: Icons.people,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(
              height: 16,
            ),
            buildMenuItem(
              text: 'Settings',
              icon: Icons.settings,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(
              height: 16,
            ),
            buildMenuItem(
              text: 'Advise Update',
              icon: Icons.update,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(
              height: 16,
            ),
            buildMenuItem(
              text: 'Logout',
              icon: Icons.logout,
              onClicked: () => selectedItem(context, 4),
            ),
            const SizedBox(
              height: 16,
            ),
            buildMenuItem(
              text: 'About Developers',
              icon: Icons.developer_mode,
              onClicked: () => selectedItem(context, 5),
            ),
            SizedBox(
              height: 24,
            ),
            Divider(
              color: Colors.white,
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }

  buildMenuItem(
      {required String text,
      required IconData icon,
      required Function() onClicked}) {
    final color = Colors.white;
    final hovercolr = Colors.white;
    // VoidCallback? onClicked;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      hoverColor: hovercolr,
      onTap: onClicked,
    );
  }

  selectedItem(BuildContext context, int index) async {
    Navigator.of(context).pop();
    switch (index) {
      case 4:
        await FirebaseAuth.instance.signOut();
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => SignIn()));
        break;
      case 2:
        // Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Settings(
                  user: user,
                )));
        break;
      case 3:
        //  Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StudentRecievePost(
                  user: user,
                )));
        break;
      case 0:
        //  Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Stud_Profile(
                  user: user,
                )));
        break;
      case 1:
        //  Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AllStudents(
                //    user: user,
                )));
        break;
      //case 5:
      //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>))
    }
  }
}
//developer mode
