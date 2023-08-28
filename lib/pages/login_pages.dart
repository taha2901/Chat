import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/register_page.dart';

import '../components/custom_buttom.dart';
import '../components/custom_text_field.dart';
import '../helper/show_snak_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? passWord;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: KprimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 100,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                          fontFamily: 'pacifico',
                          fontSize: 32,
                          color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 75,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  onChange: (data) {
                    email = data;
                  },
                  hint: "Email",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onChange: (data) {
                    passWord = data;
                  },
                  obsecure: true,
                  hint: "Pass Word",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await loginUser();
                        Navigator.pushNamed(context, ChatPage.id , arguments: email);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'weak-password') {
                          showSnakBar(context, 'Weak PassWord');
                        } else if (ex.code == 'email-already-in-use') {
                          showSnakBar(context, 'Email Already Exist');
                        }

                        showSnakBar(context, "Succes");
                        print(ex);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(ex.toString()),
                          ),
                        );
                      } catch (ex) {
                        showSnakBar(context, "Error");
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  color: Colors.white,
                  text: "LOGIN",
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don\’t have an account ?",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: const Text(
                        "  Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: passWord!);
  }
}
