part of 'bottom_bar_cubit.dart';

enum BottomBarTabs {
  records,
  settings;

  bool get isRecords => this == BottomBarTabs.records;
  bool get isSettings => this == BottomBarTabs.settings;
}

class BottomBarState extends Equatable {
  final BottomBarTabs selectedTab;

  const BottomBarState({
    this.selectedTab = BottomBarTabs.records,
  });

  @override
  List<Object?> get props => [
        selectedTab,
      ];

  BottomBarState copyWith({
    BottomBarTabs? selectedTab,
  }) =>
      BottomBarState(
        selectedTab: selectedTab ?? this.selectedTab,
      );
}
