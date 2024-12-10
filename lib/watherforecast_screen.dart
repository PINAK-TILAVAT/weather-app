import 'package:flutter/material.dart';

class WeatherForecastItem extends StatelessWidget {
  final String time;
  final IconData wather;
  final String temp;
  const WeatherForecastItem({
    super.key, required this.time, required this.wather, required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0 , bottom: 15),
      child: SizedBox(
        height: 140,
        width: 100,
        child: Card
        (
          color: Colors.black,
          elevation: 10,
          shadowColor: Colors.white,
      
          child: Column
          (
            mainAxisAlignment: MainAxisAlignment.center,
            children: 
            [
              Text
              (
                time,
                style: const TextStyle
                (
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5,),
              Icon
              (
                wather,
                size: 30,
              ),
              const SizedBox(height: 7,),
      
              Text
              (
                temp,
                style: const TextStyle
                (
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
              )
      
            ],
          ),
        ),
      ),
    );
  }
}

