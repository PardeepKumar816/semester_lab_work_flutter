import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentData2 extends StatefulWidget {
  const StudentData2({Key? key}) : super(key: key);

  @override
  State<StudentData2> createState() => _StudentData2State();
}

class _StudentData2State extends State<StudentData2> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  SharedPreferencesHelper instance = SharedPreferencesHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreferences DataBase'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: TextField(
                controller: controller1,
                decoration: const InputDecoration(
                    hintText: 'Enter Name', border: InputBorder.none),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: TextField(
                controller: controller2,
                decoration: const InputDecoration(
                    hintText: 'Enter RollNo', border: InputBorder.none),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: TextField(
                controller: controller3,
                decoration: const InputDecoration(
                    hintText: 'Enter District', border: InputBorder.none),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (controller1.text.isNotEmpty &&
                      controller2.text.isNotEmpty &&
                      controller3.text.isNotEmpty) {
                    SharedPreferencesHelper.rollNo.add(controller2.text);
                    await instance.addData(
                        controller1.text, controller3.text, controller2.text);
                  }
                },
                child: const Text('Add Data')),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ShowDataList2()));
                },
                child: const Text('Show Data')),
          ],
        ),
      ),
    );
  }
}

class ShowDataList2 extends StatefulWidget {
  const ShowDataList2({Key? key}) : super(key: key);

  @override
  State<ShowDataList2> createState() => _ShowDataList2State();
}

class _ShowDataList2State extends State<ShowDataList2> {
  SharedPreferencesHelper instance = SharedPreferencesHelper();

  void triggerFunction() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Show Data'),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: instance.getAllData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Column(
                  children: [
                    snapshot.data.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      title: Text(snapshot.data[index].name),
                                      subtitle:
                                          Text(snapshot.data[index].district),
                                      trailing: IconButton(
                                          onPressed: () async {
                                            await instance.deleteData(
                                                SharedPreferencesHelper
                                                    .rollNo[index]);
                                            setState(() {});
                                          },
                                          icon: const Icon(Icons.delete)),
                                    ),
                                  );
                                }),
                          )
                        : const Center(
                            child: Text('No Data at this Moment'),
                          ),
                  ],
                );
              }
            }));
  }
}

class SharedPreferencesHelper {
  static List<String> rollNo = [];

  Future<void> addData(String name, String district, String rollNo) async {
    final instance = await SharedPreferences.getInstance();
    instance.setStringList(rollNo, [name, district]);
  }

  Future<void> deleteData(String rollNo) async {
    final instance = await SharedPreferences.getInstance();
    instance.remove(rollNo);
  }

  Future<List<Student>> getAllData() async {
    final instance = await SharedPreferences.getInstance();
    List<Student> list = [];
    for (int i = 0; i < rollNo.length; i++) {
      List<String>? data = instance.getStringList(rollNo[i]);
      list.add(Student(rollNo: rollNo[i], district: data![1], name: data[0]));
    }
    return list;
  }
}

class Student {
  String name;
  String district;
  String rollNo;
  Student({required this.rollNo, required this.district, required this.name});
}
