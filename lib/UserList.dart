import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _UserListState createState() => _UserListState();
}
class _UserListState extends State<UserList> {
  void initState() {
    super.initState();
    getData();
  }
  var Data;
  void getData() async {
    try {
      var response = await get(
          Uri.parse('https://reqres.in/api/users?page=2'));
      var jsonData= jsonDecode(response.body);
      var newData=jsonData['data'];

      setState(() {
        Data=newData;
      });

    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GeeksForGeeks',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: Data==null?0:Data.length,
          itemBuilder: (BuildContext context, int index) {
            final listDAta = Data[index];
            return Card(
                child: ListTile(

                  title:Text(listDAta['email']),
                 // title: Text(listData[index]['first_name']),
                 // subtitle: Text(listData[index]['last_name']),
                ));
          }),
    );
  }
}