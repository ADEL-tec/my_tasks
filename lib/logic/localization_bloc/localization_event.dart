part of 'localization_bloc.dart';

@immutable
sealed class LocalizationEvent {}

class OnLocalizationEnglishEvent extends LocalizationEvent {}

class OnLocalizationArabicEvent extends LocalizationEvent {}
