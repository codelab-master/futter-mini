import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/screen/add_screen.dart';
import 'package:todo/screen/list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    return openDatabase(
      join(databasesPath, 'todo.db'),
      version: 1,
      onCreate: (db, version) async {
        return db.execute('''
          CREATE TABLE todo (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            created_at TEXT NOT NULL,
            updated_at TEXT NOT NULL
          )
        ''');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _initDatabase();
    return MaterialApp(
      title: 'To-Do App',
      home: const ListScreen(appBarTitle: 'To-Do List'),
      initialRoute: '/',
      routes: {
        '/': (context) => const ListScreen(appBarTitle: 'To-Do List'),
        '/add': (context) => const AddScreen(appBarTitle: 'Add To-Do'),
      },
    );
  }
}
