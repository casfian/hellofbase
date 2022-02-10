import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hellofbase/addpizza.dart';
import 'package:hellofbase/authenticate.dart';
import 'package:hellofbase/login.dart';
import 'package:hellofbase/updatepizza.dart';

import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

//class Pizza create to route to Authentication
//create authentication to check login or not
class Pizza extends StatelessWidget {
  const Pizza({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      //if user is login, then goto PizzaLogin
      return const PizzaLogin();
    }
    //if not then show Login
    return Login();
  }
}

//if
class PizzaLogin extends StatefulWidget {
  const PizzaLogin({Key? key}) : super(key: key);

  @override
  State<PizzaLogin> createState() => _PizzaLoginState();
}

class _PizzaLoginState extends State<PizzaLogin> {
  //1. initialise firestore
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    //guna Provider utk dapatkan user infor
    final firebaseuser = context.watch<User?>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizza'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddPizza()));
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () {
                //logout
                context.read<AuthenticationProvider>().logout();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        initialData: null,
        stream: FirebaseFirestore.instance
            .collection('pizza')
            .where('userid', isEqualTo: firebaseuser!.uid.toString())
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            //show data if no error
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                //casting
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return ListTile(
                  leading: IconButton(
                      onPressed: () {
                        //update
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdatePizza(
                                      selectdocid: document.id,
                                      selectnama: data['nama'],
                                      selectharga: data['harga'],
                                      selectgambar: data['gambar'],
                                    )));
                      },
                      icon: const Icon(Icons.edit)),
                  title: Text(data['nama']),
                  subtitle:
                      Text('RM ${data['harga']} , Gambar: ${data['gambar']}'),
                  trailing: IconButton(
                      onPressed: () async {
                        //delete
                        try {
                          await firebaseFirestore
                              .collection('pizza')
                              .doc(document.id)
                              .delete();
                        } catch (e) {
                          print(e); //kalau error print kat debug console
                        }
                      },
                      icon: const Icon(Icons.delete)),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
