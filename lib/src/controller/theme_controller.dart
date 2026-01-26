import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController implements GetxService {
  final String _themeKey_ = "_theme____key_";
  final SharedPreferences sharedPreferences;

  ThemeController({required this.sharedPreferences}) {
    _loadCurrentTheme();
  }

  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    // Get.changeTheme(_isDarkTheme ? darkTheme : lightTheme);
    // sharedPreferences.setBool(_themeKey_, _isDarkTheme);
  }

  void _loadCurrentTheme() async {
    _isDarkTheme = sharedPreferences.getBool(_themeKey_) ?? false;
  }
}
