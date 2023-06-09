import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CreateUser extends StatefulWidget {
  CreateUser({Key? key}) : super(key: key);

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {

  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  String id = "";
  String createdAt = "";

  String first = "";
  String second = "";

  newuser() async {
    await http.post(
      Uri.parse("https://reqres.in/api/users"),
      headers: <String, String>{
        'name': nameController.text.toString(),
        'job': jobController.text.toString()
      },
    ).then((value) {
      Map result = jsonDecode(value.body);
      print(value.body);
      setState(() {
        id = result['id'];
        createdAt = result['createdAt'];
        first = "ID: ";
        second = "CREATED AT: ";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(
          "Create New User",
          style: GoogleFonts.lato(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Text(first + id),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(first,
                    style: GoogleFonts.lato(fontSize: 20,color: Colors.redAccent),
                    ),
                   const SizedBox(width: 5,),
                    Text(id,
                    style: GoogleFonts.lato(fontSize: 25,color: Colors.blueAccent),
                    )
                  ],
                ),
                const SizedBox(
                  height: 45,
                ),
                  
                // Text(second + createdAt),
                  
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(second,style: GoogleFonts.lato(fontSize: 15,color: Colors.redAccent),),
                  
                  ],
                ),
                const  SizedBox(height: 5,),
                    Text(createdAt,style: GoogleFonts.lato(fontSize: 20,color: Colors.blueAccent),),
               const SizedBox(height: 30,),
                Card(
                  elevation: 20,
                  child: TextField(
                    controller: nameController,
                    decoration:const InputDecoration(hintText: "  Enter Name"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 20,
                  child: TextField(
                    controller: jobController,
                    decoration:const InputDecoration(hintText: "  Job"),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                CupertinoButton(
                  color: Colors.deepPurple,
                  child: Text(
                    "Create User",
                    style: GoogleFonts.lato(),
                  ),
                  onPressed: () {
                    newuser();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
