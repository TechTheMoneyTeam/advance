import 'package:flutter/material.dart';
import '../../theme/theme.dart'; 

class BlaBackground extends StatelessWidget {
  final Widget child;

  const BlaBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BlaColors.backgroundAccent, 
      padding: EdgeInsets.all(BlaSpacings.m), 
    );
  }
}