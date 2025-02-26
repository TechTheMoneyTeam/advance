import 'package:flutter/material.dart';
import '../../widgets/actions/bla_button.dart';
import '../../theme/theme.dart';

class BlaButtonTestScreen extends StatelessWidget {
  const BlaButtonTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tests'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(BlaSpacings.m), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            const SizedBox(height: 16),
            BlaButton(
              text: 'Button 1',
              icon: Icons.chat,
              onPressed: () {
        
              
              },
              variant: BlaButtonVariant.secondary, 
              
            ),
            const SizedBox(height: 16),
            BlaButton(
              text: 'Button 2',
              icon: Icons.calendar_today,
              onPressed: () {
          
              },
              variant: BlaButtonVariant.primary, 
            ),
          ],
        ),
      ),
    );
  }


}