import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_en/packages/quote/quote.dart';
import 'page/landing_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Quotes().getAll();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Landingpage(),
    );
    
  }
}