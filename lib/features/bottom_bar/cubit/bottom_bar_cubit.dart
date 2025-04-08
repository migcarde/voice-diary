import 'package:bloc/bloc.dart';
import 'package:core/core.dart';

part 'bottom_bar_state.dart';

class BottomBarCubit extends Cubit<BottomBarState> {
  BottomBarCubit() : super(const BottomBarState());

  void selectTab({
    required BottomBarTabs selectedTab,
  }) =>
      emit(
        state.copyWith(
          selectedTab: selectedTab,
        ),
      );
}
