import 'package:flutter/material.dart';

class NavigationBarIcon extends StatelessWidget {
  const NavigationBarIcon({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.isSelected = false,
  });

  final String text;
  final IconData icon;

  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? Theme.of(context).primaryColor
        : Theme.of(context).colorScheme.secondary;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
