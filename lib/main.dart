import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synkrama_task/%20bloc/auth_cubit.dart';

import 'screens/dashboard_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authCubit = AuthCubit();
  await authCubit.checkUserSession(); // Check user session on app startup
  runApp(
    BlocProvider(
      create: (context) => authCubit,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..checkUserSession(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthCubit, AuthStatus>(
          builder: (context, state) {
            if (state == AuthStatus.authenticated) {
              return DashboardScreen();
            } else {
              return SignInScreen();
            }
          },
        ),
      ),
    );
  }
}
