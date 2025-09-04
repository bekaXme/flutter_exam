import 'package:flutter/material.dart';
import 'package:flutter_exam/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';

// MAIN SETTINGS PAGE
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<IconData> settingsIcons = [
    Icons.notifications,
    Icons.volume_up,
    Icons.privacy_tip,
    Icons.language,
    Icons.color_lens,
    Icons.logout,
  ];

  List<String> settingsTitles = [
    'Notifications',
    'Sound',
    'Privacy',
    'Language',
    'Theme',
    'Logout',
  ];

  final settingsbox = Hive.box<Map>('settings');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // ✅ fixed
          },
          icon: SvgPicture.asset('assets/icons/back-arrow.svg'),
        ),
        title: const Text('Settings', style: TextStyle(color: Colors.pink)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: settingsTitles.length,
              itemBuilder: (context, index) {
                return buildSettingsItem(
                  settingsTitles[index],
                  settingsIcons[index],
                  index, // pass index as ID
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Delete Account',
            style: TextStyle(color: Colors.pinkAccent),
          ),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 40.h, left: 40.w, right: 40.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.4)],
          ),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Container(
          width: 280.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: const Color(0xFFFD5D69),
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/home.svg'),
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/community.svg'),
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/categories.svg'),
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/profile.svg'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable widget for settings items
  Widget buildSettingsItem(String title, IconData iconData, int id) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.pinkAccent,
          borderRadius: BorderRadius.circular(30), // ✅ fixed
        ),
        child: Icon(iconData, color: Colors.white),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 16.sp, color: Colors.white),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: () {
        // Navigate to detail page with ID
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SettingDetailPage(id: id, title: title),
          ),
        );
      },
    );
  }
}

class SettingDetailPage extends StatefulWidget {
  final int id;
  final String title;

  const SettingDetailPage({super.key, required this.id, required this.title});

  @override
  State<SettingDetailPage> createState() => _SettingDetailPageState();
}

class _SettingDetailPageState extends State<SettingDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(widget.title, style: const TextStyle(color: Colors.pink)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.pink),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            buildSettingsItem('General ${widget.title}', true),
            buildSettingsItem('Notifications ${widget.title}', true),
            buildSettingsItem('Sound ${widget.title}', true),
            buildSettingsItem('Privacy ${widget.title}', true),
          ],
        ),
      ),
    );
  }

  Widget buildSettingsItem(String title, isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(color: Colors.white)),
        Switch(
          value: isActive,
          activeColor: Colors.white,
          onChanged: (value) => setState(() => isActive = value),
        ),
      ],
    );
  }
}
