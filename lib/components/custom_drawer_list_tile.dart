import 'package:flutter/material.dart';

class CustomDrawerListTile extends StatelessWidget {
  const CustomDrawerListTile({
    Key? key,
    required this.onTap,
    required this.title,
    required this.icon,
    this.pBottom = 0,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final IconData icon;
  final double pBottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, bottom: pBottom),
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}
