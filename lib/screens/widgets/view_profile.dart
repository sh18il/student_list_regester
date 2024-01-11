import 'dart:io';

import 'package:flutter/material.dart';

class ViewProfile extends StatelessWidget {
  final String name;
  final String age;
  final String addres;
  final String imagePath;
  const ViewProfile({
    super.key,
    required this.name,
    required this.age,
    required this.addres,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 158, 195, 255),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(45))),
        title: const Text('PROFILE'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: FileImage(File(imagePath)),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.white70,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(45))),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Title(
                      color: Colors.black,
                      child: const Text(
                        'Name :',
                        style: TextStyle(color: Colors.blue),
                      )),
                  Container(
                    height: 70,
                    child: Center(
                      child: Text(name),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.white70,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Title(
                      color: Colors.black,
                      child: const Text(
                        'Age :',
                        style: TextStyle(color: Colors.blue),
                      )),
                  Container(
                    height: 60,
                    child: Center(
                      child: Text(age),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.white70,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(45))),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Title(
                      color: Colors.black,
                      child: const Text(
                        'Addres :',
                        style: TextStyle(color: Colors.blue),
                      )),
                  Container(
                    height: 70,
                    child: Center(
                      child: Text(addres),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
