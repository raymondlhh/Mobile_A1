import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../screens/profile/edit_screen.dart';
import '../models/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileHeader extends StatefulWidget {
  final bool showDetails;
  const ProfileHeader({super.key, this.showDetails = true});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  String _currentPhotoUrl = '';

  @override
  void initState() {
    super.initState();
    _loadProfilePicture();
  }

  Future<void> _loadProfilePicture() async {
    final userId = UserProfile.userId;
    if (userId.isEmpty) return;
    
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        final userData = doc.data()!;
        final photoAsset = userData['photoAsset'];
        final photoUrl = userData['photoUrl'];
        
        setState(() {
          _currentPhotoUrl = photoAsset ?? photoUrl ?? 'assets/images/others/Profile.png';
        });
      }
    } catch (e) {
      print('Error loading profile picture: $e');
    }
  }

  Future<void> _pickProfileAsset(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final List<String> assetNames = [
      'assets/images/others/Profile.png',
      'assets/images/others/Profile2.png',
      'assets/images/others/Profile3.png',
    ];

    final selected = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.chooseProfilePicture),
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
      setState(() {
        _currentPhotoUrl = selected;
      });
    }
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
          child: Image.asset(
            _currentPhotoUrl.isNotEmpty
                ? _currentPhotoUrl
                : 'assets/images/others/Profile.png',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        // Edit profile button overlaid
        Positioned(
          bottom: -30,
          right: -30,
          child: GestureDetector(
            onTap: () => _pickProfileAsset(context),
            child: Image.asset(
              'assets/images/buttons/EditProfileButton.png',
              width: 100,
              height: 100,
            ),
          ),
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
                            setState(() {
                              _loadProfilePicture(); // Reload profile picture after edit
                            }); // ⬅ Rebuilds with updated name/email
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
