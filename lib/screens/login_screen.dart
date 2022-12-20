import 'package:fl_product/providers/login_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fl_product/ui/input_decorations.dart';
import 'package:fl_product/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 220),
            CardContainer(
              title: 'Login',
              child: ChangeNotifierProvider(
                create: (_) => LoginFromProvider(),
                child: _LoginForm(),
              ),
            ),
            const SizedBox(
              height: 90,
            ),
            const Text(
              'New Account',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    ));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFromProvider>(context);
    return SingleChildScrollView(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'example@example.com',
                  labelText: 'email',
                  prefixIcon: Icons.alternate_email_sharp),
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '') ? null : 'Ivalid Email';
              },
              onChanged: (value) => loginForm.email = value,
            ),
            const SizedBox(height: 20),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '*****',
                  labelText: 'Password',
                  prefixIcon: Icons.lock_outline_sharp),
              validator: ((value) {
                if (value != null && value.length >= 6) return null;
                return 'passsword must be 6 character';
              }),
              onChanged: (value) => loginForm.password = value,
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
                color: Colors.deepPurple,
                disabledColor: Colors.grey,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus(); //Disable Keyboard

                        if (!loginForm.isValidForm()) return;

                        loginForm.isLoading = true;

                        await Future.delayed(
                            const Duration(seconds: 2)); // add delay

                        Navigator.pushReplacementNamed(context, 'home');
                      },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: Text(
                    loginForm.isLoading ? ' Loading' : 'Login',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
