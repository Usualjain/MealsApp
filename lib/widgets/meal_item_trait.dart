import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget{
  
  MealItemTrait({
    super.key,
    required this.icon,
    required this.label
  }); 

  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    
    return Row(children: [
      Icon(icon, size: 17, color: Colors.white,),
      const SizedBox(height: 12),
      Text(label, style: const TextStyle(
        color: Colors.white,
      )),
    ],);
  }
}