import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class UpdatePizza extends StatelessWidget {
  UpdatePizza(
      {Key? key,
      required this.selectdocid,
      required this.selectnama,
      required this.selectharga,
      required this.selectgambar})
      : super(key: key);

  String selectdocid;
  String selectnama;
  String selectharga;
  String selectgambar;

  @override
  Widget build(BuildContext context) {
    //guna Provider utk dapatkan user infor
    final firebaseuser = context.watch<User?>();
    
    TextEditingController _namaController = TextEditingController()
      ..text = selectnama;
    TextEditingController _hargaController = TextEditingController()
      ..text = selectharga;
    TextEditingController _gambarController = TextEditingController()
      ..text = selectgambar;

    //1. initialise firebase
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    //2. Create
    void _update(String userid, String _nama, String _harga, String _gambar) async {
      try {
        await firestore
            .collection('pizza')
            .doc(selectdocid)
            .update({'userid': userid, 'nama': _nama, 'harga': _harga, 'gambar': _gambar});
        Navigator.pop(context);
      } catch (e) {
        print(e); //kalau error print kat debug console
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Pizza'),
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
                    _update(firebaseuser!.uid,_namaController.text, _hargaController.text,
                        _gambarController.text);
                  },
                  child: const Text('Update Pizza'))
            ],
          ),
        ),
      ),
    );
  }
}
