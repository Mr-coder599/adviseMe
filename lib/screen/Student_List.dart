import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllStudents extends StatefulWidget {
  const AllStudents({Key? key}) : super(key: key);

  @override
  State<AllStudents> createState() => _AllStudentsState();
}

class _AllStudentsState extends State<AllStudents> {
  Future getStudent() async {
    var firestor = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestor.collection("Student").get();
    return qn.docs;
  }

  NavigateToDetail(DocumentSnapshot student) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StudentDetails(
                  student: student,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: ,
      appBar: AppBar(
        title: Text('List of Clients'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: FutureBuilder(
            future: getStudent(),
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
                        title: Text(snapshot.data[index].data()['matric']),
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

class StudentDetails extends StatefulWidget {
  const StudentDetails({Key? key, required this.student}) : super(key: key);
  final DocumentSnapshot student;

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Client Details"),
        backgroundColor: Colors.blue,
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
                    'FULLNAME(S)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(widget.student["matric"]),
                  SizedBox(height: 20),
                  Text(
                    'HOME ADDRESS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(widget.student["name"]),
                  SizedBox(height: 20),
                  Text(
                    'OCCUPATION',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(widget.student["depart"]),
                  SizedBox(height: 20),
                  Text(
                    'PHONE NUMBER',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(widget.student["phone"]),
                  SizedBox(height: 20),
                  Text(
                    'GENDER',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(widget.student["gender"]),
                  SizedBox(height: 20),
                  Text(
                    'EMAIL ADDRESS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(widget.student["level"]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
