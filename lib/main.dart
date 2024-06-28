import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_application/auth/auth.dart';
import 'package:news_application/firebase_options.dart';
import 'package:news_application/pages/home_screen.dart';
import 'package:news_application/provider/favouriteProvider.dart';
import 'package:news_application/themes/theme_provider.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
      WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteNewsProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(), // Wrap CategoriesPage with the MultiProvider
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
