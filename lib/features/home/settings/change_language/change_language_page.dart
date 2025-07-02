import 'package:core/services/get_it_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_diary/features/home/settings/change_language/change_language_mobile_layout.dart';
import 'package:voice_diary/features/home/settings/change_language/cubit/change_language_cubit.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/widgets/base_scaffold.dart';

class ChangeLanguagePage extends StatelessWidget {
  const ChangeLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BaseScaffold(
      title: l10n.change_language,
      child: BlocProvider<ChangeLanguageCubit>(
        create: (context) => getIt<ChangeLanguageCubit>()..init(),
        child: ChangeLanguageMobileLayout(),
      ),
    );
  }
}
