// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:genius/home_screen.dart';
import 'package:genius/l10n/l10n.dart';
import 'package:genius/login_screen.dart';
import 'package:genius/providers/favourites_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider(),
          ),
          ChangeNotifierProvider<FavouritesProvider>(
            create: (context) => FavouritesProvider(),
          ),
        ],
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return const HomeScreen();
            }
            return LoginScreen();
          },
        ),
      ),
    );
  }
}
