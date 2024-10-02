import 'package:cubework_app_client/screens/my_account_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  TabBar get _tabBar => const TabBar(
    labelColor: Color(0xFF229E1B),
    tabs: [
      Tab(icon: Icon(Icons.home), text: "Home"),
      Tab(icon: Icon(Icons.person), text: "My Account"),
      Tab(icon: Icon(Icons.list), text: "Orders"),
    ],
  );

  TabBarView get _tabBarView => const TabBarView(
    children: [
      Center(child: Text("Home")),
      MyAccountScreen(),
      Center(child: Text("Orders")),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: DefaultTabController(
        length: 5, 
        child: Scaffold(
          appBar: AppBar(),
          bottomNavigationBar: _tabBar,
          body: _tabBarView,
        )
      )
    );
  }
}
