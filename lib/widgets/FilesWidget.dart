import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class FilesWidget extends StatefulWidget {


  @override
  State<FilesWidget> createState() => _FilesWidgetState();
}

class _FilesWidgetState extends State<FilesWidget> {
  File? _image;
  PickedFile? _pickedFile;
  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _pickImageGallery() async {
    _pickedFile=
    await _picker.getImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      setState(() {
        _image = File(_pickedFile!.path);
      });
    }
  }
  Future<void> _pickImageCamera() async {
    _pickedFile=
    await _picker.getImage(source: ImageSource.camera);
    if (_pickedFile != null) {
      setState(() {
        _image = File(_pickedFile!.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blue)
                  ),
                  onPressed: _pickImageCamera,
                  icon: FaIcon(FontAwesomeIcons.camera,color: Colors.blue,),
                  label: Text("Prendre une photo", style: TextStyle(color: Colors.blue),)
              ),
              OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.blue)
                  ),
                  onPressed: _pickImageGallery,
                  icon: FaIcon(FontAwesomeIcons.image,color: Colors.blue,),
                  label: Text("Chercher une photo", style: TextStyle(color: Colors.blue),)
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,

            height: MediaQuery.of(context).size.height/3,
            child: _pickedFile != null
                ? Image.file(
              File(_pickedFile!
                  .path), width: 100, height: 100, fit: BoxFit.cover,
            )
                : const Text('Selectionner une image'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue[700],
            ),
              onPressed: (){},
              child: Text("Enregistrer",style: TextStyle(color: Colors.white),)
          )
        ],
      ),
    );
  }
}
