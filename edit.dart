import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_11/main.dart';
import 'package:form_11/view.dart';
import 'package:image_picker/image_picker.dart';

class Edit extends StatefulWidget {
  Map ?l;
   Edit([this.l]);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      if(widget.l!=null)
        {
          t1.text=widget.l!['name'];
          t2.text=widget.l!['con'];
          t3.text=widget.l!['email'];
          t4.text=widget.l!['pass'];
          gen=widget.l!['gender'];
          city=widget.l!['city'];
          l=widget.l!['image'];
        }
  }
  @override
  String gen = "male";
  String l="";
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
              Container(height: 200,width: 200,child: (t)?Image.file(File(widget.l!['image'])):null,),
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
              String qry="update Test set name='$name',con='$con',email='$email',pass='$pass',gender='$gen',city='$city',image='${image!.path}'";
              Home.database!.rawUpdate(qry);
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
