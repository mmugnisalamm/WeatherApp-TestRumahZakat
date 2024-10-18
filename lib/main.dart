import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/ui/screen/weather_login/login_screen.dart';
import 'config/size.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Technical Test Weather Forecast',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 252, 251, 255)),
        useMaterial3: true,
      ),
      home: Builder(
        builder: (context) {
          Size.init(context); // Inisialisasi ukuran di sini
          return const MyHomePage(); // Ganti dengan widget utama kamu
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginScreen(),
    );
  }


}
