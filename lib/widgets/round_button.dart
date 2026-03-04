

import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final bool isloading;
  final String title;
  final VoidCallback onTap;
  const RoundButton({super.key, required this.title, required this.onTap, this.isloading=false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(40)
        ),
        child: 
      Center(child: isloading ? CircularProgressIndicator(strokeWidth: 3, color: Colors.white,) : Text(title, style: TextStyle(color: Colors.white),))),
    );
  }
}