import 'package:flutter/material.dart';
import '../../../colors.dart';

Widget buildIconButton(IconData icon) {
  return Container(
    width: 28,
    height: 28,
    decoration: BoxDecoration(
      color: AppColors.pinkIcon,
      borderRadius: BorderRadius.circular(16),
    ),
    child: IconButton(
      padding: EdgeInsets.zero,
      onPressed: () {},
      icon: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
    ),
  );
}
