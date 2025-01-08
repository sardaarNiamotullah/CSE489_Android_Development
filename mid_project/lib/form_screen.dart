import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _latController = TextEditingController();
  TextEditingController _lonController = TextEditingController();
  TextEditingController _imageController = TextEditingController();

  Future<void> _createEntity() async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.parse('https://labs.anontech.info/cse489/t3/api.php');

      try {
        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: {
            'title': _titleController.text,
            'lat': _latController.text,
            'lon': _lonController.text,
            'image': _imageController.text,
          },
        );

        if (response.statusCode == 200) {
          // Successful creation
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Entity created successfully!'),
            ),
          );
          // Optionally, navigate back to the previous screen
          // Navigator.pop(context);
        } else {
          // Handle error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to create entity.'),
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
      appBar: AppBar(title: Text('Create Entity')),
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
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(labelText: 'Image'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createEntity,
                child: Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}