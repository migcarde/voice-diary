import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:voice_diary/core/app_theme.dart';
import 'package:voice_diary/features/bottom_bar/cubit/bottom_bar_cubit.dart';
import 'package:voice_diary/features/home/records/cubit/records_cubit.dart';
import 'package:voice_diary/features/home/records/records_filters/cubit/records_filters_cubit.dart';
import 'package:voice_diary/l10n/app_localizations.dart';
import 'package:voice_diary/l10n/app_localizations_en.dart';
import 'package:voice_diary/routing/paths.dart';
import 'package:voice_diary/routing/routes.dart';
import 'package:voice_diary/widgets/base_text_field.dart';
import 'package:voice_diary/widgets/primary_chip.dart';

class MockBottomBarCubit extends MockCubit<BottomBarState>
    implements BottomBarCubit {}

class MockRecordsCubit extends MockCubit<RecordsState>
    implements RecordsCubit {}

class MockRecordsFiltersCubit extends MockCubit<RecordsFiltersState>
    implements RecordsFiltersCubit {}

void main() {
  late MockBottomBarCubit bottomBarCubit;
  late MockRecordsCubit recordsCubit;
  late MockRecordsFiltersCubit recordsFiltersCubit;

  setUpAll(() {
    bottomBarCubit = MockBottomBarCubit();
    recordsCubit = MockRecordsCubit();
    recordsFiltersCubit = MockRecordsFiltersCubit();
    getIt.registerFactory<BottomBarCubit>(() => bottomBarCubit);
    getIt.registerFactory<RecordsCubit>(() => recordsCubit);
    getIt.registerFactory<RecordsFiltersCubit>(() => recordsFiltersCubit);
  });

  tearDownAll(() {
    recordsFiltersCubit.close();
    getIt.unregister<BottomBarCubit>();
    getIt.unregister<RecordsCubit>();
    getIt.unregister<RecordsFiltersCubit>();
  });

  group('Search filters', () {
    final tags = {'tag1', 'tag2', 'tag3'};
    testWidgets('call search filters on tap search icon',
        (WidgetTester tester) async {
      when(() => bottomBarCubit.state).thenReturn(BottomBarState());
      when(() => recordsCubit.state).thenReturn(
        RecordsState(status: RecordsStatus.data),
      );
      when(() => recordsFiltersCubit.state).thenReturn(
        RecordsFiltersState(
          tags: tags,
          filteredTags: tags,
        ),
      );
      when(() => recordsCubit.init()).thenAnswer((_) async {});
      when(() => recordsFiltersCubit.init(tags)).thenAnswer((_) async {});
      when(() => recordsFiltersCubit.searchTag('tag1'))
          .thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp.router(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          routerConfig: GoRouter(
            initialLocation: Paths.home,
            routes: Routes.list,
          ),
        ),
      );

      await tester.runAsync(
        () async => await tester.tap(
          find.byIcon(
            PhosphorIcons.funnelSimple(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(AppLocalizationsEn().filter_by_tag), findsOneWidget);
      expect(find.byType(PrimaryChip), findsNWidgets(3));

      await tester.enterText(find.byType(BaseTextField), 'tag1');
      await tester.tap(find.byIcon(PhosphorIcons.magnifyingGlass()));
      await tester.pumpAndSettle();
      verify(() => recordsFiltersCubit.searchTag('tag1')).called(1);
    });
  });

  group('Search filters', () {
    final tags = {'tag1', 'tag2', 'tag3'};
    testWidgets('call search filters on tap search icon',
        (WidgetTester tester) async {
      when(() => bottomBarCubit.state).thenReturn(BottomBarState());
      when(() => recordsCubit.state).thenReturn(
        RecordsState(status: RecordsStatus.data),
      );
      when(() => recordsFiltersCubit.state).thenReturn(
        RecordsFiltersState(
          tags: tags,
          filteredTags: tags,
        ),
      );
      when(() => recordsCubit.init()).thenAnswer((_) async {});
      when(() => recordsFiltersCubit.init(tags)).thenAnswer((_) async {});
      when(() => recordsFiltersCubit.searchTag('tag1'))
          .thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp.router(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          routerConfig: GoRouter(
            initialLocation: Paths.home,
            routes: Routes.list,
          ),
        ),
      );

      await tester.runAsync(
        () async => await tester.tap(
          find.byIcon(
            PhosphorIcons.funnelSimple(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(AppLocalizationsEn().filter_by_tag), findsOneWidget);
      expect(find.byType(PrimaryChip), findsNWidgets(3));

      await tester.enterText(find.byType(BaseTextField), 'tag1');
      await tester.tap(find.byIcon(PhosphorIcons.magnifyingGlass()));
      await tester.pumpAndSettle();
      verify(() => recordsFiltersCubit.searchTag('tag1')).called(1);
    });
  });

  group('Set filters', () {
    final tags = {'tag1', 'tag2', 'tag3'};
    testWidgets('call select tag on tap a tag', (WidgetTester tester) async {
      when(() => bottomBarCubit.state).thenReturn(BottomBarState());
      when(() => recordsCubit.state).thenReturn(
        RecordsState(status: RecordsStatus.data),
      );
      when(() => recordsFiltersCubit.state).thenReturn(
        RecordsFiltersState(
          tags: tags,
          filteredTags: tags,
        ),
      );
      when(() => recordsCubit.init()).thenAnswer((_) async {});
      when(() => recordsFiltersCubit.init(tags)).thenAnswer((_) async {});
      when(() => recordsFiltersCubit.addTag('tag1')).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp.router(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          routerConfig: GoRouter(
            initialLocation: Paths.home,
            routes: Routes.list,
          ),
        ),
      );

      await tester.runAsync(
        () async => await tester.tap(
          find.byIcon(
            PhosphorIcons.funnelSimple(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(AppLocalizationsEn().filter_by_tag), findsOneWidget);
      expect(find.byType(PrimaryChip), findsNWidgets(3));

      await tester.tap(find.text('tag1'));
      await tester.pumpAndSettle();
      verify(() => recordsFiltersCubit.addTag('tag1')).called(1);
    });

    testWidgets('call remove tag on tap a selected tag',
        (WidgetTester tester) async {
      when(() => bottomBarCubit.state).thenReturn(BottomBarState());
      when(() => recordsCubit.state).thenReturn(
        RecordsState(status: RecordsStatus.data),
      );
      when(() => recordsFiltersCubit.state).thenReturn(
        RecordsFiltersState(
          tags: tags,
          filteredTags: {'tag2', 'tag3'},
          selectedTags: {'tag1'},
        ),
      );
      when(() => recordsCubit.init()).thenAnswer((_) async {});
      when(() => recordsFiltersCubit.init(tags)).thenAnswer((_) async {});
      when(() => recordsFiltersCubit.removeTag('tag1'))
          .thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp.router(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale('en'),
          theme: AppTheme.mainTheme(),
          routerConfig: GoRouter(
            initialLocation: Paths.home,
            routes: Routes.list,
          ),
        ),
      );

      await tester.runAsync(
        () async => await tester.tap(
          find.byIcon(
            PhosphorIcons.funnelSimple(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(AppLocalizationsEn().filter_by_tag), findsOneWidget);
      expect(find.byType(PrimaryChip), findsNWidgets(3));

      await tester.tap(find.text('tag1'));
      await tester.pumpAndSettle();
      verify(() => recordsFiltersCubit.removeTag('tag1')).called(1);
    });
  });
}
