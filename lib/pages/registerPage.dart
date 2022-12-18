import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gmao_app/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class registerPage extends StatefulWidget {
  const registerPage({Key? key}) : super(key: key);

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  var fullname;
  var phone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF062D6C),
                  Color(0xff0096ff),
                  Color(0xff4ec1f3),
                ]
            )
        ),
        child: Column(
          children: [
            /// Sign up & Welcome
            Container(
                padding: const EdgeInsets.only(top:80, bottom: 30, right: 20),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 40),),
                    SizedBox(height: 10),
                    Text('Welcome', style: TextStyle(color: Colors.white, fontSize: 18),),
                  ],
                )
            ),
            /// The rest
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.only(top: 80, right: 15, left: 15),
                child :Form(
                  key: _formKey,
                  child: Column(
                  children: [
                    /// Text Fields
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                blurRadius: 20,
                                spreadRadius: 5,
                                offset: const Offset(0, 10)
                            )
                          ]
                      ),
                      child: Column(
                        children:  [
                          TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Fullname',
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            validator: (firstname) {
                              if (firstname!.isEmpty) {
                                return 'Please enter your first name';
                              }
                              fullname = firstname;
                              return null;
                            },
                          ),
                          Divider(height: 10,),
                          TextFormField(

                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            validator: (emailValue) {
                              if (emailValue!.isEmpty) {
                                return 'Please enter email';
                              }
                              email = emailValue;
                              return null;
                            },
                          ),
                          Divider(height: 10,),
                          TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Phone',
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),

                            ),
                            validator: (phonenumber) {
                              if (phonenumber!.isEmpty) {
                                return 'Please enter phone number';
                              }
                              phone = phonenumber;
                              return null;
                            },
                          ),
                          Divider(height: 10,),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            validator: (passwordValue) {
                              if (passwordValue!.isEmpty) {
                                return 'Please enter some text';
                              }
                              password = passwordValue;
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    /// Sign Up
                    MaterialButton(
                      shape: const StadiumBorder(),
                      minWidth: 230,
                      height: 45,
                      color: Colors.blue[800],
                      child: const Text('SignUp', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 17),textAlign: TextAlign.center,),
                      onPressed: (){if (_formKey.currentState!.validate()) {
                             _register();}},
                    ),
                    const SizedBox(height: 30),




                  ],
                ),
                )

              ),
            ),
          ],
        ),
      ),
    );
  }
    void _register()async{

    var data = {
    'email' : email,
    'password': password,
    'phone': phone,
    'fullname': fullname,

    };

    var res = await Network().authData(data, '/register');
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
    }
    }
}
