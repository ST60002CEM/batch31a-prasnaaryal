import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ThemeModeType {
  light,
  dark,
}

class ThemeModeNotifier extends StateNotifier<ThemeModeType> {
  ThemeModeNotifier(ThemeModeType state) : super(state);

  void toggleTheme() {
    state = state == ThemeModeType.light ? ThemeModeType.dark : ThemeModeType.light;
  }
}

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeModeType>((ref) {
  return ThemeModeNotifier(ThemeModeType.light);
});
