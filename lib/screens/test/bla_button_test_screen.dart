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
        padding: EdgeInsets.all(BlaSpacings.m), // Use defined spacing
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
                  const SnackBar(content: Text('Contact Volodia pressed!')),
                );
              },
              
            ),
            const SizedBox(height: 16),
            BlaButton(
              text: 'Request to book',
              icon: Icons.calendar_today,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Request to book pressed!')),
                );
              },
              variant: BlaButtonVariant.primary, // Solid variant for the request button
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