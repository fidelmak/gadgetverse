import 'dart:convert';
import 'package:http/http.dart' as http;

const baseUrl = "https://api.timbu.cloud/products";
const apiKey = "6cb3b3211bfb4aa2a03ce757a2f8ad1820240704190944481226";
const orgId = "4a8b1c9a46d4454b969b5a894d259e69";
const appId = "KWFOVINJ6PHXJ10";

class Service {
  Future<List<dynamic>> fetchProducts() async {
    try {
      var response = await http.get(
        Uri.parse('$baseUrl?Apikey=$apiKey&organization_id=$orgId&Appid=$appId'),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data['items']; // Returning the list of items
      } else {
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
