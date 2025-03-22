import 'package:flutter/material.dart';
import 'package:voice_diary/extensions/build_context_extensions.dart';
import 'package:voice_diary/widgets/base_screen.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    this.title,
    required this.child,
  });

  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: title != null && title?.isNotEmpty == true
          ? AppBar(
              iconTheme: theme.iconTheme.copyWith(
                color: theme.colorScheme.primary,
              ),
              title: Text(
                title!,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            )
          : null,
      body: SafeArea(
        child: BaseScreen(
          child: child,
        ),
      ),
    );
  }
}
