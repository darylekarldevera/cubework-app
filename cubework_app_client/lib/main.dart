import 'package:flutter/material.dart';
import 'package:cubework_app_client/screens/explore_screen.dart';
import 'package:cubework_app_client/screens/my_account_screen.dart';
import 'package:permission_handler/permission_handler.dart';

// this is to allow the google map 'myLocationButtonEnabled' and 'myLocationEnabled' to work
void setPermissions() async {
  PermissionStatus status = await Permission.location.request();
  if (status.isGranted) {
    print("Location permission granted");
  } else if (status.isDenied) {
    print("Location permission denied");
  } else if (status.isPermanentlyDenied) {
    print("Location permission permanently denied");
    openAppSettings();
  }
}

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    setPermissions();
    runApp(const MainApp());
  } catch (error) {
    print("Error: $error");
  }
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
          ExploreScreen(),
          MyAccountScreen(),
          Center(child: Text("Orders")),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: DefaultTabController(
        length: 3, // Change this to 3 to match the number of tabs
        child: Scaffold(
          appBar: AppBar(),
          bottomNavigationBar: _tabBar,
          body: _tabBarView,
        ),
      ),
    );
  }
}
