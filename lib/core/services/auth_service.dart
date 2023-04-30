import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  late String _accessToken;
  late String _refreshToken;

  Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('access_token') ?? '';
    return _accessToken;
  }

  Future<String> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    _refreshToken = prefs.getString('refresh_token') ?? '';
    return _refreshToken;
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }

  Future<void> deleteTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    _accessToken = '';
    _refreshToken = '';
  }
}
