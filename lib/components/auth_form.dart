// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:chat/components/user_image_picker.dart';
import 'package:chat/model/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final Function(AuthFormData) onSubmit;

  const AuthForm({required this.onSubmit});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _hanleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.image == null && _formData.isSignup) {
      return _showError('Imagem não selecionada. ');
    }
    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    final larguraForm = MediaQuery.of(context).size.width * 0.5;
    return Container(
      width: larguraForm,
      child: Card(
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_formData.isSignup)
                  UserImagePicker(onImagePick: _hanleImagePick),
                if (_formData.isSignup)
                  TextFormField(
                    key: ValueKey('name'),
                    initialValue: _formData.name,
                    onChanged: (name) => _formData.name = name,
                    decoration: InputDecoration(labelText: 'Nome'),
                    validator: (_name) {
                      final name = _name ?? '';
                      if (name.trim().length < 3) {
                        return 'O campo Nome deve conter no mínimo 3 caracteres. ';
                      }
                      return null;
                    },
                  ),
                TextFormField(
                  key: ValueKey('email'),
                  initialValue: _formData.email,
                  onChanged: (email) => _formData.email = email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'E-mail'),
                  validator: (_email) {
                    final email = _email ?? '';
                    if (email.trim().isEmpty ||
                        !email.contains('@') ||
                        !email.contains('.com')) {
                      return 'Informe um e-mail válido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  key: ValueKey('password'),
                  initialValue: _formData.password,
                  onChanged: (password) => _formData.password = password,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Senha'),
                  validator: (_password) {
                    final password = _password ?? '';
                    if (password.isEmpty || password.length < 6) {
                      return 'Informe uma senha Válida, no mínimo 6 caracteres.';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(
                    _formData.isLogin ? 'Entrar' : 'Cadastrar?',
                  ),
                ),
                TextButton(
                  child: Text(_formData.isLogin
                      ? 'Criar uma nova conta?'
                      : 'Já possui cont?'),
                  onPressed: () {
                    setState(() {
                      _formData.toggleAuthMode();
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}