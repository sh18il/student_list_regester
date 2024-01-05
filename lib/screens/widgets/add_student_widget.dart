import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_name/functions/function.dart';
import 'package:project_name/model/data_model.dart';

class AddStudentW extends StatefulWidget {
  AddStudentW({super.key});

  @override
  State<AddStudentW> createState() => _AddStudentWState();
}

class _AddStudentWState extends State<AddStudentW> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _classController = TextEditingController();

  final _fomkey = GlobalKey<FormState>();

  File? _selectImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD STUDENT '),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(45))),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 80,
                backgroundColor: const Color.fromARGB(255, 25, 25, 81),
                backgroundImage: _selectImage != null
                    ? FileImage(_selectImage!)
                    : AssetImage("assets/studentdp.jpg.png") as ImageProvider,
              ),
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 64, 4, 79)),
                onPressed: () {
                  _pickImgGallery();
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _fomkey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter name';
                        } else {
                          return null;
                        }
                      },
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Name',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter age';
                        } else {
                          return null;
                        }
                      },
                      controller: _ageController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Age',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter addres';
                        } else {
                          return null;
                        }
                      },
                      controller: _classController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Addres',
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_fomkey.currentState!.validate()) {
                            onAddStdtButn();
                            Navigator.pop(context);
                          }
                        },
                        child: Icon(Icons.person_add_alt_1_outlined)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> onAddStdtButn() async {
    final _name = _nameController.text;
    final _age = _ageController.text;
    final _class = _classController.text;

    if (_name.isEmpty || _age.isEmpty || _class.isEmpty) {
      return;
    }

    final _student = StudentModel(
        name: _name, age: _age, addres: _class, image: _selectImage!.path);
    addStudent(_student);
  }

  Future _pickImgGallery() async {
    final returnImg =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnImg == null) {
      return;
    }
    setState(() {
      _selectImage = File(returnImg.path);
    });
  }

  _pickImageFromCam() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnImage == null) {
      return;
    }

    setState(() {
      _selectImage = File(returnImage.path);
    });
  }
}
