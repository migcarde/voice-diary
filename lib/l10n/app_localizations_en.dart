// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get required_field => 'Required field';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get configuration => 'Configuration';

  @override
  String get logout => 'Logout';

  @override
  String get repeat_password => 'Repeat password';

  @override
  String get user_already_registered_please_use_another_email => 'User is already registered, please, use another email';

  @override
  String get invalid_credentials_please_try_again => 'Invalid credentials, please, try again';

  @override
  String get sorry_we_have_problems_please_try_again_later => 'Sorry we have problems, please, try again later';

  @override
  String get are_you_not_registered_question => 'Are you not registered?';

  @override
  String get password_does_not_match => 'Passwords doesn\'t match';

  @override
  String get passwords_is_weak => 'Password is weak, please use a password that has at least 8 letters, one of them in upper case and another one in lowe case, one number and one special character (@#\$%^&)';

  @override
  String get email_not_valid => 'Email not valid';

  @override
  String get tap_to_begin_your_voice_recor_entry => 'Tap to begin your voice record entry';

  @override
  String get recording_dots => 'Recording...';

  @override
  String get did_you_want_to_save_this_recording => 'Did you want to save this recording?';

  @override
  String get are_you_sure => 'Are you sure?';

  @override
  String get this_action_cannot_be_undone => 'This action cannot be undone';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get save => 'Save';

  @override
  String get recording_saved => 'Recording saved';

  @override
  String get title => 'Title';

  @override
  String get tags => 'Tags';

  @override
  String get base_on_your_record_we_recommend_these_tags => 'Base on your record, we recommend these tags';
}
