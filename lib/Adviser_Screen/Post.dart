import 'package:adviseme/modules/adviserDrawer.dart';
import 'package:adviseme/modules/post_module.dart';
import 'package:adviseme/screen/recievepost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../modules/staff_Auth.dart';

class Post extends StatefulWidget {
  const Post({Key? key, required this.user}) : super(key: key);
  final User user;
  // late final User user;
  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  //late final User user;
  // bool loading = false;
  final _titleController = TextEditingController();
  final _adviserController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _classController = TextEditingController();
  //final firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final dd = DateTime.now();
  //String format ="dd/mmm/yyy";
  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    // final User user;
    final Future<QuerySnapshot<Map<String, dynamic>>> document =
        firestore.collection("Student").where("level").get();
    // final QuerySnapshot snapshot = firestore as QuerySnapshot<Object?>;
    // firestore.collection('Advisor').doc(widget.user.uid).snapshots();
    //
    // final data = snapshot.data?.data();
    // final staff = StaffReg.froJson(data);
    return Scaffold(
      drawer: AdviserDrawer(
        user: widget.user,
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Posting'),
        elevation: 0,
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
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 70.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            // SizedBox(
                            //   height: 20.0,
                            // ),
                            CircleAvatar(
                              radius: 80.0,
                              backgroundImage:
                                  AssetImage("assets/set-of-cheerful.jpg"),
                              //  color: Colors.white,
                            ),
                            //  Image.asset("assets/set-of-cheerful.jpg"),
                            SizedBox(
                              height: 20.0,
                            ),
                            // Text(dd),
                            // SizedBox(
                            //   height: 20.0,
                            // ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              DateFormat('yyyy/MM/dd hh:mm:ss a')
                                  .format(DateTime.now()),
                              style:
                                  TextStyle(fontSize: 18, color: Colors.blue),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              '${staff.fullname}',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  wordSpacing: 1.0),
                            ),
                            // TextFormField(
                            //   initialValue: ('${staff.fullname}'),
                            //   //  controller: _adviserController,
                            //   validator: _requiredValidator,
                            //   decoration: InputDecoration(
                            //     border: OutlineInputBorder(),
                            //     labelText: 'Adviser name',
                            //   ),
                            // ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              controller: _titleController,
                              validator: _requiredValidator,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Title',
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              controller: _classController,
                              validator: _requiredValidator,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'example ND1, NDII',
                                labelText: 'Class',
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              width: 350,
                              child: TextFormField(
                                controller: _descriptionController,
                                validator: _requiredValidator,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(),
                                  labelText: 'Description of message',
                                ),
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                maxLines: null,
                                minLines: null,
                              ),
                            ),

                            SizedBox(
                              height: 15.0,
                            ),
                            // if (loading) ...[
                            //   Center(child: CircularProgressIndicator()),
                            // ],
                            // if (!loading) ...[
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState != null) {
                                  if (_formKey.currentState!.validate()) {
                                    //   PostingfromAdviser();
                                    try {
                                      final postAdvise = Posting(
                                        uid: widget.user.uid,
                                        title: _titleController.text,
                                        adviser: '${staff.fullname}'.toString(),
                                        //_adviserController.text,
                                        desc: _descriptionController.text,
                                        level: _classController.text,
                                        timeDate: dd.toString(),
                                      );
                                      await firestore
                                          .collection('posting')
                                          .doc(postAdvise.uid)
                                          .set(postAdvise.toJson())
                                          .whenComplete(() => document);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        backgroundColor: Colors.black,
                                        content: Text(
                                          'Posting Successfully',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 19.0),
                                        ),
                                      ));
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RecievedPost(
                                                    user: widget.user,
                                                  )));
                                    } on FirebaseException catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(e.message ?? '')));
                                    }
                                  }
                                }
                              },
                              child: Text(
                                'Post',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              style: ButtonStyle(
                                textStyle: MaterialStateProperty.all(
                                    TextStyle(fontSize: 20.0)),
                                elevation:
                                    MaterialStateProperty.all<double>(0.0),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                //   shadowColor: MaterialStateProperty.all<Color>(Colors.amberAccent),
                                minimumSize:
                                    MaterialStateProperty.all(Size(50, 50)),
                                fixedSize:
                                    MaterialStateProperty.all(Size(350, 50)),
                                side: MaterialStateProperty.all(
                                    BorderSide(color: Colors.white)),
                              ),
                            ),
                          ],
                          //],
                        ),
                      ),
                    ),
                  ],
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

String? _requiredValidator(String? text) {
  if (text == null || text.trim().isEmpty) {
    return "This field is required";
  }
  return null;
}

String getCurrentDate() {
  TimeOfDay time = TimeOfDay(hour: 12, minute: 30);
  //var date = DateTime.now().toString();
  // var format = DateFormat('d MMM, hh:mm a');
  DateTime date = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour,
    DateTime.now().minute,
    DateTime.now().second,
  );
  // var dateParse = DateTime();

  var formattedDate = "${date.day}-${date.month}-${date.year}";
  return formattedDate.toString();
}
// String formatTimestamp(int timestamp) {
//   var format = DateFormat('d MMM, hh:mm a');
//   var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
//   return format.format(date);
// }
