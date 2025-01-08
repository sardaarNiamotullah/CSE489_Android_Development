import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditScreen extends StatefulWidget {
  final Map<String, dynamic> entityData;

  const EditScreen({Key? key, required this.entityData}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _latController = TextEditingController();
  TextEditingController _lonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.entityData['title'];
    _latController.text = widget.entityData['lat'].toString();
    _lonController.text = widget.entityData['lon'].toString();
  }

  Future<void> _updateEntity() async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.parse('https://labs.anontech.info/cse489/t3/api.php');

      try {
        final response = await http.put(
          url,
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: {
            'id': widget.entityData['id'].toString(),
            'title': _titleController.text,
            'lat': _latController.text,
            'lon': _lonController.text,
          },
        );

        if (response.statusCode == 200) {
          // Successful update
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Entity updated successfully!'),
            ),
          );
          // Optionally, navigate back to the previous screen
          Navigator.pop(context);
        } else {
          // Handle error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to update entity.'),
            ),
          );
        }
      } catch (e) {
        // Handle network errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Network error: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Entity')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _latController,
                decoration: InputDecoration(labelText: 'Latitude'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a latitude';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lonController,
                decoration: InputDecoration(labelText: 'Longitude'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a longitude';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateEntity,
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}