import 'package:collage_me/core/auth_manager.dart';
import 'package:collage_me/core/cache_manager.dart';
import 'package:collage_me/resources/color_manager.dart';
import 'package:collage_me/views/login_screen/onboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rePassword = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController userName = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FormType _formType = FormType.login;
  LoginViewModel _viewModel = Get.put(LoginViewModel());
  bool _isRegistering = false; // Added variable
  bool _isLoggingIn = false; // Added variable
  AuthenticationManager langCache = Get.put(AuthenticationManager());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        leading: PopupMenuButton<int>(
          icon: Icon(Icons.language),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              // row with 2 children
              child: Text(
                "Tr",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            PopupMenuItem(
              value: 2,
              // row with two children
              child: Text(
                "En",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ],
          onSelected: (value) {
            if (value == 1) {
              langCache.saveLanguage("tr");
              langCache.changeLang("tr");
            } else if (value == 2) {
              langCache.saveLanguage("en");
              langCache.changeLang("en");
            }
          },
        ),
        title: Text(
          "language".tr,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 150,
                  child: FittedBox(
                    child: Image(
                      image: AssetImage("assets/images/splash.png"),
                    ),
                  ),
                ),
                _formType == FormType.login ? loginForm() : registerForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form loginForm() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: Theme.of(context).textTheme.labelSmall,
            controller: email,
            validator: (value) {
              return (value == null || value.isEmpty)
                  ? 'Please Enter Email'
                  : null;
            },
            decoration: inputDecoration('E-mail', Icons.person),
          ),
          SizedBox(
            height: 24,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.labelSmall,
            validator: (value) {
              return (value == null || value.isEmpty)
                  ? 'Please Enter Password'
                  : null;
            },
            controller: password,
            decoration: inputDecoration('Password', Icons.lock),
          ),
          SizedBox(
            height: 32,
          ),
          ElevatedButton(
            onPressed: _isLoggingIn ? null : () => login(),
            child: _isLoggingIn
                ? CircularProgressIndicator() // Show loading indicator
                : Text('login'.tr),
          ),
          SizedBox(height: 32),
          TextButton(
            onPressed: () {
              setState(() {
                _formType = FormType.register;
              });
            },
            child: Text('register'.tr),
          ),
        ],
      ),
    );
  }

  Form registerForm() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              style: Theme.of(context).textTheme.labelSmall,
              controller: userName,
              decoration: inputDecoration('Username', Icons.person),
            ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              style: Theme.of(context).textTheme.labelSmall,
              controller: email,
              decoration: inputDecoration('E-mail', Icons.person),
            ),
            SizedBox(
              height: 12,
            ),
            TextFormField(
              style: Theme.of(context).textTheme.labelSmall,
              controller: password,
              decoration: inputDecoration('Password', Icons.lock),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: rePassword,
              style: Theme.of(context).textTheme.labelSmall,
              decoration: inputDecoration('Retype Password', Icons.lock),
            ),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: _isRegistering ? null : () => registerUser(),
              child: _isRegistering
                  ? CircularProgressIndicator() // Show loading indicator
                  : Text('register'.tr),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _formType = FormType.login;
                  });
                },
                child: Text('back'.tr),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isRegistering = true; // Start registration process
      });

      await _viewModel.registerUser(
        email.text,
        password.text,
        rePassword.text,
        userName.text,
      );

      setState(() {
        _isRegistering = false; // End registration process
        _formType = FormType.login; // Switch back to login form
      });
    }
  }

  Future<void> login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoggingIn = true; // Start login process
      });

      await _viewModel.loginUser(email.text, password.text);

      setState(() {
        _isLoggingIn = false; // End login process
        _formType = FormType.login; // Switch back to login form
      });
      Get.to(const OnBoard());
    }
  }
}

InputDecoration inputDecoration(
  String labelText,
  IconData iconData, {
  String? prefix,
  String? helperText,
}) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    helperText: helperText,
    labelText: labelText,
    labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
    fillColor: ColorManager.base,
    filled: true,
    prefixText: prefix,
    prefixIcon: Icon(
      iconData,
      size: 20,
    ),
    prefixIconConstraints: BoxConstraints(minWidth: 60),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.black),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.black),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.black),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.black),
    ),
  );
}

enum FormType { login, register }
