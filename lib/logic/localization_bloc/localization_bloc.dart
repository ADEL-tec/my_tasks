import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../core/values/constants.dart';
import '../../global.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc()
    : super(LocalizationState(Global.storageService.getLocalization ?? "en")) {
    on<OnLocalizationEnglishEvent>(onLocalizationEnglishEvent);
    on<OnLocalizationArabicEvent>(onLocalizationArabicEvent);
  }

  FutureOr<void> onLocalizationEnglishEvent(
    OnLocalizationEnglishEvent event,
    Emitter<LocalizationState> emit,
  ) {
    emit(LocalizationState("en"));
    Global.storageService.setString(AppConstants.STORAGE_LOCALIZATION, 'en');
  }

  FutureOr<void> onLocalizationArabicEvent(
    OnLocalizationArabicEvent event,
    Emitter<LocalizationState> emit,
  ) {
    emit(LocalizationState("ar"));
    Global.storageService.setString(AppConstants.STORAGE_LOCALIZATION, 'ar');
  }
}
