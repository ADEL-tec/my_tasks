// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get language => 'العربية';

  @override
  String get appName => 'مهامي';

  @override
  String get welcomeBack => 'مرحبًا بعودتك!';

  @override
  String get login => 'Login';

  @override
  String get loginDescription =>
      'يرجى ملء النماذج أدناه للبدء.\n إذا لم تكن عضوًا بعد، فيرجى تسجيل الدخول الآن أدناه';

  @override
  String get email => 'البريد إلكتروني';

  @override
  String get enterEmail => 'أدخل عنوان بريدك الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get enterPassword => 'أدخل عنوان بريدك الإلكتروني';

  @override
  String get validatorsInvalidEmail => 'يرجى إدخال عنوان بريد إلكتروني صالح!';

  @override
  String get validatorsEmailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get validatorsPasswordRequired => 'كلمة المرور مطلوبة';

  @override
  String get validatorLongPassword =>
      'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';

  @override
  String get validatorPasswordsNotMatch => 'كلمات المرور غير متطابقة';

  @override
  String get validatorsNameRequired => 'الاسم مطلوب';

  @override
  String get validatorLongName => 'يجب أن يتكون الاسم من 6 أحرف على الأقل';

  @override
  String get validatorsPhoneRequired => 'رقم الهاتف مطلوب';
}
