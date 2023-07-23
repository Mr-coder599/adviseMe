import 'dart:io';

import 'package:adviseme/modules/AgentDrawer.dart';
import 'package:adviseme/modules/agentData.dart';
import 'package:adviseme/modules/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RentalPage extends StatefulWidget {
  const RentalPage({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<RentalPage> createState() => _RentalPageState();
}

class _RentalPageState extends State<RentalPage> {
  File? file;
  var loading = false;
  String dropdownvalue = 'Single Room';
  var items = [
    'Single Room',
    'SelfCon',
    'Room and Parlor',
    'Duplex',
    'Bongal'
        'ow'
  ];
  final _formKey = GlobalKey<FormState>();
  final houseController = TextEditingController();
  final locationController = TextEditingController();
  final typeHouseController = TextEditingController();
  final amountController = TextEditingController();
  final DescriptionController = TextEditingController();
  final statusController = TextEditingController();
  final AgentController = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  late final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerAgent(
        user: widget.user,
      ),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Rental Page'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  // CircleAvatar(
                  //   backgroundImage: file,
                  //   // AssetImage(
                  //   //     'assets/Houseplan-6-bedroom-1-1024x652.webp'),
                  //   radius: 60,
                  // ),
                  if (file != null)
                    Image.file(
                      file!,
                      height: 240,
                      width: 220,
                      fit: BoxFit.cover,
                    ),

                  TextButton(
                    onPressed: () {
                      _ImageSelection();
                    },
                    child: Text('Choose Image'),
                  ),
                  // Image.asset('assets/Houseplan-6-bedroom-1-1024x652.webp'),
                  SizedBox(
                    height: 20.0,
                  ),

                  Text(
                    'Update the available house with different '
                    'location',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Row(
                  //   children: <Widget>[
                  //     Text(
                  //       'Agent In charge',
                  //       style: TextStyle(),
                  //     ),
                  //     Text(
                  //       '${staff.staffid}',
                  //       style: TextStyle(
                  //         color: Colors.blueAccent,
                  //         fontSize: 12.0,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: houseController,
                    obscureText: false,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Name of the hostel or house',
                      prefixIcon: Icon(
                        Icons.house,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      }
                      return "required name of the hostel";
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: locationController,
                    obscureText: false,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Location',
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      }
                      return "location required";
                    },
                  ),
                  SizedBox(height: 15.0),
                  // Padding(padding: EdgeInsets.()),
                  DropdownButton(
                      isExpanded: true,
                      hint: Text('Select type '),
                      value: dropdownvalue,
                      icon: Icon(Icons.keyboard_arrow_down),
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                          typeHouseController.text = newValue;
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: amountController,
                    obscureText: false,
                    decoration: textInputDecoration.copyWith(
                      labelText: '#Amount',
                      prefixIcon: Icon(
                        Icons.money,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      }
                      return "Amount required";
                    },
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: DescriptionController,
                      //validator: _requiredValidator,
                      decoration: textInputDecoration.copyWith(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                        labelText: 'Description of message about the house',
                      ),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      maxLines: null,
                      minLines: null,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: statusController,
                    obscureText: false,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Status e.g Available or Paid',
                      prefixIcon: Icon(
                        Icons.signal_wifi_statusbar_4_bar,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      }
                      return "Field required";
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: AgentController,
                    obscureText: false,
                    decoration: textInputDecoration.copyWith(
                      labelText: 'Agent Number',
                      prefixIcon: Icon(
                        Icons.money,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isNotEmpty) {
                        return null;
                      }
                      return "Agent Number required";
                    },
                  ),

                  if (loading) ...[
                    Center(child: CircularProgressIndicator()),
                  ],
                  if (!loading) ...[
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState != null) {
                            if (_formKey.currentState!.validate()) {
                              _uploadImageToFirebase();
                            }
                          }
                        },
                        child: Text(
                          'Save Data',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future RentalDataSaved(String imageUrl) async {
    setState(() {
      loading = true;
    });

    try {
      // firestore.collection('Advisor').doc(widget.user.uid).snapshots();
      // var snapshot;
      // //builder(context, snapshot){}
      // final data = snapshot.data?.data();
      // if (data! != null) {
      //   final staff = StaffReg.froJson(data);
      final RentsData = RentData(
        uid: widget.user.uid,
        hostelname: houseController.text,
        location: locationController.text,
        typehouse: typeHouseController.text,
        amount: amountController.text,
        description: DescriptionController.text,
        status: statusController.text,
        Agent_number: AgentController.text,
        photo: imageUrl.toString(),
      );

      await firestore
          .collection('Rental')
          .doc(RentsData.uid)
          .set(RentsData.toJson());
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('House Data'),
                content: Text('House was Updated'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Ok')),
                ],
              ));
      typeHouseController.clear();
      amountController.clear();
      houseController.clear();
      locationController.clear();
      DescriptionController.clear();
      statusController.clear();
      AgentController.clear();
      // Navigator.of(context).pop();
      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //     builder: (context) => AgentDashboard(user: widget.user)));
      // }
    } on FirebaseAuthException catch (e) {
      _handleSignupError(e);
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> _uploadImageToFirebase() async {
    if (file != null) {
      try {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference storageRef =
            storage.ref().child('RentImage/${DateTime.now().toString()}.png');
        UploadTask uploadTask = storageRef.putFile(file!);
        TaskSnapshot storageSnapshot = await uploadTask.whenComplete(() {});
        String imageUrl = await storageSnapshot.ref.getDownloadURL();
        RentalDataSaved(imageUrl);
      } catch (e) {
        print('Error uploading');
      }
    }
  }

  void _handleSignupError(FirebaseAuthException e) {
    String? messageToDisplay;
    switch (e.code) {
      case 'email already in use':
        messageToDisplay = "This email is already in use";
        break;
      case 'invalid email':
        messageToDisplay = "This email you entered is invalid";
        break;
      case 'operation not allowed':
        messageToDisplay = "The operation not allowed";
        break;
    }
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(''),
              content: Text('Registration not Successfull'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'))
              ],
            ));
  }

  void _ImageSelection() async {
    return showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text('Choose Image'),
            content: SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text('Gallery'),
                    onTap: () {
                      _ImageFromGallery(context);
                    },
                  ),
                  GestureDetector(
                    child: Text('Camera'),
                    onTap: () {
                      _ImageFromCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  void _ImageFromGallery(BuildContext context) async {
    final pickImage = ImagePicker();
    final imagepicked = await pickImage.pickImage(source: ImageSource.gallery);
    if (imagepicked != null) {
      setState(() {
        file = File(imagepicked.path);
      });
    }
    Navigator.of(context).pop();
  }

  void _ImageFromCamera(BuildContext context) async {
    final pickImage = ImagePicker();
    final imagepicked = await pickImage.pickImage(source: ImageSource.camera);
    if (imagepicked != null) {
      setState(() {
        file = File(imagepicked.path);
      });
    }
    Navigator.of(context).pop();
  }
}
