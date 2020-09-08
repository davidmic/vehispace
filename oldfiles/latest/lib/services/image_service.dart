import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';

class ImageService extends ChangeNotifier  {

  static File image;
  static String uploadFileURL;

  Future fromGallery () async {
     try{
       await ImagePicker.pickImage(source: ImageSource.gallery).then((fileImage){
        // setState(() {
          image = fileImage;
           print('File Image is ' + fileImage.toString());
          print('Image is ' + image.toString());
          notifyListeners();
      //   });
      });
    }catch (e) {
      // setState(() {
         image = null;
         notifyListeners();
      // });
    }
  }
  Future fromCamera () async {
    try{
       await ImagePicker.pickImage(source: ImageSource.camera).then((fileImage){
        // setState(() {
          image = fileImage;
          print('File Image is ' + fileImage.toString());
          print('Image is ' + image.toString());
        // });
        notifyListeners();
        return image;
      });
    }catch (e) {
      // setState(() {
         image = null;
         notifyListeners();
      // });
    }
  }

  Future uploadFile (vImage, String folder) async {
    try {
      StorageReference storageReference = FirebaseStorage.instance.ref()
        .child('$folder/${Path.basename(vImage.path)}');
        StorageUploadTask uploadTask = storageReference.putFile(vImage);
        StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
        print('File Uploaded');
        await storageReference.getDownloadURL().then((fileURL) {
      // setState(() {
        uploadFileURL = fileURL;
        notifyListeners();
      // });
      // return uploadFileURL;
    });
    } catch (e) {
      print (e.toString());
      notifyListeners();
    }
  }

 
}