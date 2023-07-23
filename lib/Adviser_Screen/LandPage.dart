import 'package:adviseme/modules/AgentDrawer.dart';
import 'package:adviseme/modules/agentData.dart';
import 'package:adviseme/modules/staff_Auth.dart';
import 'package:adviseme/modules/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:estatemanagement/Shared/agentData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//
// import '../widgets/AgentDrawer.dart';
// import '../widgets/widget.dart';

class LandPage extends StatefulWidget {
  const LandPage({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  State<LandPage> createState() => _LandPageState();
}

class _LandPageState extends State<LandPage> {
  //controller of all filled
  final fullNameController = TextEditingController();
  final locationController = TextEditingController();
  final AcresController = TextEditingController();
  final AgentController = TextEditingController();
  final priceController = TextEditingController();
  final AgentPhoneController = TextEditingController();
  //end of controller
  final fireStore = FirebaseFirestore.instance;
  var loading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerAgent(
        user: widget.user,
      ),
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('Land Properties'),
        elevation: 0,
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream:
              fireStore.collection('Advisor').doc(widget.user.uid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString() ?? ''),
              );
            }
            if (snapshot.hasData) {
              final data = snapshot.data?.data();
              if (data! != null) {
                final staff = StaffReg.froJson(data);
                return SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/landsales.jpg'),
                              radius: 60,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Please supply neccessary information',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   mainAxisSize: MainAxisSize.max,
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
                              height: 20,
                            ),
                            TextFormField(
                              controller: fullNameController,
                              obscureText: false,
                              decoration: textInputDecoration.copyWith(
                                labelText: 'Name of the Owner',
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              validator: (val) {
                                if (val!.isNotEmpty) {
                                  return null;
                                }
                                return "required data";
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: locationController,
                              obscureText: false,
                              decoration: textInputDecoration.copyWith(
                                labelText: 'Location/Address',
                                prefixIcon: Icon(
                                  Icons.location_city_rounded,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              validator: (val) {
                                if (val!.isNotEmpty) {
                                  return null;
                                }
                                return "required Address";
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: AcresController,
                              obscureText: false,
                              decoration: textInputDecoration.copyWith(
                                labelText: 'Number of Arcer',
                                prefixIcon: Icon(
                                  Icons.landscape,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              validator: (val) {
                                if (val!.isNotEmpty) {
                                  return null;
                                }
                                return "required number of Acres";
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: priceController,
                              obscureText: false,
                              decoration: textInputDecoration.copyWith(
                                labelText: 'Price of the land',
                                prefixIcon: Icon(
                                  Icons.money,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (val) {
                                if (val!.isNotEmpty) {
                                  return null;
                                }
                                return "required name of the hostel";
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // TextFormField(
                            //   controller: AgentController,
                            //   decoration: textInputDecoration.copyWith(
                            //     labelText: 'Agent In charge',
                            //     prefixIcon: Icon(
                            //       Icons.person,
                            //       color: Theme.of(context).primaryColor,
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            // TextFormField(
                            //   controller: AgentPhoneController,
                            //   keyboardType: TextInputType.phone,
                            //   decoration: textInputDecoration.copyWith(
                            //     labelText: 'Agent Phone Number',
                            //     prefixIcon: Icon(
                            //       Icons.phone,
                            //       color: Theme.of(context).primaryColor,
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 20,
                            ),
                            if (loading) ...[
                              Center(child: CircularProgressIndicator()),
                            ],
                            if (!loading) ...[
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState != null) {
                                      if (_formKey.currentState!.validate()) {
                                        try {
                                          final land = LandData(
                                            uid: widget.user.uid,
                                            ownerName: fullNameController.text
                                                .toUpperCase(),
                                            location: locationController.text
                                                .toUpperCase(),
                                            agentName: '${staff.staffid}'
                                                .toUpperCase(),
                                            Nacres: AcresController.text,
                                            price: priceController.text.trim(),
                                            agentphone: '${staff.phone}',
                                          );
                                          await fireStore
                                              .collection('Landsales')
                                              .doc(land.uid)
                                              .set(land.toJson());
                                          // .set(land.toJson());
                                          Center(
                                            child: CircularProgressIndicator(),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                            'Land Properties updated Successfylly',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )));
                                          clear();
                                        } on FirebaseException catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text(e.message ?? '')));
                                        }
                                        // RentalDataSaved();
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Save Data',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                  ),
                                ),
                              ),
                            ],
                          ],
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
          }),
    );
  }

  clear() {
    fullNameController.clear();
    locationController.clear();
    AgentController.clear();
    priceController.clear();
    AcresController.clear();
    AgentPhoneController.clear();
  }
}
