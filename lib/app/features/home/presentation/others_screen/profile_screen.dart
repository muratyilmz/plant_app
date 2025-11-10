import 'package:flutter/material.dart';
import 'package:plant_app/app/core/widgets/base_scaffold.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(child: Center(child: Text("Profile Screen")));
  }
}
