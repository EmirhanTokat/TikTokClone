import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constans.dart';

class AuthController extends GetxController {
  //upload to firebase storage
  Future<String> _uploadTheStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child("profilePics")
        .child(firebaseAuth.currentUser!.uid);

      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();
      return downloadUrl;
  }
  //registering the user

  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        //save out user  to ath and firebase firestore
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        await _uploadTheStorage(image);
      }
    } catch (e) {
      Get.snackbar(
        "Error Creating Account",
        e.toString(),
      );
    }
  }
}
