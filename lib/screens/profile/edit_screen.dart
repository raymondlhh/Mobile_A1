import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/title_appbar.dart';
import '../../widgets/profile_description.dart';
import '../../services/auth_service.dart';

import '../../models/user_profile.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  final AuthService _authService = AuthService();

  bool _obscurePassword = true;
  File? _profileImage;
  bool _isUploadingPhoto = false;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: UserProfile.name);
    _emailController = TextEditingController(text: UserProfile.email);
    _passwordController = TextEditingController(text: UserProfile.password);
    _phoneController = TextEditingController(text: UserProfile.phone.replaceFirst('+60 ', ''));
    _addressController = TextEditingController(text: UserProfile.address);

    _obscurePassword = true;

    onTickPressed = saveProfileData;
  }

  Future<void> _pickAndUploadPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    setState(() { _isUploadingPhoto = true; });

    final userId = UserProfile.userId;
    final storageRef = FirebaseStorage.instance.ref().child('profile_photos/$userId.jpg');
    await storageRef.putFile(File(pickedFile.path));
    final photoUrl = await storageRef.getDownloadURL();

    // Save URL to Firestore
    await FirebaseFirestore.instance.collection('users').doc(userId).set(
      {'photoUrl': photoUrl},
      SetOptions(merge: true),
    );

    // Update in-memory profile
    UserProfile.photoUrl = photoUrl;
    setState(() {
      _profileImage = File(pickedFile.path);
      _isUploadingPhoto = false;
    });
  }

  Future<void> _pickProfileAsset(BuildContext context) async {
    final List<String> assetNames = [
      'assets/images/others/Profile.png',
      'assets/images/others/Profile2.png',
      'assets/images/others/Profile3.png',
    ];

    final selected = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Profile Picture'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: assetNames.map((asset) {
            return GestureDetector(
              onTap: () => Navigator.of(context).pop(asset),
              child: CircleAvatar(
                backgroundImage: AssetImage(asset),
                radius: 35,
              ),
            );
          }).toList(),
        ),
      ),
    );

    if (selected != null) {
      final userId = UserProfile.userId;
      await FirebaseFirestore.instance.collection('users').doc(userId).set(
        {'photoAsset': selected},
        SetOptions(merge: true),
      );
      UserProfile.photoUrl = selected;
      setState(() {});
    }
  }

  void saveProfileData() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final phone = '+60 ${_phoneController.text}';
    final address = _addressController.text;

    try {
      await _authService.updateUserData(
        currentEmail: UserProfile.email,
        name: name,
        email: email,
        password: password,
        phone: phone,
        address: address,
      );

      UserProfile.name = name;
      UserProfile.email = email;
      UserProfile.password = password;
      UserProfile.phone = phone;
      UserProfile.address = address;

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile saved successfully!')),
        );
        Navigator.pop(context); // return to profile screen
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save profile: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Edit Profile', actionType: AppBarActionType.saveProfileButton),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/others/InkPainting.png',
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                ),
                const ProfileHeader(showDetails: false),
              ],
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInputField('Name', _nameController),
                  buildInputField('Email', _emailController),
                  buildPasswordField(),
                  buildPhoneField(),
                  buildInputField('Delivery Address', _addressController, maxLines: 2),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(label,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
            )),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0x267F7F7F),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            style: const TextStyle(fontWeight: FontWeight.w600),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        const Text('Password',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
            )),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0x267F7F7F),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                child: Image.asset(
                  _obscurePassword
                      ? 'assets/images/icons/CloseEye.png'
                      : 'assets/images/icons/OpenEye.png',
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        const Text('Phone Number',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
            )),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0x267F7F7F),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              const Text('+60 ',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              Expanded(
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
