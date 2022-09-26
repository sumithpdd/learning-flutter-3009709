// ignore_for_file: prefer_const_constructors

import 'dart:js';

import 'package:chat_app/chat_page.dart';
import 'package:chat_app/utils/spaces.dart';
import 'package:chat_app/utils/textfield_styles.dart';
import 'package:chat_app/widgets/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:social_media_buttons/social_media_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  void loginUser(context) {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      print(userNameController.value.text);
      print(passwordController.value.text);
      // Navigator.pushNamed(context, "/chat",
      //     arguments: userNameController.value.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ChatPage(
                  userName: userNameController.value.text,
                )),
      );
      print('Login Successful');
    } else {
      print('Login Not Successful');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Let's sign you in!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5),
              ),
              const Text(
                "Welcome back! \n You've been missed!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage('assets/illustration.png')),
                    borderRadius: BorderRadius.circular(24)),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    LoginTextField(
                      hintText: "Enter your UserName",
                      validator: ((value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            value.length < 5) {
                          return "Your username should be more than 5 characters";
                        } else if (value != null && value.isEmpty) {
                          return "Please type your username";
                        }
                        return null;
                      }),
                      textEditingController: userNameController,
                    ),
                    verticalSpacing(24),
                    LoginTextField(
                      textEditingController: passwordController,
                      obscureText: true,
                      hintText: 'Enter your password',
                    ),
                  ],
                ),
              ),
              verticalSpacing(24),
              ElevatedButton(
                  onPressed: () => {loginUser(context)},
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  )),
              //   OutlinedButton(onPressed: () {}, child: FlutterLogo()),
              TextButton(
                  onPressed: () async {
                    if (!await launchUrl(
                        Uri.parse('https://www.sumithpd.com'))) {
                      throw 'Could not launch website';
                    }
                  },
                  child: Text('www.sumithpd.com')),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialMediaButton(
                    url: 'https://twitter.com/sumithpdd',
                    iconData: SocialMediaIcons.twitter,
                  ),
                  SocialMediaButton(
                    url: 'https://linkedin.com/in/sumithdamodaran',
                    iconData: SocialMediaIcons.linkedin,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
