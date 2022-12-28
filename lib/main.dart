import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:band_name/ui/pages/home/home.dart';
import 'package:band_name/ui/pages/status/status.dart';
import 'package:band_name/services/socket_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
     MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SocketService())
      ],
      child: MaterialApp(
        title: 'Band app',
        debugShowCheckedModeBanner: false,
        initialRoute: 'status',
        routes: {
          'home': (_) => HomePage(),
          'status': (_) => StatusPage()
        },
      ),
    );
  }
}