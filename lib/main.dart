import 'package:flutter/material.dart';
import 'services/firebase_service.dart';
import 'screens/login_screen.dart';
import 'screens/clock_in_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/history_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initializeFirebase(); // Initialize Firebase before app launch
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Check-in App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AuthGate(), // Checks if the user is logged in
        '/dashboard': (context) => DashboardScreen(),
        '/clockin': (context) => ClockInScreen(),
        '/calendar': (context) => ShiftCalendarScreen(),
        '/history': (context) => HistoryScreen(),
      },
    );
  }
}

// Checks if user is logged in and directs to appropriate screen
class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            return LoginScreen();  // If user is not logged in, show login screen
          } else {
            return DashboardScreen();  // If user is logged in, show dashboard
          }
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

// Dashboard for the app
class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/', (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/clockin');
            },
            child: Text('Clock In/Out'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/calendar');
            },
            child: Text('Shift Calendar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
            child: Text('Clock-In History'),
          ),
        ],
      ),
    );
  }
}
