import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduventure/resource/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../animations/fade_animation.dart';
import '../utils/global_variables.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _isLoading = false;
  Uint8List? _image;
  String photoUrl = "";
  var _userData = {};

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);

    if(_file != null){
      return await _file.readAsBytes();

    }
    print('No Image Selected!!');
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _isLoading = true;
    });
    loadUserDetails();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void loadUserDetails() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (userSnap.exists) {
        setState(() {
          _userData = userSnap.data()!;
        });
      } else {}
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      _isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController _name = TextEditingController(text: _userData["name"]);
    TextEditingController _email = TextEditingController(text: _userData["email"]);
    TextEditingController _phoneNo = TextEditingController(text: _userData["phoneNo"]);
    TextEditingController _completeAddress = TextEditingController(text: _userData["completeAddress"]);
    TextEditingController _dob = TextEditingController(text: _userData["dob"]);
    TextEditingController _regNo = TextEditingController(text: _userData["regNo"]);
    TextEditingController _branch = TextEditingController(text: _userData["branch"]);
    TextEditingController _semester = TextEditingController(text: _userData["semester"]);
    TextEditingController _session = TextEditingController(text: _userData["session"]);
    TextEditingController _seatType = TextEditingController(text: _userData["seatType"]);

    DocumentReference reference = FirebaseFirestore.instance.collection("users").
    doc(FirebaseAuth.instance.currentUser?.uid);

    void updateUser(String photoUrl) async {
      setState(() {
        _isLoading = true;
      });
      try {
        Map<String, dynamic> data = {
          'name': _name.text, // Updating Document Reference
          'email': _email.text, // Updating Document Reference
          'phoneNo': _phoneNo.text, // Updating Document Reference
          'completeAddress': _completeAddress.text, // Updating Document Reference
          'dob': _dob.text, // Updating Document Reference
          'regNo': _regNo.text, // Updating Document Reference
          'branch': _branch.text, // Updating Document Reference
          'semester': _semester.text, // Updating Document Reference
          'session': _session.text, // Updating Document Reference
          'seatType': _seatType.text, // Updating Document Reference
          'photoUrl': photoUrl, // Updating Document Reference
        };
        await reference.update(data).whenComplete(() {
          setState(() {
            _isLoading = false;
          });
          showSnackBar("updated", context);
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(e.toString(), context);
        setState(() {
          _isLoading = false;
        });
      }
    }

    void uploadPhoto() async {
      setState(() {
        _isLoading = true;
      });
       photoUrl = await Storage()
          .uploadImageToStorage(_image!);
           updateUser(photoUrl);
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(52.0),
        child: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.blue.shade100,
          title: Text(
            "Update Profile",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body:
      Container(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                  1.1,
                  Center(
                    child:
                    GestureDetector(
                      onTap: selectImage,
                      child: _image != null
                          ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                          : CircleAvatar(
                        radius: 64,
                        backgroundImage:NetworkImage("${_userData["photoUrl"]}"),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                FadeAnimation(1.2, ProfileWidget(heading: "Name", name: _name, enabled: true,)),
                FadeAnimation(1.3, ProfileWidget(heading: "Email", name: _email, enabled: false,)),
                FadeAnimation(1.4, ProfileWidget(heading: "Phone", name: _phoneNo, enabled: true,)),
                FadeAnimation(1.5, ProfileWidget(heading: "Complete Address", name: _completeAddress, enabled: true,)),
                FadeAnimation(1.6, ProfileWidget(heading: "DOB", name: _dob, enabled: true,)),
                FadeAnimation(1.7, ProfileWidget(heading: "Registration No", name: _regNo, enabled: true,)),
                FadeAnimation(1.8, ProfileWidget(heading: "Branch", name: _branch, enabled: true,)),
                FadeAnimation(1.9, ProfileWidget(heading: "Semester", name: _semester, enabled: true,)),
                FadeAnimation(2.0, ProfileWidget(heading: "Session", name: _session, enabled: true,)),
                FadeAnimation(2.1, ProfileWidget(heading: "Seat Type", name: _seatType, enabled: true,)),

                SizedBox(
                  height: 25,
                ),

                Center(
                  child: SizedBox(
                      width: 250,
                      height: 46,
                      child: FadeAnimation(
                          2.2,
                          ElevatedButton(
                              onPressed: () {
                                if(_image != null){
                                  uploadPhoto();
                                }else{
                                  updateUser("${_userData["photoUrl"]}");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder()),
                              child: _isLoading ? CircularProgressIndicator(color: Colors.white,)
                                  : Text("Update")
                          )
                      )
                  ),
                ),

                SizedBox(
                  height: 25,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final String heading;
  final TextEditingController name;
  final bool enabled;
  const ProfileWidget({Key? key, required this.heading, required this.name, required this.enabled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            heading,
            style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextField(
            controller: name,
            enabled: enabled,
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }
}