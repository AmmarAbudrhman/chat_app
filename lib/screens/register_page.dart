import 'package:chat_app/Widget/constant.dart';
import 'package:chat_app/Widget/custom_button.dart';
import 'package:chat_app/Widget/custom_text_field.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  static String id = 'register_page';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                Image.asset('assets/images/scholar.png'),
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
                    'Register',
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
                  text: 'Register',
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
                        UserCredential user = await registerUser();
                      } catch (e) {
                        String errorMessage = 'An error occurred';
                        if (e is FirebaseAuthException) {
                          if (e.code == 'network-request-failed') {
                            errorMessage =
                                'Network error. Please check your internet connection.';
                          } else if (e.code == 'email-already-in-use') {
                            errorMessage = 'This email is already registered.';
                          } else if (e.code == 'weak-password') {
                            errorMessage = 'Password is too weak.';
                          } else if (e.code == 'invalid-email') {
                            errorMessage = 'Invalid email address.';
                          } else {
                            errorMessage =
                                e.message ?? 'Authentication failed.';
                          }
                        }
                        if (context.mounted) {
                          showSnackBar(context, errorMessage);
                        }
                      }
                    }
                    setState(() {
                      isLoading = false;
                      Navigator.pop(context);
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Login',
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

  Future<UserCredential> registerUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    return user;
  }
}
