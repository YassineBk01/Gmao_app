import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gmao_app/pages/gestionInterventionPage.dart';
import 'package:gmao_app/services/api.dart';
import 'package:gmao_app/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'registerPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Container(

        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.blue.shade900,
                  Colors.blue.shade500,
                  Colors.blue.shade400,
                ]
            )
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            // #login, #welcome
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const[
                  Text("Login",style: TextStyle(color: Colors.white,fontSize: 40),),
                  SizedBox(height: 10,),
                  Text("Welcome Back",style: TextStyle(color: Colors.white,fontSize: 20),),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60)),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        const SizedBox(height: 60,),


                        Form(
                          key: _formKey,
                        child : Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const[
                                    BoxShadow(
                                        color: Color.fromRGBO(171, 171, 171, .7),blurRadius: 20,offset: Offset(0,10)),
                                  ],
                                ),


                                child: Column(
                                  children: [


                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                                      ),
                                      child:  TextFormField(
                                        decoration: InputDecoration(
                                            hintText: "Email",
                                            hintStyle: TextStyle(color: Colors.grey),
                                            border: InputBorder.none
                                        ),
                                        validator: (emailValue) {
                                          if (emailValue!.isEmpty) {
                                            return 'Please enter email';
                                          }
                                          email = emailValue;
                                          return null;
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                                      ),
                                      child: TextFormField(
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            hintText: "Password",
                                            hintStyle: TextStyle(color: Colors.grey),
                                            border: InputBorder.none
                                        ),
                                        validator: (passwordValue) {
                                          if (passwordValue!.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          password = passwordValue;
                                          return null;
                                        },
                                      ),
                                    ),

                                  ],
                                )




                            ),
                            const SizedBox(height: 40),
                            FlatButton(
                              onPressed: () {
                                /*Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => ManageInterventions()));*/
                                if (_formKey.currentState!.validate()) {
                                  _login();
                                }
                              },
                                child: Container(
                                height: 50,
                                margin: const EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.blue[800]
                                ),
                                child: const Center(
                                  child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 17),),
                                ),
                              ),)

                          ],
                        )

                  ),

                        const SizedBox(height: 30),

                        /*InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => registerPage()));
                          },
                          child: Text(
                            'Create new Account ?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),*/


                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _login() async {

    var data = {
      'email': email,
      'password': password
    };

    var res = await Network().authData(data, '/login');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      /*Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => HomePageAdmin()
        ),
      );*/
    }else{
      Utils.showSnackBar(
          context,
          "Error, try Again!");
    }


  }
}
