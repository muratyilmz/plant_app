import 'package:flutter/material.dart';
import 'package:plant_app/app/core/widgets/base_scaffold.dart';

class MyGardenScreen extends StatelessWidget {
  const MyGardenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(child: Center(child: Text("My Garden Screen")));
  }
}
