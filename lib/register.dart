import 'package:flutter/material.dart';
import 'package:hellofbase/authenticate.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);

  //declare
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Register'),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'password',
                  prefixIcon: Icon(Icons.security),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: repasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Re-password',
                  prefixIcon: Icon(Icons.security),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  //register
                  if ((emailController.text.isNotEmpty) &&
                      (passwordController.text == repasswordController.text)) {
                    //register
                    print('can register');
                    context.read<AuthenticationProvider>().register(
                        email: emailController.text,
                        password: passwordController.text);
                    Navigator.pop(context);
                  } else {
                    print('Not Same or one of the field is empty');
                  }
                },
                child: Text('Register'))
          ],
        ),
      ),
    );
  }
}
