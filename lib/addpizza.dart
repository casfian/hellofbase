import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class AddPizza extends StatelessWidget {
  const AddPizza({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _namaController = TextEditingController();
    final _hargaController = TextEditingController();
    final _gambarController = TextEditingController();

    //guna Provider utk dapatkan user infor
    final firebaseuser = context.watch<User?>();

    if (firebaseuser != null) {
      print(firebaseuser.uid);
    }

    //1. initialise firebase
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    //2. Create
    void _create(
        String userid, String _nama, String _harga, String _gambar) async {
      try {
        await firestore.collection('pizza').doc().set({
          'userid': userid,
          'nama': _nama,
          'harga': _harga,
          'gambar': _gambar
        });
        Navigator.pop(context);
      } catch (e) {
        print(e); //kalau error print kat debug console
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Pizza'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(40, 30, 40, 10),
          child: Column(
            children: [
              Text('Nama'),
              TextField(
                controller: _namaController,
              ),
              Text('Harga'),
              TextField(
                controller: _hargaController,
              ),
              Text('Gambar'),
              TextField(
                controller: _gambarController,
              ),
              ElevatedButton(
                  onPressed: () {
                    //add
                    _create(firebaseuser!.uid, _namaController.text, _hargaController.text,
                        _gambarController.text);
                  },
                  child: const Text('Add Pizza'))
            ],
          ),
        ),
      ),
    );
  }
}
