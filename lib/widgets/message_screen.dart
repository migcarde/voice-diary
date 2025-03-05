import 'package:flutter/material.dart';
import 'package:voice_diary/core/app_dimens.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({
    super.key,
    required this.icon,
    required this.message,
  });

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: theme.primaryColor,
            size: 100.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppDimens.l),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineMedium
                  ?.copyWith(color: theme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
