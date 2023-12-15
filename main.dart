import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_11/view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});
 static Database ?database;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  get()
  async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

// Delete the database
//     await deleteDatabase(path);

// open the database
     Home.database= await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, con TEXT,email TEXT,pass TEXT ,gender TEXT,city TEXT,image TEXT)');
        });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }
  String gen = "male";
  String city="Surat";
  TextEditingController t1= TextEditingController();
  TextEditingController t2= TextEditingController();
  TextEditingController t3= TextEditingController();
  TextEditingController t4= TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? image;
  bool t=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(controller: t1,),
            TextField(controller: t2,),
            TextField(controller: t3,),
            TextField(controller: t4,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Radio(
                  value: "male",
                  groupValue: gen,
                  onChanged: (value) {
                    gen = value!;
                    setState(() {
        
                    });
                  },
                ),
                Text("Male"),
                Radio(
                  value: "FeMale",
                  groupValue: gen,
                  onChanged: (value) {
                    gen = value!;
                    setState(() {
        
                    });
                  },
                ),
                Text("Female")
              ],
            ),
            DropdownButton(isExpanded: true,value: city,items: [
              DropdownMenuItem(child: Text("Surat"),value: "Surat",),
              DropdownMenuItem(child: Text("baroda"),value: "baroda",),
              DropdownMenuItem(child: Text("vapi"),value: "vapi",),
              DropdownMenuItem(child: Text("leh"),value: "leh",),
              DropdownMenuItem(child: Text("kashmir"),value: "kashmir",),
            ], onChanged: (value) {
                city=value!;
                setState(() {
        
                });
            },),
            Row(children: [
              Container(height: 200,width: 200,child: (t)?Image.file(File(image!.path)):null,),
              ElevatedButton(onPressed: () {
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(content: Text("please image upload"),actions: [
                      TextButton(onPressed: () async {
                        image = await picker.pickImage(source: ImageSource.camera);
                        t=true;
        
                        Navigator.pop(context);
                        setState(() {
        
                        });
                      }, child: Text("camera")),
                      TextButton(onPressed: () async {
                        image = await picker.pickImage(source: ImageSource.gallery);
                        t=true;
                        Navigator.pop(context);
                        setState(() {
        
                        });
        
                      }, child: Text("gallery")),
        
                    ],);
                  },);
              }, child: Text("Image")),
        
        
            ],),
            ElevatedButton(onPressed: () {
              String name=t1.text;
              String con=t2.text;
              String email=t3.text;
              String pass=t4.text;
              String qry="insert into Test values(NULL,'$name','$con','$email','$pass','$gen','$city','${image!.path}')";
              Home.database!.rawInsert(qry).then((value) {
                print(value);
              });
            }, child: Text("Submit")),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Home1();
              },));
            }, child: Text("Viee"))
          ],
        ),
      ),
    );
  }
}
