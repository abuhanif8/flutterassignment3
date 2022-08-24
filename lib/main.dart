import 'package:flutter/material.dart';
import 'package:flutterassignment3/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

 Box box=  await Hive.openBox('notes');
  // var box = Hive.box('myBox');
  // box.put('name', 'Hanif');
  // var name = box.get('name');
  // print('Name : $name');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo Project',

      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple,
          titleTextStyle: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,

          ),
        ),

        ),
      home: ToDo(),
    );
  }
}

