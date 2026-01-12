import 'package:chat_app/Widget/constant.dart';
import 'package:chat_app/Widget/custom_button.dart';
import 'package:chat_app/Widget/custom_text_field.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  static String id = 'login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(kLogo),
                Transform.translate(
                  offset: const Offset(0, -120),
                  child: const Text(
                    'School Chat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pacifico',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CustomTextField(
                  hint: "Email",
                  onChanged: (value) {
                    email = value;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hint: "Password",
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(height: 15),
                CustomButton(
                  text: 'Login',
                  onPressed: () async {
                    if (email == null ||
                        email!.isEmpty ||
                        password == null ||
                        password!.isEmpty) {
                      if (context.mounted) {
                        showSnackBar(
                          context,
                          'Please enter email and password.',
                        );
                      }
                      return;
                    }
                    if (formkey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        UserCredential user = await loginUser();
                        if (context.mounted) {
                          Navigator.pushNamed(
                            context,
                            ChatPage.id,
                            arguments: email,
                          );
                        }
                      } catch (e) {
                        String errorMessage = 'An error occurred';
                        if (e is FirebaseAuthException) {
                          if (e.code == 'network-request-failed') {
                            errorMessage =
                                'Network error. Please check your internet connection.';
                          } else if (e.code == 'user-not-found') {
                            errorMessage = 'No user found for that email.';
                          } else if (e.code == 'wrong-password') {
                            errorMessage =
                                'Wrong password provided for that user.';
                          } else if (e.code == 'invalid-email') {
                            errorMessage = 'Invalid email address.';
                          } else if (e.code == 'invalid-credential') {
                            errorMessage = 'Invalid email or password.';
                          } else {
                            errorMessage =
                                e.message ?? 'Authentication failed.';
                          }
                        }
                        if (context.mounted) {
                          showSnackBar(context, errorMessage);
                        }
                      } finally {
                        if (mounted) {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Color(0xffC7EDE6)),
                        ),
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

  Future<UserCredential> loginUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    return user;
  }
}
