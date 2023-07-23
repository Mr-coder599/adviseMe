import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StudentPeople extends StatefulWidget {
  const StudentPeople({Key? key}) : super(key: key);

  @override
  State<StudentPeople> createState() => _StudentPeopleState();
}

class _StudentPeopleState extends State<StudentPeople> {
  // imageFile;
  File? _selectedImage;
  _OpenGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
    Navigator.of(context).pop();
  }

  _OpenCamera(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
    Navigator.of(context).pop();
  }

  Future<void> _showDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Option'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text('Gallery'),
                    onTap: () {
                      _OpenGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text('Camera'),
                    onTap: () {
                      _OpenCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
        child: FutureBuilder(
          future: loadImageFromFirebaseStorage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text('No Images Selected'),
                      if (_selectedImage != null)
                        Image.file(
                          _selectedImage!,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _showDialog(context);
                          },
                          child: Text('Browse Images')),
                      TextButton(
                          onPressed: () {
                            _uploadImages();
                          },
                          child: Text(
                            'Upload Image',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          )),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: snapshot.data,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Generate Image'),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.error != null) {
              return Text('Error loading image');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<ImageProvider> loadImageFromFirebaseStorage() async {
    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child(
        'images/image.jpg'); // Replace with your image path in Firebase Storage

    try {
      final url = await ref.getDownloadURL();
      return CachedNetworkImageProvider(
        url,
      );
    } catch (e) {
      print('Error loading image: $e');
      return loadImageFromFirebaseStorage();
    }
  }

  void _uploadImages() async {
    if (_selectedImage != null) {
      try {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference storageRef =
            storage.ref().child('images/${DateTime.now().toString()}.png');
        UploadTask uploadTask = storageRef.putFile(_selectedImage!);
        await uploadTask.whenComplete(
            () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    'Image Uploaded Successfully',
                    style: TextStyle(color: Colors.pink, fontSize: 10.0),
                  ),
                )));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Error Image Uploading',
            style: TextStyle(color: Colors.pink, fontSize: 10.0),
          ),
        ));
      }
    } else {
      print('No image Selected');
    }
  }
}
