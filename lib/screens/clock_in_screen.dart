import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ClockInScreen extends StatefulWidget {
  @override
  _ClockInScreenState createState() => _ClockInScreenState();
}

class _ClockInScreenState extends State<ClockInScreen> {
  Position? _currentPosition;
  bool _isOnSite = false;

  Future<void> _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _isOnSite = _checkIfOnSite(position);
    });
  }

  bool _checkIfOnSite(Position position) {
    // Placeholder logic to check if user is on site
    double distance = Geolocator.distanceBetween(
        position.latitude, position.longitude, 13.7563, 100.5018);
    return distance < 100;  // Check if within 100 meters of the location
  }

  Future<void> _clockIn() async {
    if (_isOnSite) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Clocked In!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You are not on-site!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clock In/Out')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _getLocation,
            child: Text('Get Location'),
          ),
          Text(_currentPosition != null
              ? 'Location: ${_currentPosition!.latitude}, ${_currentPosition!.longitude}'
              : 'No Location'),
          ElevatedButton(
            onPressed: _clockIn,
            child: Text('Clock In'),
          ),
        ],
      ),
    );
  }
}
