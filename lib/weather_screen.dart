import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_andriod/additional_info_screen.dart';
import 'package:weather_app_andriod/watherforecast_screen.dart';
import 'package:http/http.dart' as http;


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  late Future<Map<String , dynamic>> weather;
  Future<Map<String , dynamic>> getCurrentWeather() async 
  {
    

    try 
    {
    final res = await http.get(Uri.parse("http://api.openweathermap.org/data/2.5/forecast?q=London,uk&APPID=8cc7b47c5fe774bef1afeb36ae8abe64"));
    final data = jsonDecode(res.body);
    
    return data;
    } 
    catch (e) 
    {
      throw e.toString();   
    }
  }
  
  @override
  void initState() {
    
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        actions: 

        [
          Padding(
            padding: const EdgeInsets.only(right :12.0),
            child: IconButton
            (
              color: Colors.blue,
              iconSize: 30,
              onPressed: () 
              {
                setState(() {
                  weather = getCurrentWeather();
                });
              }, 
              icon: const Icon
              (
                Icons.refresh_sharp
                )
            ),
          )
        ],
        backgroundColor: Colors.black,
        centerTitle: true,
        title:  const Text
        (
          
          "WEATHER APP",
          style: TextStyle
          (
            fontSize: 25,
            color: Colors.lightBlueAccent,
            fontWeight: FontWeight.bold,
            letterSpacing: 4
          ),
        ),
      ),
      
      body:FutureBuilder(
        future: getCurrentWeather(),
        builder: (context , snapshot) {
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator(); 
          }

          final data = snapshot.data;

          final currentTemp = data!['list'][0]['main']['temp'];
          final currentWeather = data['list'][0]['weather'][0]['main'];
          final humidity = data['list'][0]['main']['humidity'];
          final presuure = data['list'][0]['main']['pressure'];
          final windSpeed = data['list'][0]['wind']['speed'];

        return  Padding
        (
          padding: const  EdgeInsets.only(left : 20.0 , right: 20 , top: 30 ),
          child: SizedBox
          (
            child: SingleChildScrollView(
              child: Column
              (
                children: 
                [
                  SizedBox
                  (
                    height: 250,
                    width: double.infinity,
                    child: Card
                    (
                      color: Colors.black,
                      elevation: 10,
                      shadowColor: Colors.blue,
              
                      child: Column
                      (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: 
                        [
                          Text
                          (
                            "$currentTemp K",
                            style:  const  TextStyle
                            (
                              fontSize: 40
              
                            ),
                          ),
              
                           const SizedBox(height: 10,),
              
                           Icon
                          (
                            currentWeather == 'Clouds' 
                            ?Icons.cloud
                            :Icons.sunny,

                            size: 70,
                          ),
                           const SizedBox(height: 10,),
                           Text
                          (
                            "$currentWeather",
                            style:  const  TextStyle
                            (
                              color: Colors.lightBlueAccent,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4
                            ),
                            
                          )
              
                        ],
                      ),
                    ),
                  ),
              
                  const  SizedBox(height: 30,),
              
                   SizedBox
                  (
                    height: 250,
                    width: double.infinity,
                    child: Card
                    (
                      color: Colors.black,
                      elevation: 10,
                      shadowColor: Colors.blue,
              
                      child: Column
                      (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: 
                        [
                          const Text
                          (
                            "24 / 7 FORECAST",
                            style: TextStyle
                            (
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlueAccent,
                              letterSpacing: 4
                            ),
                          ),
                          const SizedBox(height: 15,),
                          SizedBox(
                            height: 150,
                            
                            child: ListView.builder
                            (
                              scrollDirection: Axis.horizontal,
                              itemCount: 8,
                              itemBuilder: (BuildContext context, int index) 
                              {
                                final forecastItem = data['list'][index +1];
                                final time = DateTime.parse(forecastItem['dt_txt'].toString());
                                return WeatherForecastItem
                                (
                                  time: DateFormat.j().format(time) , 
                                  wather: Icons.abc, 
                                  temp: forecastItem['main']["temp"].toString()
                                );
                            
                              },
                              
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
              
                   const SizedBox(height: 30,),
              
                  SizedBox
                  (
                    height: 200,
                    width: double.infinity,
                    child: Card
                    (
                      color: Colors.black,
                      elevation: 10,
                      shadowColor: Colors.blueAccent,
              
                      child: Column
                      (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: 
                        [
                          
                          const  Text
                          (
                            "ADDITIONAL INFORMATION",
                            style: TextStyle
                            (
                              fontSize: 21,
                              color: Colors.lightBlueAccent,
                              letterSpacing: 0
                            ),
                          ),
        
                           const SizedBox(height: 25,),
        
                          Row
                          (
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: 
                            [
                              
                              AdditionalInfoScreen(logo: Icons.water_drop, lable: "Humidity", value: "$humidity",),
                              AdditionalInfoScreen(logo: Icons.air, lable: "Wind Speed", value: "$windSpeed",),
                              AdditionalInfoScreen(logo: Icons.arrow_downward_sharp, lable: "Preassure", value: "$presuure",),
                              
                              
              
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              
              ),
            ),
          ), 
        );
        },
      ),
    );
  }
}

  

  

