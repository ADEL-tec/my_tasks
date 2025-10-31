import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_ar.dart';
import 'l10n_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/l10n.dart';
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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// Selectcted Language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;

  /// No description provided for @language_en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language_en;

  /// No description provided for @language_ar.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get language_ar;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'My Tasks'**
  String get appName;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get welcomeBack;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcome;

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

  /// No description provided for @loginDescription.
  ///
  /// In en, this message translates to:
  /// **'Please fill the forms below to get started.\nif you are not member yet, please clock on Register now below'**
  String get loginDescription;

  /// No description provided for @registerDescription.
  ///
  /// In en, this message translates to:
  /// **'Please fill in the form below to create your account.\nIf you already have an account, please click on \"Sign In\" below.'**
  String get registerDescription;

  /// No description provided for @loginNow.
  ///
  /// In en, this message translates to:
  /// **'Login Now'**
  String get loginNow;

  /// No description provided for @loginImage.
  ///
  /// In en, this message translates to:
  /// **'Login image'**
  String get loginImage;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailed;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Login Now'**
  String get registerNow;

  /// No description provided for @loginRegister.
  ///
  /// In en, this message translates to:
  /// **'Login Register'**
  String get loginRegister;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'LogOut'**
  String get logOut;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Name'**
  String get enterName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enterEmail;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get enterPassword;

  /// No description provided for @validatorsInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address!'**
  String get validatorsInvalidEmail;

  /// No description provided for @validatorsEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get validatorsEmailRequired;

  /// No description provided for @validatorsPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get validatorsPasswordRequired;

  /// No description provided for @validatorLongPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get validatorLongPassword;

  /// No description provided for @validatorPasswordsNotMatch.
  ///
  /// In en, this message translates to:
  /// **'passwords not match'**
  String get validatorPasswordsNotMatch;

  /// No description provided for @validatorsNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get validatorsNameRequired;

  /// No description provided for @validatorLongName.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 6 characters'**
  String get validatorLongName;

  /// No description provided for @validatorsPhoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get validatorsPhoneRequired;

  /// No description provided for @notMember.
  ///
  /// In en, this message translates to:
  /// **'Not a member?'**
  String get notMember;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @saveTask.
  ///
  /// In en, this message translates to:
  /// **'Save Task'**
  String get saveTask;

  /// No description provided for @editTask.
  ///
  /// In en, this message translates to:
  /// **'Edit Task'**
  String get editTask;

  /// No description provided for @addTask.
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get addTask;

  /// No description provided for @pleaseEnterTitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
  String get pleaseEnterTitle;

  /// No description provided for @due.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get due;

  /// No description provided for @dueDate.
  ///
  /// In en, this message translates to:
  /// **'Due Date'**
  String get dueDate;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @toDo.
  ///
  /// In en, this message translates to:
  /// **'To Do'**
  String get toDo;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get inProgress;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @taskDetails.
  ///
  /// In en, this message translates to:
  /// **'Task Details'**
  String get taskDetails;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @createdAt.
  ///
  /// In en, this message translates to:
  /// **'Created At'**
  String get createdAt;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @notDone.
  ///
  /// In en, this message translates to:
  /// **'Not Done'**
  String get notDone;

  /// No description provided for @deleteTask.
  ///
  /// In en, this message translates to:
  /// **'Delete Task'**
  String get deleteTask;

  /// No description provided for @sureDeleteTask.
  ///
  /// In en, this message translates to:
  /// **'Do you sure you want to delete this task?\n\nTitle: '**
  String get sureDeleteTask;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @taskList.
  ///
  /// In en, this message translates to:
  /// **'Task List'**
  String get taskList;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @noTasksYet.
  ///
  /// In en, this message translates to:
  /// **'No tasks yet'**
  String get noTasksYet;

  /// No description provided for @noTasksFound.
  ///
  /// In en, this message translates to:
  /// **'No tasks found'**
  String get noTasksFound;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error: '**
  String get error;

  /// No description provided for @thereIsNoTasks.
  ///
  /// In en, this message translates to:
  /// **'There is no tasks'**
  String get thereIsNoTasks;

  /// No description provided for @newTask.
  ///
  /// In en, this message translates to:
  /// **'New Task'**
  String get newTask;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @tasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @doYouSureWantLeaveApp.
  ///
  /// In en, this message translates to:
  /// **'Do you sure you want leave the app!'**
  String get doYouSureWantLeaveApp;

  /// No description provided for @markDone.
  ///
  /// In en, this message translates to:
  /// **'Mark as done'**
  String get markDone;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
