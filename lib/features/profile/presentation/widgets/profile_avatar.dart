import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileAvatar extends StatefulWidget {
  final bool showEditIcon;
  final Function(File)? onImagePicked;
  final String? imageUrl;

  const ProfileAvatar(
      {super.key,
      this.showEditIcon = false,
      this.onImagePicked,
      this.imageUrl});

  @override
  _ProfileAvatarState createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  File? _imageFile;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _loadImageUrl();
  }

  Future<void> _loadImageUrl() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _imageUrl = prefs.getString('imageUrl');
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      if (widget.onImagePicked != null) {
        widget.onImagePicked!(_imageFile!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
            backgroundImage: _imageFile != null
                ? FileImage(_imageFile!)
                : (_imageUrl != null
                    ? NetworkImage(_imageUrl!)
                    : AssetImage('assets/default_avatar.png')) as ImageProvider,
            child: _imageFile == null && _imageUrl == null
                ? Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.grey[700],
                  )
                : null,
          ),
          if (widget.showEditIcon)
            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.deepPurple,
                  size: 24,
                ),
                onPressed: _pickImage,
              ),
            ),
        ],
      ),
    );
  }
}
