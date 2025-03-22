import 'package:flutter/widgets.dart';
import 'package:voice_diary/features/home/home_mobile_layout.dart';
import 'package:voice_diary/widgets/base_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: HomeMobileLayout(),
    );
  }
}
