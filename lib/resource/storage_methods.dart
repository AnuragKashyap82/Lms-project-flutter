import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(
      String filePath,
      String fileName,
      ) async{
      File file = File(filePath);
      try{
        final  Reference storageReference = FirebaseStorage.instance.ref().child("Notices");
        UploadTask uploadTask = storageReference.putFile(file);
        String url = await (await uploadTask).ref.getDownloadURL();
      }on firebase_core.FirebaseException catch(e){
        print(e);
      }
  }
}
