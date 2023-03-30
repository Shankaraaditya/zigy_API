// import 'dart:convert';

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List images = [];
  @override
  void initState() {
    super.initState();
    fetchapi();
  }

  fetchapi() async {
    await http
        .get(
      Uri.parse("https://reqres.in/api/users?page=2"),
    ).then((value) {
        
      Map result = jsonDecode(value.body);
      print(value.body);
      print(value.statusCode);
      setState(() {
        images = result['data'];
      });
      // print(value.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text("Zigy App" , style: GoogleFonts.lato(),),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: PageView.builder(
                itemCount: images.length,
                scrollDirection: Axis.vertical,    
                itemBuilder: (context, index) {
                  return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Card(
                          elevation: 30,
                          shadowColor: Colors.black,
                          child: Container(
                            // height: 100,
                            // color: Colors.white,
                            // child: Image.network(
                            //   images[index]['avatar'],
                            //   fit: BoxFit.cover,
                            // ),
                            child: Column(
                              children: [
                                Padding(
                                  padding:const EdgeInsets.only(top: 20),
                                  child: CircleAvatar(
                                    radius: 100,
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                      images[index]['avatar']
                                    )
                                  )
                                ),

                                const SizedBox(height: 30,),

                                // Text("ID: " + images[index]['id'].toString() )
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("ID :  ",style: GoogleFonts.lato(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 33, 166, 243)
                                      ),
                                    ),
                                    Text(images[index]['id'].toString(),
                                    style: GoogleFonts.lato(fontSize: 48,
                                    color: Colors.red  
                                    ),
                                  ),


                                  ],
                                ),

                                 const SizedBox(height: 20,),

                                 Text(images[index]['email'].toString(),
                                 style: GoogleFonts.lato(
                                  fontSize: 25,
                                  color: Colors.blue
                                 ),
                                 ),

                                 const SizedBox(height: 20,),

                                 Text(images[index]['first_name'].toString()+ " "+
                                      images[index]['last_name'].toString() ,
                                 style: GoogleFonts.lato(
                                 fontSize: 20
                                 ),
                                 )



                                

                              ],
                            ),
                          ),
                        ),
                      );
                }),
          )),
         
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
       items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
                    

                    

        ],
      ),
    );
  }
}
  