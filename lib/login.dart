import 'package:flutter/material.dart';
import 'package:hellofbase/authenticate.dart';
import 'package:hellofbase/register.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //declare
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(
          child: Column(
            children: [
              const Text('Login'),
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
              ElevatedButton(
                  onPressed: () {
                    //login
                    context.read<AuthenticationProvider>().login(
                        email: emailController.text,
                        password: passwordController.text);
                  },
                  child: const Text('Login')),
              TextButton(
                  onPressed: () {
                    //register
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context)=>Register()));
                  },
                  child: const Text('Register'))
            ],
          ),
        ),
      ),
    );
  }
}
