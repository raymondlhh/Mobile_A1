import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../screens/profile/edit_screen.dart';
import '../models/user_profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ProfileHeader extends StatefulWidget {
  final bool showDetails;
  const ProfileHeader({super.key, this.showDetails = true});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  File? _selectedImage;
  bool _isUploadingPhoto = false;

  Future<File> _compressImage(File file) async {
    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      file.absolute.path + '_compressed.jpg',
      quality: 70,
    );
    if (result != null) {
      return File(result.path);
    } else {
      return file;
    }
  }

  Future<void> _pickAndUploadPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    setState(() { _isUploadingPhoto = true; });

    final userId = UserProfile.userId;
    File imageFile = File(pickedFile.path);
    File compressed = await _compressImage(imageFile);
    final storageRef = FirebaseStorage.instance.ref().child('profile_photos/$userId.jpg');
    await storageRef.putFile(compressed);
    final photoUrl = await storageRef.getDownloadURL();

    // Save URL to Firestore
    await FirebaseFirestore.instance.collection('users').doc(userId).set(
      {'photoUrl': photoUrl},
      SetOptions(merge: true),
    );

    // Update in-memory profile
    UserProfile.photoUrl = photoUrl;
    setState(() {
      _selectedImage = compressed;
      _isUploadingPhoto = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileImage = Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 118,
          height: 118,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'assets/images/others/ProfilePicBackground.png',
            fit: BoxFit.cover,
          ),
        ),
        ClipOval(
          child: _selectedImage != null
              ? Image.file(_selectedImage!, width: 100, height: 100, fit: BoxFit.cover)
              : (UserProfile.photoUrl.isNotEmpty
                  ? Image.network(UserProfile.photoUrl, width: 100, height: 100, fit: BoxFit.cover)
                  : Image.asset('assets/images/others/Profile.png', width: 100, height: 100, fit: BoxFit.cover)),
        ),
        // Edit profile button overlaid
        Positioned(
          bottom: -30,
          right: -30,
          child: GestureDetector(
            onTap: _isUploadingPhoto ? null : _pickAndUploadPhoto,
            child: Image.asset(
              'assets/images/buttons/EditProfileButton.png',
              width: 100,
              height: 100,
            ),
          ),
        ),
        if (_isUploadingPhoto)
          Positioned.fill(
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(top: 35, left: 30, right: 50),
      child: widget.showDetails
          ? Row(
              children: [
                profileImage,
                const SizedBox(width: 30),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          UserProfile.name,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          UserProfile.email,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 8,
                          ),
                        ),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const EditScreen()),
                            );
                            setState(() {}); // ⬅ Rebuilds with updated name/email
                          },
                          child: Image.asset(
                            'assets/images/buttons/EditButton.png',
                            width: 150,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Align(
              alignment: const Alignment(0.1, 0),
              child: profileImage,
            ),
    );
  }
}
