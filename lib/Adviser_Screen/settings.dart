import 'package:adviseme/modules/adviserDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdviserDrawer(
        user: widget.user,
      ),
      appBar: AppBar(
        title: Text('Settings'),
        elevation: 1,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 12.0),
        // padding: EdgeInsets.only(top: 30.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Settings',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.person,
                  size: 22.0,
                  color: Colors.greenAccent,
                ),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  'Account',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 2,
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Show Password'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('Option 1'),
                            Text('Option 2'),
                            Text('Option 3'),
                          ],
                        ),
                        actions: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Change Password',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            //new items from gesture
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Content Settings'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('Option 1'),
                            Text('Option 2'),
                            Text('Option 3'),
                          ],
                        ),
                        actions: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Content Settings',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            //end here
            SizedBox(
              height: 20.0,
            ),
            //new items from gesture
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Social Settings'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('Option 1'),
                            Text('Option 2'),
                            Text('Option 3'),
                          ],
                        ),
                        actions: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Social',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            //end here
            SizedBox(
              height: 20.0,
            ),
            //new items from gesture
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Language Settings'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('Option 1'),
                            Text('Option 2'),
                            Text('Option 3'),
                          ],
                        ),
                        actions: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Language',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            //end here
            SizedBox(
              height: 20.0,
            ),
            //new items from gesture
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Privacy and Security'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('Option 1'),
                            Text('Option 2'),
                            Text('Option 3'),
                          ],
                        ),
                        actions: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Privacy and Security',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            //end here
            Row(
              children: <Widget>[
                Icon(
                  Icons.speaker,
                  size: 20.0,
                  color: Colors.greenAccent,
                ),
                SizedBox(
                  width: 12.0,
                ),
                Text(
                  'Notification',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
