
import 'package:flutter/material.dart';

class AdditionalInfoScreen extends StatelessWidget {
  final IconData logo;
  final String lable;
  final String value;
  const AdditionalInfoScreen({
    super.key, required this.logo, required this.lable, required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return  Column
    (
      children: 
      [
        Icon(
          logo
        ),
        
        Text
        (
          lable
        ),
    
        Text
        (
          value
        )
    
        
      ],
    );
  }
}