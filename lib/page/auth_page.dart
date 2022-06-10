import 'package:chat/components/auth_form.dart';
import 'package:chat/core/model/auth_form_data.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  void _handleSubmit(AuthFormData formData) {
    try {
      setState(() => _isLoading = true);
      if (formData.isLogin) {
        //login
        AuthServices().login(
          formData.email,
          formData.password,
        );
      } else {
        //sinup

        AuthServices().signup(
          formData.name,
          formData.email,
          formData.password,
          formData.image,
        );
      }
    } catch (e) {
      //tratar erro
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: AuthForm(onSubmit: _handleSubmit),
            ),
          ),
          if (_isLoading)
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
