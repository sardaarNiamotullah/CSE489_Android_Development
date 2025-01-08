import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  // Function to fetch data from the API and return it
  Future<dynamic> fetchData() async {
    final response = await http.get(Uri.parse('https://labs.anontech.info/cse489/t3/api.php'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON and return it
      var data = json.decode(response.body);
      return data; // Return the parsed JSON data
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to load data');
    }
  }
}
