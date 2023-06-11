import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location ; //name of user friendly location
  late String time ; // the time in location
  String flag ;
  String url ; // location url for api end point
  late bool isDayTime ; // true or false if day time or not

  WorldTime({required this.location, required this.url, required this.flag});

  Future<void> getTime() async{

    try {
      //make request
      Response response = await get('https://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      String offset2 = data['utc_offset'].substring(4,6);
      print(datetime);
      print(offset);

      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset), minutes: int.parse(offset2)));

      //set time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
      print(time);

    }
    catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }


  }

}