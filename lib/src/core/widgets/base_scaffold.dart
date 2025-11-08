import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    required this.child,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.useSafeArea = true,
    this.background,
  });

  final Widget child;
  final Color? backgroundColor;
  final EdgeInsets padding;
  final bool useSafeArea;
  final Widget? background;

  @override
  Widget build(BuildContext context) {
    final content = Padding(padding: padding, child: child);

    final body = Stack(
      children: [
        if (background != null) Positioned.fill(child: background!),
        useSafeArea ? SafeArea(child: content) : content,
      ],
    );

    return Scaffold(
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      body: body,
    );
  }
}
