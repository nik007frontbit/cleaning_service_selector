
import 'package:flutter/material.dart';

/// Reusable InfoTile widget
class InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const InfoTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      trailing: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
    );
  }
}