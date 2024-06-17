import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../providers/image_provider.dart';
import '../../widgets/custom_button.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File? _selectedImage;

  void _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        _selectedImage = File(result.files.single.path!);
      });
    }
  }

  void _uploadImage(BuildContext context) async {
    if (_selectedImage != null) {
      try {
        await Provider.of<ImageProvider>(context, listen: false).uploadImage(_selectedImage!.path);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image uploaded successfully')));
        setState(() {
          _selectedImage = null;
        });
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to upload image')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select an image first')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_selectedImage != null) ...[
              Image.file(_selectedImage!, height: 200),
              SizedBox(height: 20),
            ],
            CustomButton(
              text: 'Choose Image',
              onPressed: _pickImage,
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Upload Image',
              onPressed: () => _uploadImage(context),
            ),
          ],
        ),
      ),
    );
  }
}
