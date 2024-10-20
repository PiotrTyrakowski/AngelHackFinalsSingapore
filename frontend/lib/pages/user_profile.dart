import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/mock_data/mock_user.dart';
import 'package:frontend/models/event_categories.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/pages/event_details_page.dart';
import 'package:frontend/profile/profile.dart';
import 'package:frontend/widgets/categories_wrap_widget.dart';
import 'package:frontend/widgets/filters_widget.dart';

class UserProfile extends StatefulWidget {
  final User user;

  const UserProfile({Key? key, required this.user}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  List<Widget> getBadges()
  {
    List<Widget> badgesBlocks = widget.user.userBadges
                    .map((badge) => _buildTab(badge.name, isSelected: true))
                    .toList();
    if (badgesBlocks.isEmpty)
    {
      badgesBlocks.add(const Text('None'));
    }
    return badgesBlocks;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          if (widget.user == MockUser().currentUser ) 
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfileWidget(),
                  ),
                );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              // Profile Image with background circle
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFEBEE),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('assets/profile_picture.png'),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Name and Age Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${widget.user.firstName} ${widget.user.lastName}, ${widget.user.age}', 
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 5),
                  // Verified Icon
                  const Icon(
                    Icons.verified,
                    color: Colors.red,
                    size: 20.0,
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                'User\'s badges:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: getBadges(),
              ),

              const SizedBox(height: 30),
              const Text(
                'User\'s preferences:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              CategoriesWrapWidget(user: widget.user),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
  
}

Widget _buildTab(String text, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 14.0,
        ),
      ),
    );
  }



