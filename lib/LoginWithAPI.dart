//import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';


class  LoginWithAPI extends StatefulWidget {
  const LoginWithAPI({Key? key}) : super(key: key);

  @override
  _LoginWithAPIState createState() => _LoginWithAPIState();
}

class _LoginWithAPIState extends State<LoginWithAPI> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var listData=[];

  void login(String email , password) async {

    try{
      if(email==null|| email.length==0){
        Fluttertoast.showToast(
            msg: "Email is Required field",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return;
      }else if(password==null||password.length==0){
        Fluttertoast.showToast(
            msg: "Password is Required field",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return;
      }

      Response response = await post(
          Uri.parse('https://reqres.in/api/register'),
         // body: {
         //   'email' : 'eve.holt@reqres.in',
         //   'password' : 'cityslicka'
         // }
          body: {
            'email' : email,
            'password' : password
             }
      );

      if(response.statusCode == 200){

        var data = jsonDecode(response.body.toString());


        Fluttertoast.showToast(
            msg: "Login Successful with mentioned email "+email,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );


      }else {
        Fluttertoast.showToast(
            msg: "Enter Proper registered email "+email,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

      }
    }catch(e){
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    emailController.text="eve.holt@reqres.in";
   passwordController.text="cityslicka";



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Api'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(

              controller: emailController,

              decoration: InputDecoration(
                  hintText: 'Enter Email',
                labelText: 'Email',
                border: OutlineInputBorder(),

              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: 'Enter Password',
                labelText: 'Password',
                border: OutlineInputBorder(),

              ),
              maxLength: 4,
            ),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                login(emailController.text.toString(), passwordController.text.toString());
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text('Login',
                  style: TextStyle(color: Colors.white),
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}