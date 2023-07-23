import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecievedPost extends StatefulWidget {
  const RecievedPost({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<RecievedPost> createState() => _RecievedPostState();
}

class _RecievedPostState extends State<RecievedPost> {
  late User user;
  // final data = snapshot.data?.data();
  // final staff = StaffReg.froJson(data);
  @override
  StreamBuilder<QuerySnapshot<Object?>> build(BuildContext context) {
    // Future<void> queryDocumentUsingField() async {
    //   final DocumentSnapshot document = await FirebaseFirestore.instance
    //       .collection("Student")
    //       .doc("uid")
    //       .get();
    //   final QuerySnapshot snapshot = await FirebaseFirestore.instance
    //       .collection("posting")
    //       .where('level', isEqualTo: document.get('level'))
    //       .get();
    //   snapshot.docs.forEach((doc) {
    //     print(doc.data());
    //   });
    // }firestore.collection('Advisor').doc(widget.user.uid).snapshots();
    //
    // return qn.docs;
    // final firestore = FirebaseFirestore.instance;
    // Future<QuerySnapshot<Map<String, dynamic>>> qn =
    //     firestore.collection("Advisor").get();
    //
    // // }
    // StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
    //     stream:
    //     firestore.collection('Advisor').doc(widget.user.uid).snapshots(),
    // builder: (context, snapshot) {
    //   if (snapshot.hasError) {
    //     return Center(
    //       child: Text(snapshot.error?.toString() ?? ''),
    //     );
    //   }
    //   if (snapshot.hasData) {
    //     final data = snapshot.data?.data();
    //     if (data != null) {
    //       final staff = StaffReg.froJson(data);
    //     }
    //   }
    //   return Center(child: CircularProgressIndicator(),
    //   );
    // }
    // );
    // //end

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("posting").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // Future<void> queryDocumentUsingField() async {
        //   final DocumentSnapshot documentSnapshot = await FirebaseFirestore
        //       .instance
        //       .collection('Posting')
        //       .doc(widget.user.uid)
        //       .get();
        //   Future<QuerySnapshot<Map<String, dynamic>>> querySnapshot =
        //       FirebaseFirestore.instance
        //           .collection('Advisor')
        //           .where('level', isEqualTo: documentSnapshot.get('fullname'))
        //           .get();
        //   documentSnapshot.data();
        //   // documentSnapshot.d.docs.forEach((element) {
        //   //   print(documentSnapshot.data());
        //   // });
        // }

        if (snapshot.hasError) {
          return Center(
            child: Text('Something went wrong'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Loading....'));
        }
        if (snapshot.hasData) {
          // queryDocumentUsingField();
          return Scaffold(
            // drawer: NavigationDrawerWidget(),
            body: CustomScrollView(
              slivers: [
                CupertinoSliverNavigationBar(
                  largeTitle: Text('Posting'),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic>? data =
                          document.data() as Map<String, dynamic>?;
                      return CupertinoListTile(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                        title: Text(
                          //    '$data[desc]',
                          data!['adviser'],
                          //data!['title'],
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(
                          data!['desc'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18),
                        ),
                        leading: Text(
                          'Class' + ' ' + data!['level'],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            color: Colors.red,
          ),
        );
      },
    );
  }
}
// return StreamBuilder( stream: firestore.collection('Student').onSnapshot,
// builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// if (!snapshot.hasData) {
// return Center(
// child: CircularProgressIndicator(),
// );
// })
// List<DocumentSnapshot> secondDocs = snapshot.data.docs;
//
// return ListView.builder(
// itemCount: secondDocs.length,
// itemBuilder: (BuildContext context, int index) {
// DocumentSnapshot secondDoc = secondDocs[index];
//
// return StreamBuilder(
// stream: firestore
//     .collection('first-collection')
//     .where('field-from-second-doc', '==', secondDoc.data()['field-name'])
//     .onSnapshot,
// builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// if (!snapshot.hasData) {
// return Container();
// }
//
// List<DocumentSnapshot> firstDocs = snapshot.data.docs;
//
// return ListView.builder(
// itemCount: firstDocs.length,
// itemBuilder: (BuildContext context, int index) {
// DocumentSnapshot firstDoc = firstDocs[index];
//
// return ListTile(
// title: Text(firstDoc.data()['field-name']),
// );
// },
// );
// },
// );
// },
// );
// },
// ),
// ),
// );
// }
// }
