// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'English';

  @override
  String get appName => 'My Tasks';

  @override
  String get welcomeBack => 'Welcome Back!';

  @override
  String get welcome => 'Welcome!';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get loginDescription =>
      'Please fill the forms below to get started.\nif you are not member yet, please clock on Register now below';

  @override
  String get registerDescription =>
      'Please fill in the form below to create your account.\nIf you already have an account, please click on \"Sign In\" below.';

  @override
  String get loginNow => 'Login Now';

  @override
  String get registerNow => 'Login Now';

  @override
  String get name => 'Name';

  @override
  String get enterName => 'Enter Your Name';

  @override
  String get email => 'Email';

  @override
  String get enterEmail => 'Enter your email address';

  @override
  String get password => 'Password';

  @override
  String get enterPassword => 'Enter your email address';

  @override
  String get validatorsInvalidEmail => 'Please enter a valid email address!';

  @override
  String get validatorsEmailRequired => 'Email is required';

  @override
  String get validatorsPasswordRequired => 'Password is required';

  @override
  String get validatorLongPassword => 'Password must be at least 6 characters';

  @override
  String get validatorPasswordsNotMatch => 'passwords not match';

  @override
  String get validatorsNameRequired => 'Name is required';

  @override
  String get validatorLongName => 'Name must be at least 6 characters';

  @override
  String get validatorsPhoneRequired => 'Phone number is required';

  @override
  String get notMember => 'Not a member?';
}
