import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'data from api',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //create fun to get user data from api
  getUserData() async{
var response = await http.get
  (Uri.https
  ('jsonplaceholder.typicode.com',
    'users'));
    var jsonDta =jsonDecode(response.body);
    List<User>users=[];
    //for in ex
    for (var u in jsonDta){
      User user= User(u['name'], u['email'], u['username']);
      users.add(user);

    }
    print(users.length);
    return users;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(
          'user data'
        ),
      ),
      body: Container(
        child: Card(
          child: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot){
              if(snapshot.data==null)
              {
                return Container(
                  child: Center(
                    child: Text('loading..'),
                  ),
                );
              }else{
                return ListView.builder(
                    itemCount: (snapshot.data.length),
                    itemBuilder: (context , i){
                      // i= index
                      return ListTile(
                        title: Text(snapshot.data[i].name),
                        subtitle: Text(snapshot.data[i].userName),

                        trailing: Text(snapshot.data[i].email),

                      );
                    }
                );
              }
            },
          ),
        ),
      ),

    );

  }



  }
class User {
  final String name,email,userName;
  User(this.name, this.email, this.userName);
}