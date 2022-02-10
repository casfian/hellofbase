import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hellofbase/home.dart';
import 'package:provider/provider.dart';
import 'package:hellofbase/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) =>
                context.read<AuthenticationProvider>().authState,
            initialData: null)
      ],
      child: const MaterialApp(
        title: 'Material App',
        home: Home(),
      ),
    );
  }
}
