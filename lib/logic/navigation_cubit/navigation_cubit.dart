import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../core/routes/routes.dart';
import '../../core/values/constants.dart';
import '../../global.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit()
    : super(NavigationState(Global.storageService.getSelectedPageIndex ?? 0)) {
    _loadIndex();
  }

  // Load saved index mode from SharedPreferences
  Future<void> _loadIndex() async {
    print("nav index=> ${Global.storageService.getSelectedPageIndex}");
    if (Global.storageService.getSelectedPageIndex == null) {
      emit(NavigationState(0));
      Global.storageService.setInt(AppConstants.STORAGE_NAVIGATION_INDEX, 0);
    } else {
      emit(NavigationState(Global.storageService.getSelectedPageIndex!));
    }
  }

  // Change theme mode
  Future<void> setPageIndex(int index) async {
    emit(NavigationState(index));
    await Global.storageService.setInt(
      AppConstants.STORAGE_NAVIGATION_INDEX,
      index,
    );
  }
}
