import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:management/constant/number_ext.dart';
import 'package:management/constant/theme/light.dart';
import 'package:management/entities/user.dart';
import 'package:management/pages/table.dart';
import 'package:management/utils/dialog.dart';
import 'package:management/utils/setup.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: LightThemeData.theme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Isar isar;
  final loading = true.vn;
  final isInserting = false.vn;

  var users = <User>[].vn;

  @override
  void initState() {
    init();
    super.initState();
  }

  addUser(Map data) async {
    isInserting.value = true;

    final newUser = User(
      fname: data['fname'] ?? "",
      lname: data['lname'] ?? "",
      pcName: data['pcName'] ?? "",
      pcSN: data['pcSN'] ?? "",
      phoneNumber: data['number'] ?? "",
      uuid: const Uuid().v4(),
    );

    await isar.writeTxn(() async {
      await isar.users.put(newUser);
    });

    isInserting.value = false;

    getUsers();
  }

  init() async {
    loading.value = true;
    isar = await setupDB();
    loading.value = false;
    getUsers();
  }

  Future<void> getUsers() async {
    final todosCollection = isar.users;
    users.value = await todosCollection.where().findAll();
  }

  final headers = [
    "First Name",
    "Last Name",
    "Phone Number",
    "Computer Name",
    "Computer Serial Number",
    "UUID",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Client Management"),
      ),
      body: ValueListenableBuilder(
        valueListenable: loading,
        builder: (context, value, child) {
          return value
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    12.height,
                    users.watch(
                      onData: (value) {
                        return DataTableDemo(
                          users: users.value,
                          onHandleSearch: onHandleSearch,
                          handleDelete: handleDelete,
                        );
                      },
                    ),
                  ],
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showNDialog(
            context,
            (data) {
              addUser(data);
            },
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  onHandleSearch(String searchText) async {
    final todosCollection = isar.users;
    users.value =
        await todosCollection.filter().uuidContains(searchText).findAll();
  }

  handleDelete(String id) async {
    await isar.writeTxn(() async {
      final success = await isar.users.filter().uuidEqualTo(id).deleteAll();
      print('Recipe deleted: $success');
    });

    getUsers();
  }
}
