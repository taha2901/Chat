import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constants.dart';

import '../components/custom_buttom.dart';
import '../components/custom_text_field.dart';
import '../helper/show_snak_bar.dart';
import 'chat_page.dart';

class RegisterPage extends StatefulWidget {
  static String id = 'RegisterPage';
  RegisterPage({Key? key}) : super(key: key);
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  
  String? Email;

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
                      'REGISTER',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  onChange: (data) {
                    Email = data;
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
                        await registerUser();
                        Navigator.pushNamed(context, ChatPage.id);
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
                  text: "Register",
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
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "  Register",
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



  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: Email!, password: passWord!);
  }
}
