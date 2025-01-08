import 'package:flutter/material.dart';
import 'api_service.dart';
import 'edit_screen.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final ApiService apiService = ApiService();
  dynamic _listData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final data = await apiService.fetchData();
      setState(() {
        _listData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _listData == null
          ? Center(child: Text('No data available'))
          : ListView.builder(
        itemCount: _listData.length,
        itemBuilder: (context, index) {
          Color backgroundColor = index % 2 == 0 ? Colors.grey[200]! : Colors.white;
          return Container(
            color: backgroundColor,
            child: ListTile(
              title: Text('ID: ${_listData[index]['id']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: ${_listData[index]['title']}'),
                  Text('Latitude: ${_listData[index]['lat']}'),
                  Text('Longitude: ${_listData[index]['lon']}'),
                ],
              ),
              trailing: GestureDetector(
                onTap: () {
                  // Implement edit functionality here
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditScreen(
                        entityData: _listData[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 60,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'EDIT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}