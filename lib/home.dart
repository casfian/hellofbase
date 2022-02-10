import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hellofbase/listgambar.dart';
import 'package:hellofbase/pizza.dart';
import 'package:hellofbase/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //1. initialise Firebase
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //2. create all CRUD functions for Firebase
  //create
  void _create() async {
    try {
      await firestore
          .collection('pizza')
          .doc('pizza')
          .set({'nama': 'Pizza 1', 'harga': '12.00', 'gambar': 'pizza1.png'});
    } catch (e) {
      print(e); //kalau error print kat debug console
    }
  }

  //read
  void _read() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot = await firestore.collection('pizza').doc('pizza').get();
      print(documentSnapshot.data());
    } catch (e) {
      print(e);
    }
  }

  //update
  void _update() async {
    try {
      await firestore.collection('pizza').doc('pizza').update(
          {'nama': 'Pizza 2', 'harga': '15.00', 'gambar': 'pizza2.png'});
    } catch (e) {
      print(e); //kalau error print kat debug console
    }
  }

  //delete
  void _delete() async {
    try {
      await firestore.collection('pizza').doc('pizza').delete();
    } catch (e) {
      print(e); //kalau error print kat debug console
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HelloFBase App'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            const Text('Hello Firebase'),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    //create
                    _create();
                  },
                  child: const Text('Create Data')),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    //read
                    _read();
                  },
                  child: const Text('Read Data')),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    //update
                    _update();
                  },
                  child: const Text('Update Data')),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    //delete
                    _delete();
                  },
                  child: const Text('Delete Data')),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    //nav
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Pizza()));
                  },
                  child: const Text('Goto Data')),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    //nav
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ListGambar()));
                  },
                  child: const Text('List Gambar')),
            ),
          ],
        ),
      ),
    );
  }
}
