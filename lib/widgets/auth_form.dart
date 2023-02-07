import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
      {required String email,
      required String password,
      required String username,
      required bool isLogin,
      required BuildContext ctx}) submitAuthForm;
  const AuthForm({super.key, required this.submitAuthForm});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _loginMode = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      print(_userEmail);
      print(_userName);
      print(_userPassword);
      widget.submitAuthForm(
          email: _userEmail.trim(),
          password: _userPassword,
          username: _userName,
          isLogin: _loginMode,
          ctx: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      key: const ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          const InputDecoration(labelText: 'Email Address'),
                      onSaved: (newValue) {
                        _userEmail = newValue!;
                      },
                    ),
                    if (!_loginMode)
                      TextFormField(
                        key: const ValueKey('username'),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return 'Username needs to be at least 4 characters long';
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(labelText: 'Username'),
                        onSaved: (newValue) {
                          _userName = newValue!;
                        },
                      ),
                    TextFormField(
                      key: const ValueKey('password'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'Password needs to be at least 7 characters long';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      onSaved: (newValue) {
                        _userPassword = newValue!;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                        onPressed: _trySubmit,
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).colorScheme.primary)),
                        child: Text(_loginMode ? 'Login' : 'Sign up')),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _loginMode = !_loginMode;
                          });
                          _formKey.currentState!.reset();
                        },
                        child: Text(_loginMode
                            ? 'Create new account'
                            : 'Log in instead')),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
