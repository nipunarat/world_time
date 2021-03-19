import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class WorldTime{
  String location; //location name for the UI
  String time;// time in that location
  String flag; // url to assest flag icon
  String url; //location url for api endpoint

  WorldTime({this.location,this.flag,this.url});

  Future<void> getTime() async{
    //make request
    Response response = await get('http://worldtimeapi.org/api/timezone/$url');
    Map data = jsonDecode(response.body);


    //get properties from data
    String datetime = data['datetime'];
    String offsetHour = data['utc_offset'].substring(1,3);
    String offsetMinute = data['utc_offset'].substring(4,6);

    //create DateTime object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offsetHour),minutes: int.parse(offsetMinute)));

    //set time property
    time = now.toString();
  }
}

