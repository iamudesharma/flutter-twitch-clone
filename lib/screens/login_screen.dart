import 'package:flutter/material.dart';
import 'package:twitch_clone_tutorial/resources/auth_methods.dart';
import 'package:twitch_clone_tutorial/responsive/responsive.dart';
import 'package:twitch_clone_tutorial/screens/home_screen.dart';
import 'package:twitch_clone_tutorial/screens/signup_screen.dart';
import 'package:twitch_clone_tutorial/widgets/custom_button.dart';
import 'package:twitch_clone_tutorial/widgets/custom_textfield.dart';
import 'package:twitch_clone_tutorial/widgets/loading_indicator.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();
  bool _isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  loginUser() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      bool res = await _authMethods.loginUser(
        context,
        _emailController.text,
        _passwordController.text,
      );
      setState(() {
        _isLoading = false;
      });
      if (res) {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Login',
          ),
        ),
        body: _isLoading
            ? const LoadingIndicator()
            : Responsive(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.1),
                          const Text(
                            'Email',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: CustomTextField(
                              controller: _emailController,
                              validator: (value) {
                                if (value!.isValidEmail()) {
                                  return null;
                                } else {
                                  // return null;
                                  return "Please Enter the Valid Email";
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: CustomTextField(
                              controller: _passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This Field is required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(onTap: loginUser, text: 'Log In'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
