import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class ToDo extends StatefulWidget {
   ToDo({Key? key}) : super(key: key);

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  TextEditingController _noteController = TextEditingController();
  TextEditingController _updateController = TextEditingController(
      text: "");
  Box? notesBox;


 @override
 void initState() {
    notesBox = Hive.box('notes');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("ToDo Items")),

      ),
      backgroundColor: Colors.blueGrey,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

                Padding(

                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _noteController,
                      decoration: InputDecoration(
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        hintText: 'Add Title',
                      ),
                    ),
                ),
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 40,
                  width: 350,
                    child: ElevatedButton(
                      onPressed: () async{
                        final userInput = _noteController.text;
                        await userInput.length == 0 ? "" : notesBox!.add(userInput);
                        _noteController.clear();

                      },
                      child: Text("Add ToDo", style: TextStyle(
                        fontSize: 25,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),),)),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
                  color : Colors.green,
                  child: ValueListenableBuilder(
                    valueListenable: Hive.box('notes').listenable(),
                    builder: (context, box, widget){
                      return ListView.builder(
                        physics: ScrollPhysics(),
                          itemCount: notesBox!.keys.toList().length,
                          itemBuilder: (_, index){
                            return Card(
                                elevation: 10,
                                child: ListTile(
                                  title: Text(
                                    notesBox!.getAt(index).toString(),
                                  ),
                                  leading: Text("${index+1}"),


                                  trailing: SizedBox(
                                    width: 100,
                                    child: Row(
                                      children: [
                                        IconButton(onPressed: ()async{
                                          showDialog(
                                              context: context,
                                              builder: (_)
                                          {
                                            return AlertDialog(
                                              title: Center(child: Text("Update Now")),
                                              content: Padding(
                                                padding: const EdgeInsets.all(
                                                    8.0),
                                                child: Column(
                                                  children: [
                                                    TextField(
                                                      controller: _updateController,

                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () async{
                                                        final updateValue = _updateController.text;
                                                        notesBox!.putAt(index, updateValue);
                                                        Navigator.pop(context);
                                                        _updateController.clear();
                                                      },
                                                      child: Text("Update"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });

                                        },
                                            icon: Icon(Icons.edit, color: Colors.green,)),
                                        IconButton(onPressed: () async{
                                          await notesBox!.deleteAt(index);
                                          print('delete successfully');
                                        }, icon: Icon(Icons.delete, color: Colors.red,)),
                                      ],
                                    ),
                                  ),

                                ));
                          });
                    },
                  ),
                ),
            ),


          ],
        ),
      ),
    );
  }
}
