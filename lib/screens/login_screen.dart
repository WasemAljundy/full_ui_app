import 'package:flutter/material.dart';

import '../widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailTextEditingController;
  late TextEditingController _passwordTextEditingController;
  String? _emailErrorText;
  String? _passwordErrorText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'LOGIN',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome Back...',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const Text(
                  'Enter email & password',
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextField(
                  textEditingController: _emailTextEditingController,
                  prefixIcon: Icons.email,
                  suffixIcon: Icons.send,
                  labelText: 'Email',
                  hintText: 'wasem@gmail.com',
                  textInputType: TextInputType.emailAddress,
                  errorText: _emailErrorText,
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextField(
                  textEditingController: _passwordTextEditingController,
                  prefixIcon: Icons.lock,
                  suffixIcon: Icons.remove_red_eye,
                  labelText: 'Password',
                  obscureText: true,
                  errorText: _passwordErrorText,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () => performLogin(),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('LOGIN'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // SOLID - Single Responsibility
  void performLogin() {
    if (checkData()) {
      login();
    }
  }

  bool checkData() {
    if (_emailTextEditingController.text.isNotEmpty &&
        _passwordTextEditingController.text.isNotEmpty) {
      checkError();
      return true;
    } else {
      checkError();
      showMessage(message: 'Enter required fields !', error: true);
      return false;
    }
  }

  void checkError() {
    setState(() {
      _emailErrorText = _emailTextEditingController.text.isEmpty
          ? 'Enter email address'
          : null;
      _passwordErrorText =
          _passwordTextEditingController.text.isEmpty ? 'Enter password' : null;
    });
  }

  void login() {
    showMessage(message: 'Logged in Successfully');
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/main_screen');
    });
  }

  void showMessage({required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
      ),
    );
  }
}
