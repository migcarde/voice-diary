import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @required_field.
  ///
  /// In en, this message translates to:
  /// **'Required field'**
  String get required_field;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @configuration.
  ///
  /// In en, this message translates to:
  /// **'Configuration'**
  String get configuration;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @repeat_password.
  ///
  /// In en, this message translates to:
  /// **'Repeat password'**
  String get repeat_password;

  /// No description provided for @user_already_registered_please_use_another_email.
  ///
  /// In en, this message translates to:
  /// **'User is already registered, please, use another email'**
  String get user_already_registered_please_use_another_email;

  /// No description provided for @invalid_credentials_please_try_again.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials, please, try again'**
  String get invalid_credentials_please_try_again;

  /// No description provided for @sorry_we_have_problems_please_try_again_later.
  ///
  /// In en, this message translates to:
  /// **'Sorry we have problems, please, try again later'**
  String get sorry_we_have_problems_please_try_again_later;

  /// No description provided for @are_you_not_registered_question.
  ///
  /// In en, this message translates to:
  /// **'Are you not registered?'**
  String get are_you_not_registered_question;

  /// No description provided for @password_does_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords doesn\'t match'**
  String get password_does_not_match;

  /// No description provided for @passwords_is_weak.
  ///
  /// In en, this message translates to:
  /// **'Password is weak, please use a password that has at least 8 letters, one of them in upper case and another one in lowe case, one number and one special character (@#\$%^&)'**
  String get passwords_is_weak;

  /// No description provided for @email_not_valid.
  ///
  /// In en, this message translates to:
  /// **'Email not valid'**
  String get email_not_valid;

  /// No description provided for @tap_to_begin_your_voice_recor_entry.
  ///
  /// In en, this message translates to:
  /// **'Tap to begin your voice record entry'**
  String get tap_to_begin_your_voice_recor_entry;

  /// No description provided for @recording_dots.
  ///
  /// In en, this message translates to:
  /// **'Recording...'**
  String get recording_dots;

  /// No description provided for @did_you_want_to_save_this_recording.
  ///
  /// In en, this message translates to:
  /// **'Did you want to save this recording?'**
  String get did_you_want_to_save_this_recording;

  /// No description provided for @are_you_sure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get are_you_sure;

  /// No description provided for @this_action_cannot_be_undone.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone'**
  String get this_action_cannot_be_undone;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @recording_saved.
  ///
  /// In en, this message translates to:
  /// **'Recording saved'**
  String get recording_saved;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @set_tags_to_your_record.
  ///
  /// In en, this message translates to:
  /// **'Set tags to your record'**
  String get set_tags_to_your_record;

  /// No description provided for @change_language.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get change_language;

  /// No description provided for @delete_account.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get delete_account;

  /// No description provided for @you_must_enter_your_credentials_again_to_delete_your_account.
  ///
  /// In en, this message translates to:
  /// **'You must enter your credentials again to delete your account'**
  String get you_must_enter_your_credentials_again_to_delete_your_account;

  /// No description provided for @all_data_related_to_this_account_will_be_deleted_and_cannot_be_recovered.
  ///
  /// In en, this message translates to:
  /// **'All date related to this account will be deleted and cannot be recovered'**
  String get all_data_related_to_this_account_will_be_deleted_and_cannot_be_recovered;

  /// No description provided for @records.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get records;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @you_have_not_added_any_record_yet.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t added any record yet'**
  String get you_have_not_added_any_record_yet;

  /// No description provided for @record_entry.
  ///
  /// In en, this message translates to:
  /// **'Record entry'**
  String get record_entry;

  /// No description provided for @entry.
  ///
  /// In en, this message translates to:
  /// **'Entry'**
  String get entry;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @spanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// No description provided for @change_language_success.
  ///
  /// In en, this message translates to:
  /// **'Change language success'**
  String get change_language_success;

  /// No description provided for @filter_by_tag.
  ///
  /// In en, this message translates to:
  /// **'Filter by tag'**
  String get filter_by_tag;

  /// No description provided for @search_tag.
  ///
  /// In en, this message translates to:
  /// **'Search tag'**
  String get search_tag;

  /// No description provided for @tap_a_tag_to_filter.
  ///
  /// In en, this message translates to:
  /// **'Tap a tag to filter'**
  String get tap_a_tag_to_filter;

  /// No description provided for @no_tags_found.
  ///
  /// In en, this message translates to:
  /// **'No tags found'**
  String get no_tags_found;

  /// No description provided for @transcription.
  ///
  /// In en, this message translates to:
  /// **'Transcription'**
  String get transcription;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @record_details.
  ///
  /// In en, this message translates to:
  /// **'Record details'**
  String get record_details;

  /// No description provided for @record_updated_successfully.
  ///
  /// In en, this message translates to:
  /// **'Record updated successfully'**
  String get record_updated_successfully;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
