import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ListGambar extends StatefulWidget {
  @override
  State<ListGambar> createState() => _ListGambarState();
}

class _ListGambarState extends State<ListGambar> {
  final picker = ImagePicker();
  late File _imageFile;

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future<void> uploadFile() async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('abc.jpg')
          .putFile(_imageFile);
      print('file uploaded');
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  //fuction utk senarai gambar
  Future<void> listGambar() async {
    firebase_storage.ListResult result =
        await firebase_storage.FirebaseStorage.instance.ref().listAll();

    for (var ref in result.items) {
      print('Found file: $ref');
    }

    for (var ref in result.prefixes) {
      print('Found directory: $ref');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Gambar'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  //code
                  pickImage();
                  uploadFile();
                },
                child: Text('Upload gambar'),
              ),
              ElevatedButton(
                onPressed: () {
                  //code
                  listGambar();
                },
                child: Text('list gambar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
