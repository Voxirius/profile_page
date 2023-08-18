// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:io';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Navigation Page'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.deepOrange,
            ),
              child: Row(
                children: [
                  Image.network("https://static.vecteezy.com/system/resources/thumbnails/002/318/271/small/user-profile-icon-free-vector.jpg", 
                    height: 36,
                    fit: BoxFit.fitHeight, 
                    ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Profile', style: TextStyle( 
                        color: Colors.black, fontSize: 17.5, 
                      ),
                    ),
                  ),
                ],
              ),
          ),

        ],
      ),
    );
  }
}