import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input_field.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      try {
        await Provider.of<AuthProvider>(context, listen: false).signup(username, email, password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signup successful! Please login.')));
        Navigator.of(context).pushReplacementNamed('/login');
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signup failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signup')),
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
                controller: _emailController,
                labelText: 'Email',
                isPassword: false,
              ),
              CustomInputField(
                controller: _passwordController,
                labelText: 'Password',
                isPassword: true,
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Signup',
                onPressed: _signup,
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
