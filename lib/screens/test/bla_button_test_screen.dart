import 'package:flutter/material.dart';
import '../../widgets/actions/bla_button.dart';
import '../../theme/theme.dart';

class BlaButtonTestScreen extends StatelessWidget {
  const BlaButtonTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BlaButton Tests'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(BlaSpacings.m), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Contact Buttons'),
            const SizedBox(height: 16),
            BlaButton(
              text: 'Contact Volodia',
              icon: Icons.chat,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Button 1')),
                );
              
              },
              variant: BlaButtonVariant.secondary, 
              
            ),
            const SizedBox(height: 16),
            BlaButton(
              text: 'Request to book',
              icon: Icons.calendar_today,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Button ')),
                );
              },
              variant: BlaButtonVariant.primary, 
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: BlaTextStyles.heading, // Ensure this matches your defined text style
    );
  }
}