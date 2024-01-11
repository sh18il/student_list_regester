


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_name/functions/function.dart';
import 'package:project_name/model/data_model.dart';


class EditStud extends StatefulWidget {
  String name;
  String age;
  String addres;
  int index;
  dynamic imagePath;
  EditStud(
      {super.key,
      required this.name,
      required this.age,
      required this.addres,
      required this.index,
      required this.imagePath});

  @override
  State<EditStud> createState() => _EditStudState();
}

class _EditStudState extends State<EditStud> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _addresController = TextEditingController();
  File? _selectImg;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.name);
    _ageController = TextEditingController(text: widget.age);
    _addresController = TextEditingController(text: widget.addres);
    _selectImg = widget.imagePath != '' ? File(widget.imagePath) : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color.fromARGB(221, 158, 195, 255),
      appBar: AppBar(
        title: const Text('EDIT STUDENT LIST'),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(45))),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 80,
                backgroundColor: const Color.fromARGB(255, 25, 25, 81),
                backgroundImage: _selectImg != null
                    ? FileImage(_selectImg!)
                    : const AssetImage("assets/studentdp.jpg.png")
                        as ImageProvider,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 64, 4, 79)),
                  onPressed: () {
                    _pickImageFromGallery();
                  },
                  icon: const Icon(Icons.image),
                  label: const Text("GALLERY")),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 64, 4, 79)),
                  onPressed: () {
                    _pickImageFromCam();
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("CAMERA")),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  hintText: "Name",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  hintText: "age",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _addresController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  hintText: "Addres",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    updateAll();
                    Navigator.pop(context);
                  },
                  child: const Text('submit')),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateAll() async {
    final name1 = _nameController.text;
    final age1 = _ageController.text;
    final addres1 = _addresController.text;
    final Image1 = _selectImg!.path;

    if (name1.isEmpty || age1.isEmpty || addres1.isEmpty) {
      return;
    } else {
      final update =
          StudentModel(name: name1,
           age: age1,
            addres: addres1,
             image: Image1);
      editstudent(widget.index, update);
    }
  }

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnImage == null) {
      return;
    }

    setState(() {
      _selectImg = File(returnImage.path);
    });
  }

  _pickImageFromCam() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnImage == null) {
      return;
    }

    setState(() {
      _selectImg = File(returnImage.path);
    });
  }
}
