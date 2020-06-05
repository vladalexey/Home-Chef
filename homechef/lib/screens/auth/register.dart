import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:homechef/widgets/fade_animation.dart';
import 'package:homechef/widgets/helpers/auth-helpers.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final AuthHelper authHelper = AuthHelper();
  final storage = FlutterSecureStorage();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(text),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          FadeAnimation(
            1,
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text(
                      'Join us',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
                    child: Text(
                      '.',
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  FadeAnimation(
                    1,
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          // hintText: 'EMAIL',
                          // hintStyle: ,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange))),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  FadeAnimation(
                    1,
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          labelText: 'PASSWORD ',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange))),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  FadeAnimation(
                    1,
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          labelText: 'USERNAME ',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange))),
                    ),
                  ),
                  SizedBox(height: 50.0),
                  FadeAnimation(
                    1,
                    Container(
                        height: 50.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          color: Colors.orange,
                          elevation: 7.0,
                          hoverColor: Colors.orangeAccent,
                          onPressed: () async {
                            var username = _usernameController.text;
                            var password = _passwordController.text;
                            var email = _emailController.text;

                            if (username.length < 4)
                              displayDialog(context, "Invalid Username",
                                  "The username should be at least 4 characters long");
                            else if (password.length < 4)
                              displayDialog(context, "Invalid Password",
                                  "The password should be at least 4 characters long");
                            else {
                              var res = await authHelper
                                  .attemptSignUp(username, password, email)
                                  .timeout(const Duration(seconds: 5));

                              if (res == 200) {
                                displayDialog(context, "Success",
                                    "The user was created. Log in now.");
                              } else if (res == 409)
                                displayDialog(
                                    context,
                                    "That username is already registered",
                                    "Please try to sign up using another username or log in if you already have an account.");
                              else {
                                displayDialog(context, "Error",
                                    "An unknown error occurred.");
                              }
                            }
                          },
                          child: Center(
                            child: Text(
                              'REGISTER',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        )),
                  ),
                  SizedBox(height: 20.0),
                  FadeAnimation(
                    1,
                    Container(
                      height: 50.0,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(25.0)),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Center(
                            child: Text('Back',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat')),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ]));
  }
}
