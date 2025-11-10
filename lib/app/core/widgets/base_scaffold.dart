import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    required this.child,
    this.background,
    this.useSafeArea = true,
    this.padding = const EdgeInsets.fromLTRB(16, 16, 16, 12),
    this.appBar,
    this.backgroundColor,
  });

  final Widget child;
  final Widget? background;
  final bool useSafeArea;
  final EdgeInsets padding;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final content = Padding(padding: padding, child: child);

    final body = Stack(
      fit: StackFit.expand,
      children: [
        if (background != null) Positioned.fill(child: background!),
        useSafeArea ? SafeArea(child: content) : content,
      ],
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor ?? Colors.transparent,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: body,
    );
  }
}
