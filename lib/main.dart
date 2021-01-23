import 'package:flutter/material.dart';
import './screens/detail_screen.dart';
import './screens/main_screen.dart';
import 'package:provider/provider.dart';
import './screens/edit_note.dart';
import './providers/provider_products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (ctx) => ProviderProducts(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainScreen(),
        routes: {
          DetailScreen.routeName: (ctx) => DetailScreen(),
          EditNote.routeName: (ctx) => EditNote(),
        },
      ),
    );
  }
}

