import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  late String time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location for api endpoint

  WorldTime({required this.location, required this.flag, required this.url});

  // Future<void> getTime() async {
  //   // make the request
  //   Response response = await get(
  //     Uri.parse('https://worldtimeapi.org/api/timezone/$url'),
  //   );
  //   Map data = jsonDecode(response.body);

  //   // get properties from data
  //   String datetime = data['datetime'];
  //   String offset = data['utc_offset'].substring(1, 3);

  //   // create DateTime Object
  //   DateTime now = DateTime.parse(datetime);
  //   now = now.add(Duration(hours: int.parse(offset)));

  //   // Set the time property
  //   time = now.toString();
  // }

  Future<void> getTime() async {
    try {
      final response = await get(
        Uri.parse('https://timeapi.io/api/TimeZone/zone?timeZone=$url'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to get time');
      }

      final data = jsonDecode(response.body);
      final datetime = DateTime.parse(data['currentLocalTime']);

      time = DateFormat.jm().format(datetime);
    } catch (e) {
      print('Error getting time: $e');
      time = 'Could not fetch time data';
    }
  }
}
