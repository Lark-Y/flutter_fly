import 'package:flutter/material.dart';
import 'package:flutter_fly/pages/home/home_page.dart';
import 'package:flutter_fly/pages/routes/Routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RootPage();
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  bool _ignoring = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Fly',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Color(0xFF5DC782),
        backgroundColor: const Color(0xFFF2F2F2)
      ),
      routes: Routes.routes,
      initialRoute: Routes.home_page,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
