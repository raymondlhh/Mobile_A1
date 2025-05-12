import 'package:flutter/material.dart';

import '../../widgets/title_appbar.dart';
import '../../widgets/profile_description.dart';

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

  bool _obscurePassword = true;

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

  void saveProfileData() {
    UserProfile.name = _nameController.text;
    UserProfile.email = _emailController.text;
    UserProfile.password = _passwordController.text;
    UserProfile.phone = '+60 ${_phoneController.text}';
    UserProfile.address = _addressController.text;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile saved successfully!')),
    );

    Navigator.pop(context); // return to profile screen
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
            const SizedBox(height: 20),
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
