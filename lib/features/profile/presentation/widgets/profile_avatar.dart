import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final bool showEditIcon;

  const ProfileAvatar({super.key, this.showEditIcon = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
            child: Icon(
              Icons.person,
              size: 60,
              color: Colors.grey[700],
            ),
          ),
          if (showEditIcon)
            Positioned(
              bottom: 0,
              right: 0,
              child: Icon(
                Icons.edit,
                color: Colors.deepPurple,
                size: 24,
              ),
            ),
        ],
      ),
    );
  }
}
