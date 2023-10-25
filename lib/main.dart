import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/provider_party_view.dart';
import 'provider/provider_info_view.dart';
import './provider/provider_ledamot.dart';
import './provider/provider_calendar.dart';
import 'provider/provider_home_view.dart';
import 'screens/home_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProviderPartyView(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProviderLedamot(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProviderHomeView(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProviderInfoView(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProviderCalendarView(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
