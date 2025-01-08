import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'app_drawer.dart';
import 'api_service.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final ApiService apiService = ApiService();
  dynamic _latloninfo;
  bool _isLoading = true;
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final data = await apiService.fetchData();
      setState(() {
        _latloninfo = data;
        _isLoading = false;
        _markers = _latloninfo.map<Marker>((location) {
          return Marker(
            width: 40.0,
            height: 40.0,
            point: LatLng(location['lat'].toDouble(), location['lon'].toDouble()),
            child: GestureDetector(
              onTap: () {
                _showLocationPopup(context, location['lat'], location['lon']);
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: Icon(
                  Icons.location_on,
                  size: 30,
                  color: Colors.red,
                ),
              ),
            ),
          );
        }).toList();
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching data: $e');
    }
  }

  void _showLocationPopup(BuildContext context, double lat, double lon) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location'),
          content: Text('Latitude: $lat\nLongitude: $lon'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;
    if (_isLoading) {
      bodyContent = Center(child: CircularProgressIndicator());
    } else {
      if (_latloninfo == null) {
        bodyContent = Center(child: Text('No data available'));
      } else {
        bodyContent = FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(23.6850, 90.3563),
            initialZoom: 7.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),
            MarkerLayer(markers: _markers),
          ],
        );
      }
    }
    return Scaffold(
      appBar: AppBar(title: Text('Map Screen')),
      drawer: AppDrawer(),
      body: bodyContent,
    );
  }
}