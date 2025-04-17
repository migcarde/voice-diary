import 'package:core/services/get_it_service.dart';
import 'package:domain/domain.dart';
import 'package:firebase_login/core/dependency_injection/firebase_login_dependency_injection.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_diary/features/app/cubit/app_cubit.dart';
import 'package:voice_diary/features/bottom_bar/cubit/bottom_bar_cubit.dart';
import 'package:voice_diary/features/home/records/cubit/records_cubit.dart';
import 'package:voice_diary/features/home/settings/change_language/cubit/change_language_cubit.dart';
import 'package:voice_diary/features/home/settings/cubit/settings_cubit.dart';
import 'package:voice_diary/features/home/settings/reauthentication/cubit/reauthentication_cubit.dart';
import 'package:voice_diary/features/login/cubit/login_cubit.dart';
import 'package:voice_diary/features/register/cubit/register_cubit.dart';
import 'package:voice_diary/features/voice_record_entry/cubit/voice_record_entry_cubit.dart';
import 'package:voice_diary/features/voice_record_entry/save_record_entry/cubit/save_record_entry_cubit.dart';
import 'package:voice_diary/services/sound_recorder/sound_recoder_service.dart';
import 'package:voice_diary/services/sound_recorder/sound_recorder_service_impl.dart';

class AppDependencyInjection {
  static Future<void> init() async {
    FirebaseLoginDependencyInjection.init();
    await DomainDependencyInjection.init();

    getIt.registerLazySingleton<FlutterSoundRecorder>(
      () => FlutterSoundRecorder(),
    );

    getIt.registerLazySingleton<SpeechToText>(
      () => SpeechToText(),
    );

    getIt.registerLazySingleton<SoundRecoderService>(
      () => SoundRecorderServiceImpl(
        recorder: getIt(),
      ),
    );

    getIt.registerFactory<LoginCubit>(
      () => LoginCubit(
        firebaseLoginService: getIt(),
      ),
    );

    getIt.registerFactory<RegisterCubit>(
      () => RegisterCubit(
        firebaseLoginService: getIt(),
        saveUser: getIt(),
        saveUserPreferences: getIt(),
      ),
    );

    getIt.registerLazySingleton<AppCubit>(
      () => AppCubit(
        firebaseLoginService: getIt(),
      ),
    );

    getIt.registerFactory<VoiceRecordEntryCubit>(
      () => VoiceRecordEntryCubit(
        soundRecoderService: getIt(),
        speechToText: getIt(),
      ),
    );

    getIt.registerFactory<SaveRecordEntryCubit>(
      () => SaveRecordEntryCubit(
        saveRecord: getIt(),
      ),
    );

    getIt.registerFactory(
      () => SettingsCubit(
        firebaseLoginService: getIt(),
        deleteUser: getIt(),
      ),
    );

    getIt.registerFactory<ReauthenticationCubit>(
      () => ReauthenticationCubit(
        firebaseLoginService: getIt(),
      ),
    );

    getIt.registerFactory<BottomBarCubit>(
      () => BottomBarCubit(),
    );

    getIt.registerFactory<RecordsCubit>(
      () => RecordsCubit(
        getAllRecords: getIt(),
      ),
    );

    getIt.registerFactory<ChangeLanguageCubit>(
      () => ChangeLanguageCubit(
        getUserPreferences: getIt(),
        saveUserPreferences: getIt(),
      ),
    );
  }
}
