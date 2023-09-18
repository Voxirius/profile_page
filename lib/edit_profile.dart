// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart' // new
    hide EmailAuthProvider, PhoneAuthProvider;    // new
import 'package:flutter/material.dart';           // new
import 'package:provider/provider.dart';          // new

import 'app_state.dart';                          // new
import 'src/authentication.dart';                 // new
import 'src/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

CollectionReference users = FirebaseFirestore.instance.collection('users');

Future<void> updateUser() {
  return users
    .set({
      'name' : nameValue,
      'nick' : nickValue,
      'birth' : birthdateValue,
      'gender' : genderValue,
      'password' : passwordValue,
      'vegetarian' : vegetarianValue,
      'student' : studentValue,
    });
}

class _EditProfileState extends State<EditProfile> {
  bool isObscurePassword = true;


  DateTime _dateTime = DateTime.now();                                    // _dateTime initialization

  String _dropdownGender = "Select Gender";                               // Definition of Gender dropdown
  List<String> dropDownOptionsGender = [
    "Select Gender",
    "Male",
    "Female",
  ];

  String _dropdownBoolean1 = "Are you vegetarian?";                       // Definition of Vegetarian dropdown
  List<String> dropDownOptionsBoolean1 = [
    "Are you vegetarian?",
    "Yes",
    "No",
  ];  

  String _dropdownBoolean2 = "Are you a student?";                         // Definition of Student dropdown
  List<String> dropDownOptionsBoolean2 = [
    "Are you a student?",
    "Yes",
    "No",
  ];    

  void dropdownCallBack1(String? selectedValue) {                         // Callback of Gender dropdown
    if (selectedValue is String) {
      setState(() {
        _dropdownGender = selectedValue;
      });
    }
  }

  void dropdownCallBack2(String? selectedValue) {                          // Callback of Vegetarian dropdown
    if (selectedValue is String) {
      setState(() {
        _dropdownBoolean1 = selectedValue;
      });
    }
  }

  void dropdownCallBack3(String? selectedValue) {                         // Callback of Student dropdown
    if (selectedValue is String) {
      setState(() {
        _dropdownBoolean2 = selectedValue;
      });
    }
  }    

  void _showDatePicker() {                                                // Date picker definition
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(1900), 
      lastDate: DateTime.now()
    ).then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }


  File? _image;                                                            // The variable that will store the image

  final _gallerypicker = ImagePicker();                                    // This is the gallery image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _gallerypicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }


  final _camerapicker = ImagePicker();                                    // This is the camera image picker
  Future<void> _openCameraPicker() async {
    final XFile? pickedImage =
        await _camerapicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Edit Profile'),                            // Title text at the top of the page
      ),
      body: Container(
          padding: EdgeInsets.only(left: 15, top: 20, right: 15),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(                                            // Properties of the profile photo
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 4,
                            color: Colors.white,
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: _image != null                      // Conditional statement for default profile photo vs picked photo if it exists
                              ? FileImage(_image!, ) as ImageProvider: NetworkImage(
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                          ),
                        ),
                      ),
                      Positioned(                                      // Gallery image picker icon properties
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Colors.white,
                            ),
                            color: Colors.blue,
                          ),
                          child: ElevatedButton(
                            
                            onPressed: _openImagePicker,
                            child: Icon(
                              Icons.image_search_outlined,
                              color: Colors.white,
                            ),
                          ),
                          
                        ),
                      ),
                      Positioned(                                       // Camera image picker icon properties
                        bottom: 0,
                        left: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Colors.white,
                            ),
                            color: Colors.blue,
                          ),
                          child: ElevatedButton(
                            onPressed: _openCameraPicker,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                          
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                buildTextField(                                       // Text field for full name
                    "Full Name", "Enter or edit your name & surname", false),
                buildTextField(                                       // Text field for nickname
                    "Nickname", "Enter or edit your nickname", false),
                    

                MaterialButton(                                       // Date picker button for birth date
                  onPressed: _showDatePicker,
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text('Select your birth date', 
                    style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 2,
                      color: Colors.grey,
                    ),)
                  ),
                ),

                Padding(                                              // Text output of the selected birth date
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text('${_dateTime.day}.${_dateTime.month}.${_dateTime.year}',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  ),
                ),

                DropdownButton(                                       // Dropdown menu for gender
                  items: dropDownOptionsGender.map<DropdownMenuItem<String>>((String mascot) {
                    return DropdownMenuItem<String>(
                      value: mascot,
                      child: Text(mascot));
                  }).toList(),
                  value: _dropdownGender,
                  onChanged: dropdownCallBack1, 
                ),

                buildTextField("Password", "****", true),

                DropdownButton(                                       // Dropdown menu for vegetarian or not
                  items: dropDownOptionsBoolean1.map<DropdownMenuItem<String>>((String mascot) {
                    return DropdownMenuItem<String>(
                      value: mascot,
                      child: Text(mascot));
                  }).toList(),
                  value: _dropdownBoolean1,
                  onChanged: dropdownCallBack2, 
                ),

                DropdownButton(                                       // Dropdown menu for student or not
                  items: dropDownOptionsBoolean2.map<DropdownMenuItem<String>>((String mascot) {
                    return DropdownMenuItem<String>(
                      value: mascot,
                      child: Text(mascot));
                  }).toList(),
                  value: _dropdownBoolean2,
                  onChanged: dropdownCallBack3, 
                ),

                SizedBox(height: 30),
                Row(                                                  // Properties of Cancel and SAVE buttons at the bottom of the page
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15,),
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15,),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Text(
                          "SAVE",
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Consumer<ApplicationState>(
                  builder: (context, appState, _) => AuthFunc(
                    loggedIn: appState.loggedIn,
                    signOut: () {
                      FirebaseAuth.instance.signOut();
                }),
          ),
              ],
              
            ),
          )),
    );
  }

  Widget buildTextField(                                               // Builder for the text fields
      String labelText, String placeholder, bool isPasswordTextField) {
    var _controller;
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        controller: _controller,
          onChanged: (String value) async {
            if (value != null) {
              var nameValue = value;
              return;
            }
          },
        obscureText: isPasswordTextField ? isObscurePassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscurePassword = !isObscurePassword;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}


