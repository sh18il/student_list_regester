import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_name/functions/function.dart';
import 'package:project_name/model/data_model.dart';
import 'package:project_name/screens/widgets/add_student_widget.dart';
import 'package:project_name/screens/widgets/edit_screen.dart';
import 'package:project_name/screens/widgets/view_profile.dart';
// import 'package:project_name/screens/widgets/edit_screen.dart';

class ListStudentW extends StatefulWidget {
  const ListStudentW({super.key});

  @override
  State<ListStudentW> createState() => _ListStudentWState();
}

class _ListStudentWState extends State<ListStudentW> {
  String search = "";
  List<StudentModel> searchedlist = [];


 

 

  void searchlistUpdate() {
    getAllStudent();
    searchedlist = studentListNotifier.value
        .where((studentModel) =>
            studentModel.name.toLowerCase().contains(search.toLowerCase()))
        .toList();
    print('searchhhh$searchedlist');
    print(search);
  
  }

  @override
  Widget build(BuildContext context) {
    getAllStudent();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 86, 33, 243),
          child: Icon(Icons.person_add_alt),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddStudentW()));
          }),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(45))),
        title: Center(child: Text('S T U D E N T   L I S T ')),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  search = value;
                });
                                  searchlistUpdate();

              },
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: studentListNotifier,
              builder: (BuildContext ctx, List<StudentModel> studentList,
                  Widget? child) {
                return search.isNotEmpty ? ListView.separated(
                                    itemCount: searchedlist.length,

                  itemBuilder: (context, index) {
                    final data = searchedlist[index];
                    return ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewProfile(
                                name: data.name,
                                age: data.age,
                                addres: data.addres,
                                imagePath: data.image ?? ''),
                          ));
                        },
                        title: Text(data.name),
                        subtitle: Text(data.age),
                        leading: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 25, 25, 81),
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => EditStud(
                                            index: index,
                                            name: data.name,
                                            addres: data.addres,
                                            age: data.age,
                                            imagePath: data.image ?? "",
                                          )));
                                },
                                icon: Icon(
                                  Icons.edit,
                                )),
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
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ));
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                ): ListView.separated(
                  itemBuilder: (context, index) {
                    final data = studentList[index];
                    return ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewProfile(
                                name: data.name,
                                age: data.age,
                                addres: data.addres,
                                imagePath: data.image ?? ''),
                          ));
                        },
                        title: Text(data.name),
                        subtitle: Text(data.age),
                        leading: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 25, 25, 81),
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => EditStud(
                                            index: index,
                                            name: data.name,
                                            addres: data.addres,
                                            age: data.age,
                                            imagePath: data.image ?? "",
                                          )));
                                },
                                icon: Icon(
                                  Icons.edit,
                                )),
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
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ));
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: studentList.length,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
