import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class View_HouseRent extends StatefulWidget {
  const View_HouseRent({Key? key}) : super(key: key);

  @override
  State<View_HouseRent> createState() => _View_HouseRentState();
}

class _View_HouseRentState extends State<View_HouseRent> {
  Future getHouseRent() async {
    var firestor = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestor.collection("Rental").get();
    return qn.docs;
  }

  NavigateToDetail(
    DocumentSnapshot Rentals,
  ) {
    // final User user;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RentDetails(
                  // user: widget.user,
                  Rentals: Rentals,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of available House Rent'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder(
            future: getHouseRent(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text('Loading....'),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text(snapshot.data[index].data()['typhouse']),
                        onTap: () => NavigateToDetail(snapshot.data[index]),
                      );
                    });
              }
            }),
      ),
    );
  }
}

class RentDetails extends StatefulWidget {
  RentDetails({
    Key? key,
    required this.Rentals,
  }) : super(key: key);
  final DocumentSnapshot Rentals;

  // final User user;
  @override
  State<RentDetails> createState() => _RentDetailsState();
}

class _RentDetailsState extends State<RentDetails> {
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rental Details'),
        elevation: 0,
        centerTitle: true,
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
                  Image.network(
                    widget.Rentals['photo'],
                    width: 120,
                    height: 80,
                  ),
                  // CircleAvatar(
                  //   backgroundColor: Colors.black,
                  //   child: Icon(
                  //     Icons.person,
                  //     color: Colors.blue,
                  //     size: 80,
                  //   ),
                  //   radius: 40,
                  // ),
                  Divider(
                    thickness: 2,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Hostel Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(widget.Rentals["hostelname"]),
                  SizedBox(height: 20),
                  Text(
                    'Location',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(widget.Rentals["location"]),
                  SizedBox(height: 20),
                  Text(
                    'Type of Hostel',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(widget.Rentals["typhouse"]),
                  SizedBox(height: 20),
                  Text(
                    'Descrition',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(widget.Rentals["description"]),
                  SizedBox(height: 20),
                  Text(
                    'Status',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(widget.Rentals["status"]),
                  SizedBox(height: 20),
                  Text(
                    'Amount',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(widget.Rentals["amount"]),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Agent Number',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: openWhatsApp,
                        child: Text(
                          widget.Rentals["Agent_number"],
                        ),
                      ),
                      SizedBox(
                        width: 30.0,
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
                      Text(
                        'Chat Agent',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // Text(
                  //   'Agent Number',
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 17,
                  //   ),
                  // ),
                  // SizedBox(height: 10),
                  // Text(widget.Rentals["Agent_number"]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void openWhatsApp() async {
    final String phoneNumber = widget.Rentals["Agent_number"];
    '1234567890'; // Replace with your desired phone number
    String whatsappUrl = 'https://wa.me/$phoneNumber';
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
}
