import 'package:go_router/go_router.dart';
import 'package:voice_diary/features/home/home_page.dart';
import 'package:voice_diary/features/home/settings/change_language/change_language_page.dart';
import 'package:voice_diary/features/login/login_page.dart';
import 'package:voice_diary/features/register/register_page.dart';
import 'package:voice_diary/features/voice_record_entry/save_record_entry/models/save_record_entry_view_model.dart';
import 'package:voice_diary/features/voice_record_entry/save_record_entry/save_record_entry_page.dart';
import 'package:voice_diary/features/voice_record_entry/voice_record_entry_page.dart';
import 'package:voice_diary/routing/paths.dart';

class Routes {
  static List<GoRoute> get list => [
        GoRoute(
          path: Paths.login,
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          path: Paths.register,
          builder: (context, state) => RegisterPage(),
        ),
        GoRoute(
          path: Paths.home,
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: Paths.voiceRecordEntry,
          builder: (context, state) => VoiceRecordEntryPage(),
        ),
        GoRoute(
          path: Paths.saveRecordEntry,
          builder: (context, state) => SaveRecordEntryPage(
            viewModel: state.extra! as SaveRecordEntryViewModel,
          ),
        ),
        GoRoute(
          path: Paths.changeLanguage,
          builder: (context, state) => ChangeLanguagePage(),
        ),
      ];
}
