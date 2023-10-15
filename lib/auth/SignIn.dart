import 'package:flutter/material.dart';
import 'package:Rewind/services/FirebaseAuthService.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.onSignIn}) : super(key: key);

  final void Function() onSignIn;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;

  void _signIn() async {
      setState(() {
        _loading = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );
        widget.onSignIn();
      } catch (e) {
        setState(() {
          _loading = false;
        });
      }
  }

  void _signUp() async {
    setState(() {
      _loading = true;
    });
    try {
      await _auth.createUserWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
      widget.onSignIn();
    } catch (e) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: const Text('Sign In'),
            ),
            body: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _signIn,
                        child: const Text('Sign In'),
                      ),
                      ElevatedButton(
                        onPressed: _signUp,
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}