


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { authenticated, unauthenticated }


class AuthCubit extends Cubit<AuthStatus> {
  AuthCubit() : super(AuthStatus.unauthenticated);

  Future<void> checkUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      emit(AuthStatus.authenticated);
    } else {
      emit(AuthStatus.unauthenticated);
    }
  }

  Future<void> loginUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString('registeredEmail');
    final storedPassword = prefs.getString('registeredPassword');

    if (email == storedEmail && password == storedPassword) {
      await prefs.setBool('isLoggedIn', true);
      emit(AuthStatus.authenticated);
    } else {
      throw Exception("Invalid email or password");
    }
  }

  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    emit(AuthStatus.unauthenticated);
  }

  Future<void> registerUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('registeredEmail', email);
    await prefs.setString('registeredPassword', password);
    await prefs.setBool('isLoggedIn', false); // Ensure the user is not logged in after registration
  }

  Future<void> updatePassword(String email, String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString('registeredEmail');

    if (email == storedEmail) {
      await prefs.setString('registeredPassword', newPassword);
    } else {
      throw Exception("Email not found");
    }
  }
}