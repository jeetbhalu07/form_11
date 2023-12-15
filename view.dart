import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_11/edit.dart';
import 'package:form_11/main.dart';

class Home1 extends StatefulWidget {
  const Home1({super.key});

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  List l = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get1();
  }

  get1() async {
    String qry = "select * from Test";
    l = await Home.database!.rawQuery(qry);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: l.length,
        itemBuilder: (context, index) {
          return ListTile(
            trailing: Wrap(
              children: [
                IconButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Edit(l[index]);
                  },));
                }, icon: Icon(Icons.edit))
              ],
            ),
            leading: Image.file(File(l[index]['image'])),
            title: Text("${l[index]['name']}"),
          );
        },
      ),
    );
  }
}
