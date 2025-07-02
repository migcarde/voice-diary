import 'package:go_router/go_router.dart';
import 'package:voice_diary/features/home/home_page.dart';
import 'package:voice_diary/features/home/settings/change_language/change_language_page.dart';
import 'package:voice_diary/features/login/login_page.dart';
import 'package:voice_diary/features/record_details/edit_record_details/edit_record_details_page.dart';
import 'package:voice_diary/features/record_details/edit_record_details/models/edit_record_details_view_model.dart';
import 'package:voice_diary/features/record_details/models/record_details_view_model.dart';
import 'package:voice_diary/features/record_details/record_details_page.dart';
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
        GoRoute(
          path: Paths.voiceRecordDetails,
          builder: (context, state) {
            final recordDetailsViewModel =
                state.extra! as RecordDetailsViewModel;

            return RecordDetailsPage(
              recordDetailsViewModel: recordDetailsViewModel,
            );
          },
        ),
        GoRoute(
          path: Paths.editRecordDetails,
          builder: (context, state) {
            final recordDetailsViewModel =
                state.extra! as EditRecordDetailsViewModel;

            return EditRecordDetailsPage(
              editRecordDetailsViewModel: recordDetailsViewModel,
            );
          },
        ),
      ];
}
