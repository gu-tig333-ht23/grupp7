import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './party_view/party_provider.dart';
import './provider/provider_infoview.dart';
import './provider/provider_ledamot.dart';
import './provider/provider_calendar.dart';
import 'provider/provider_homeview.dart';
import 'screens/home_view.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PartyViewState(),
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
