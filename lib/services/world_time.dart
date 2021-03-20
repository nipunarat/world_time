import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class WorldTime {
  String location; //location name for the UI
  String time; // time in that location
  String flag; // url to assest flag icon
  String url; //location url for api endpoint
  bool isDaytime;//true or false if daytime or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      //make request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      //get properties from data
      String datetime = data['datetime'];
      String offsetHour = data['utc_offset'].substring(1, 3);
      String offsetMinute = data['utc_offset'].substring(4, 6);

      //create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offsetHour), minutes: int.parse(offsetMinute)));

      //set time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }
}
