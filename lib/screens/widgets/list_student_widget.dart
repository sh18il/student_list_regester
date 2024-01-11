import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_name/functions/function.dart';
import 'package:project_name/model/data_model.dart';
import 'package:project_name/screens/widgets/add_student_widget.dart';
import 'package:project_name/screens/widgets/edit_screen.dart';
import 'package:project_name/screens/widgets/view_profile.dart';

class ListStudentW extends StatefulWidget {
  const ListStudentW({Key? key}) : super(key: key);

  @override
  State<ListStudentW> createState() => _ListStudentWState();
}

class _ListStudentWState extends State<ListStudentW> {
  String search = "";
  List<StudentModel> searchedList = [];

  void searchListUpdate() {
    getAllStudent();
    searchedList = studentListNotifier.value
        .where((studentModel) =>
            studentModel.name.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    searchListUpdate();

    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 38, 51, 72),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 86, 33, 243),
        child: const Icon(Icons.person_add_alt),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddStudentW()));
        },
      ),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(45)),
        ),
        title: const Center(child: Text('S T U D E N T   L I S T ')),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  search = value;
                  searchListUpdate();
                });
              },
              decoration: const InputDecoration(
                fillColor: Colors.white,
                labelText: 'Search',
                labelStyle: TextStyle(color: Colors.white),
                focusColor: Colors.white,
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: studentListNotifier,
              builder: (BuildContext ctx, List<StudentModel> studentList,
                  Widget? child) {
                return search.isNotEmpty
                    ? searchedList.isEmpty
                        ? Center(
                            child: Text(
                              'No results found.',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : _buildStudentList(searchedList)
                    : _buildStudentList(studentList);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentList(List<StudentModel> students) {
    return students.isEmpty
        ? Center(
            child: Text(
              'No students available.',
              style: TextStyle(color: Colors.white),
            ),
          )
        : ListView.separated(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final data = students[index];
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ViewProfile(
                        name: data.name,
                        age: data.age,
                        addres: data.addres,
                        imagePath: data.image ?? '',
                      ),
                    ),
                  );
                },
                title: Text(
                  data.name,
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  data.age,
                  style: const TextStyle(color: Colors.white),
                ),
                leading: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 25, 25, 81),
                  backgroundImage: data.image != null
                      ? FileImage(File(data.image!))
                      : const AssetImage("assets/studentdp.jpg.png")
                          as ImageProvider,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditStud(
                              index: index,
                              name: data.name,
                              addres: data.addres,
                              age: data.age,
                              imagePath: data.image ?? "",
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 123, 146, 185),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirm Deletion'),
                              content: const Text(
                                  'Are you sure you want to delete this student?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    deletStudent(index);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  color: Colors.white,
                ),
              );
            },
          );
  }
}
