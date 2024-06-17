import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;
      try {
        await Provider.of<AuthProvider>(context, listen: false).login(username, password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login successful!')));
        Navigator.of(context).pushReplacementNamed('/home');
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              CustomInputField(
                controller: _usernameController,
                labelText: 'Username',
                isPassword: false,
              ),
              CustomInputField(
                controller: _passwordController,
                labelText: 'Password',
                isPassword: true,
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Login',
                onPressed: _login,
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/signup');
                },
                child: Text('Don\'t have an account? Signup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
