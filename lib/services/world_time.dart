import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location; // location name for the UI
  late String time; //the time in that location
  late String flag; //ulr to asset flag
  late String url; //the location url for API endpoint
  late bool isDaytime; //t/f day/night

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      //make the request
      Response response =
          await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      // print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //setting time property
      isDaytime = (now.hour > 6 && now.hour < 21) ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print("caught error: $e");
      time = 'could not load data';
    }
  }
}
