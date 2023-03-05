import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyBxaeFqnv6zq1BHo3hRfzoVsigK0B235-I';

class LocationHelper{
  static String generateLocationPreviewImage({double? latitude , double? longitude}){
    print(latitude);
    // return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Hlabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY' ;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$latitude,$longitude&markers=color:red%7Clabel:C%7C40.718217,-73.998284&key=$GOOGLE_API_KEY';
  }

  static Future<String> getLocationAddress(double lat, double lon)async{
    final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&key=$GOOGLE_API_KEY');
    final responce = await http.get(url);
    return json.decode(responce.body)['results'][0]['formatted_address'];
  }
}