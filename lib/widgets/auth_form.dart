import 'package:flutter/material.dart';
import 'package:library_manager/constants.dart';
import 'package:library_manager/models/auth_data.dart';
import 'package:library_manager/widgets/menu_button.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthData authData) onSubmit;

  AuthForm(this.onSubmit);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final AuthData _authData = AuthData();

  void _submit() {
    print(_authData);
    FocusScope.of(context).unfocus();
    widget.onSubmit(_authData);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 48.0,
            ),
            if(_authData.isRegister)
            TextField(
              keyboardType: TextInputType.name,
              textAlign: TextAlign.center,
              onChanged: (value) {
                _authData.name = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your name',
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                _authData.email = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                _authData.password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your password',
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            MenuButton(
              onPressed: _submit,
              colour: Color(0xFFED891E),
              text: _authData.isLogin ? 'Log In' : 'Sign Up',
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _authData.toggleMode();
                });
              },
              child: Text(
                _authData.isLogin
                    ? 'Don\'t have an account? Sign Up'
                    : 'Already have an account? Log In',
                style: TextStyle(
                  color: Colors.black
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
