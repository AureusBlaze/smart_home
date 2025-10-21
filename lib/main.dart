import 'package:flutter/material.dart';
import 'package:smart_home/approutes.dart';
import 'package:smart_home/auth/auth_gate.dart';
// import 'package:smart_home/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  //supabase

  await Supabase.initialize(
    url: 'https://oybhvuzhsffrhoqtfgty.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im95Ymh2dXpoc2ZmcmhvcXRmZ3R5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTYzNDkxMTIsImV4cCI6MjA3MTkyNTExMn0.eHu3U6MKyzikHRznm34x9naz2fjVBDbTn4Q60OnUFJk',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Home App',
      routes: Approutes.routes(),
      initialRoute: '/AuthGate',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (_) => const AuthGate());
        }
        return null;
      },
    );
    // return MaterialApp(debugShowCheckedModeBanner: false, home: AuthGate());
  }
}
