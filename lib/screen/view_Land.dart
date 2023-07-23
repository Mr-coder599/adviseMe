import 'package:adviseme/modules/ClientDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewLand extends StatefulWidget {
  const ViewLand({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<ViewLand> createState() => _ViewLandState();
}

class _ViewLandState extends State<ViewLand> {
  Future getLand() async {
    var firestor = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestor.collection("Landsales").get();
    return qn.docs;
  }

  NavigateToDetail(DocumentSnapshot Landsales) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LandsDetails(
                  Landsales: Landsales,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ClientNavigation(
        user: widget.user,
      ),
      appBar: AppBar(
        title: Text('List of available Land'),
        elevation: 0,
      ),
      body: Container(
        child: FutureBuilder(
            future: getLand(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text('Loading...'),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text('Agent in Charge' +
                            ' ' +
                            snapshot.data[index].data()['agentName']),
                        onTap: () => NavigateToDetail(snapshot.data[index]),
                      );
                    });
              }
              // return Center(
              //   child: Text('No found'),
              // );
            }),
      ),
    );
  }
}

class LandsDetails extends StatefulWidget {
  const LandsDetails({Key? key, required this.Landsales}) : super(key: key);
  final DocumentSnapshot Landsales;
  @override
  State<LandsDetails> createState() => _LandsDetailsState();
}

class _LandsDetailsState extends State<LandsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Builder(builder: (BuildContext context) {
        //   return Column(
        //     children: <Widget>[
        //       IconButton(
        //           onPressed: () {
        //             Navigator.push(context,
        //                 MaterialPageRoute(builder: (context) =>ViewLand ()));
        //           },
        //           icon: Icon(Icons.login)),
        //     ],
        //   );
        // }),
        title: Text('Land Details'),
        elevation: 0,
      ),
      body: Container(
        child: Card(
          child: ListTile(
            // title: Text(
            //   widget.student["name"],
            // ),
            subtitle: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.person,
                      color: Colors.blue,
                      size: 80,
                    ),
                    radius: 40,
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Land Owner',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(widget.Landsales["ownerName"]),
                  SizedBox(height: 20),
                  Text(
                    'Agent In Charge',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(widget.Landsales["agentName"]),
                  SizedBox(height: 20),
                  Text(
                    'Location',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(widget.Landsales["location"]),
                  SizedBox(height: 20),
                  Text(
                    'Price',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(widget.Landsales["price"]),
                  SizedBox(height: 20),
                  Text(
                    'No Of Acres or plot',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(widget.Landsales["Nacres"]),
                  SizedBox(height: 20),
                  Text(
                    'Agent Number',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: openWhatsApp,
                        child: Text(
                          widget.Landsales["agentPhone"],
                        ),
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      Text(
                        'Chat Agent',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/whatsapp.png'),
                        radius: 20,
                        child: GestureDetector(
                          onTap: openWhatsApp,
                          // child: Text(
                          //   widget.Landsales["agentPhone"],
                          // ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void openWhatsApp() async {
    final String phoneNumber = widget.Landsales["agentPhone"];
    '1234567890'; // Replace with your desired phone number
    String whatsappUrl = 'https://wa.me/$phoneNumber';
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
}
