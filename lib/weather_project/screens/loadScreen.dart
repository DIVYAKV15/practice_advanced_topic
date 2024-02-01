import 'package:flutter/material.dart';
import 'package:practice_advanced_topic/weather_project/model/weatherModel.dart';
import 'package:practice_advanced_topic/weather_project/service/location.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: LoadingScreen(),
  ));
}
const apiKey="27129461971889cc77da0535b1edfb5c";//generated own api key
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? longitude;
  double? latitude;
  @override
  void initState() {
    // TODO: implement initState
    getLocation();
    super.initState();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    // print(location.longitude);
    // print(location.latitude);
   latitude=location.latitude;
   longitude=location.longitude;
  }

 void getData() async {
   var response=await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey"),);
    //in response contain body,satuscode and all
    // to check the resoonse is success
    if (response.statusCode == 200) {
      var data = response.body;
       print(data);
      //return waetherModelFromJson(data);
    } else {
      print(response.statusCode);
      // var data = response.body;
      // return waetherModelFromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: MaterialButton(
            onPressed: () {
              getData(); //we can add this in init state but you want to rebuilt everytime to access this
            },
            child: Text("Get Location"),
          ),
        ),
      ),
    );
  }
}
