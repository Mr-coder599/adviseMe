import 'package:adviseme/screen/recievepost.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Adviser_Screen/Dashboard.dart';
import '../Adviser_Screen/Post.dart';
import '../Adviser_Screen/S_Login.dart';
import '../Adviser_Screen/settings.dart';

class AdviserDrawer extends StatelessWidget {
  AdviserDrawer({Key? key, required this.user}) : super(key: key);
  final User user;
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  VoidCallback? onClicked;
  //late User user;
  // late final User user;
  //AdviserDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.blueAccent,
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(
              height: 45,
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
              text: 'Post Review',
              icon: Icons.reviews,
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
              text: 'Post',
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
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Staff_Login()));
        break;
      case 2:
        //  Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Setting(
                  user: user,
                )));
        break;
      case 3:

        ///    Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Post(
                  user: user,
                )));
        break;

      case 0:
        //   Navigator.of(context).pop();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Dashboard(user: user)));
        break;
      case 1:
        // Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RecievedPost(
                  user: user,
                )));
        break;
    }
  }
}

//import 'package:adviseme/Adviser_Screen/Post.dart';
// import 'package:adviseme/Adviser_Screen/S_Login.dart';
// import 'package:adviseme/Adviser_Screen/settings.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class NavigationDrawerWidgets extends StatefulWidget {
//   const NavigationDrawerWidgets({Key? key, required this.user})
//       : super(key: key);
//   final User user;
//   @override
//   State<NavigationDrawerWidgets> createState() =>
//       _NavigationDrawerWidgetsState();
// }
//
// class _NavigationDrawerWidgetsState extends State<NavigationDrawerWidgets> {
//   final padding = const EdgeInsets.symmetric(horizontal: 20);
//   VoidCallback? onClicked;
//
//   late final User user;
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Material(
//         color: Colors.green,
//         child: ListView(
//           padding: padding,
//           children: <Widget>[
//             const SizedBox(
//               height: 48,
//             ),
//             buildMenuItem(
//               text: 'Posting',
//               icon: Icons.post_add,
//               onClicked: () => selectedItem(context, 0),
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             buildMenuItem(
//               text: 'Settings',
//               icon: Icons.settings,
//               onClicked: () => selectedItem(context, 1),
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             buildMenuItem(
//               text: 'Update',
//               icon: Icons.update,
//               onClicked: () => selectedItem(context, 2),
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             buildMenuItem(
//               text: 'Logout',
//               icon: Icons.logout,
//               onClicked: () => selectedItem(context, 3),
//             ),
//             const SizedBox(
//               height: 24,
//             ),
//             Divider(
//               color: Colors.white,
//               thickness: 2,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   buildMenuItem(
//       {required String text,
//       required IconData icon,
//       required Function() onClicked}) {
//     final color = Colors.white;
//     final hovercolr = Colors.white;
//     // VoidCallback? onClicked;
//     return ListTile(
//       leading: Icon(
//         icon,
//         color: color,
//       ),
//       title: Text(
//         text,
//         style: TextStyle(color: color),
//       ),
//       hoverColor: hovercolr,
//       onTap: onClicked,
//     );
//   }
//
//   selectedItem(BuildContext context, int index) async {
//     Navigator.of(context).pop();
//     switch (index) {
//       case 0:
//         //  Navigator.of(context).pop();
//         Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => Post(
//                 //    user: user,
//                 //  user: user,
//                 )));
//         break;
//       case 3:
//         await FirebaseAuth.instance.signOut();
//         Navigator.of(context).pushReplacement(
//             MaterialPageRoute(builder: (context) => Staff_Login()));
//         break;
//       case 1:
//         Navigator.of(context).pop();
//         Navigator.of(context).pushReplacement(
//             MaterialPageRoute(builder: (context) => Settings()));
//     }
//   }
// }
