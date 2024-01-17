import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({required this.ButtomName,this.onTap});
  String ButtomName;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        height: 50,
        child: Center(child: Text(ButtomName)),
      ),
    );
  }
}
