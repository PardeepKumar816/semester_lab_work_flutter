import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class StudentData extends StatefulWidget {
  const StudentData({Key? key}) : super(key: key);

  @override
  State<StudentData> createState() => _StudentDataState();
}

class _StudentDataState extends State<StudentData> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DataBase'),
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
              height: 16,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (controller1.text.isNotEmpty &&
                      controller2.text.isNotEmpty) {
                    Student student;
                    var list = await DatabaseHelper.db.retriveAll();
                    if (list.isEmpty) {
                      student = Student(
                          id: 0,
                          name: controller1.text,
                          rollNo: controller2.text);
                    } else {
                      student = Student(
                          id: list.last.id + 1,
                          name: controller1.text,
                          rollNo: controller2.text);
                    }

                    await DatabaseHelper.db.insert(student);
                  }
                },
                child: const Text('Add Data')),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ShowDataList()));
                },
                child: const Text('Show Data')),
          ],
        ),
      ),
    );
  }
}

class ShowDataList extends StatefulWidget {
  const ShowDataList({Key? key}) : super(key: key);

  @override
  State<ShowDataList> createState() => _ShowDataListState();
}

class _ShowDataListState extends State<ShowDataList> {
  final controller = TextEditingController();
  final DatabaseHelper db = DatabaseHelper.db;
  Future getDataFromDatabase() async {
    return await db.retriveAll();
  }

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
            future: getDataFromDatabase(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 8),
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.shade400, width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12))),
                      child: TextField(
                        onChanged: (value) {},
                        controller: controller,
                        decoration: const InputDecoration(
                            hintText: 'Search', border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => UpdateData(
                                              id: snapshot.data[index].id,
                                              function: triggerFunction,
                                            ),
                                          ));
                                    },
                                    child: Text('Edit')),
                                title: Text(snapshot.data[index].name),
                                subtitle: Text(snapshot.data[index].rollNo),
                                trailing: IconButton(
                                    onPressed: () async {
                                      await db.delete(snapshot.data[index].id);
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.delete)),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              }
            }));
  }
}

class UpdateData extends StatefulWidget {
  UpdateData({Key? key, required this.id, required this.function})
      : super(key: key);
  int id;
  Function function;

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Data'),
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
              height: 16,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (controller1.text.isNotEmpty &&
                      controller2.text.isNotEmpty) {
                    Student student;

                    student = Student(
                        id: widget.id,
                        name: controller1.text,
                        rollNo: controller2.text);

                    await DatabaseHelper.db.update(student);
                    widget.function.call();
                    if (!mounted) {}
                    Navigator.pop(context);
                  }
                },
                child: const Text('Update Data')),
          ],
        ),
      ),
    );
  }
}

class DatabaseHelper {
  static late Database _database;
  final String _databaseName = 'name.db';

  DatabaseHelper._();
  static DatabaseHelper db = DatabaseHelper._();

  Future<Database> get database async {
    //  if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE Student(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, rollNo TEXT)
''');
  }

  Future<int> insert(Student data) async {
    final db = await database;
    return db.insert('Student', data.toMap());
  }

  Future<List<Student>> retriveAll() async {
    final db = await database;
    final List<Map<String, dynamic>> map = await db.query('Student');
    List<Student> list = List.generate(map.length, (i) {
      return Student(
          id: map[i]['id'], name: map[i]['name'], rollNo: map[i]['rollNo']);
    });

    return list;
  }

  Future<int> update(Student data) async {
    final db = await database;
    return db
        .update('Student', data.toMap(), where: 'id = ?', whereArgs: [data.id]);
  }

  Future delete(int id) async {
    final db = await database;
    await db.delete('Student', where: 'Id = ?', whereArgs: [id]);
  }
}

class Student {
  final int id;
  final String name;
  final String rollNo;

  const Student({
    required this.id,
    required this.name,
    required this.rollNo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'rollNo': rollNo,
    };
  }

  @override
  String toString() {
    return 'Student{id: $id, name: $name, rollNo: $rollNo}';
  }
}
