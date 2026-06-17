part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class ThemeChangeMode extends AppState {
  final bool isDark;
  ThemeChangeMode({required this.isDark});
}