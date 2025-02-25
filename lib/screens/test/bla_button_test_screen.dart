
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
            _buildSectionTitle('Primary Buttons'),
            const SizedBox(height: 16),
            BlaButton(
              text: 'Primary Button',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Primary button pressed!')),
                );
              },
            ),
            const SizedBox(height: 16),
            BlaButton(
              text: 'Primary with Icon',
              icon: Icons.search,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Primary button with icon pressed!')),
                );
              },
            ),
            const SizedBox(height: 16),
            BlaButton(
              text: 'Disabled Primary',
              isEnabled: false,
              onPressed: null, // Disable the callback when the button is disabled
            ),
            const SizedBox(height: 16),
            BlaButton(
              text: 'Loading Primary',
              isLoading: true,
              onPressed: null, // Disable the callback when loading
            ),
            const SizedBox(height: 16),
            BlaButton(
              text: 'Non-expanded Primary',
              isExpanded: false,
              onPressed: () {},
            ),
            
            const SizedBox(height: 32),
            _buildSectionTitle('Secondary Buttons'),
            const SizedBox(height: 16),
            BlaButton(
              text: 'Secondary Button',
              variant: BlaButtonVariant.secondary,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Secondary button pressed!')),
                );
              },
            ),
            const SizedBox(height: 16),
            BlaButton(
              text: 'Secondary with Icon',
              variant: BlaButtonVariant.secondary,
              icon: Icons.favorite,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Secondary button with icon pressed!')),
                );
              },
            ),
            const SizedBox(height: 16),
            BlaButton(
              text: 'Disabled Secondary',
              variant: BlaButtonVariant.secondary,
              isEnabled: false,
              onPressed: null, // Disable the callback when the button is disabled
            ),
            const SizedBox(height: 16),
            BlaButton(
              text: 'Loading Secondary',
              variant: BlaButtonVariant.secondary,
              isLoading: true,
              onPressed: null, // Disable the callback when loading
            ),
            const SizedBox(height: 16),
            BlaButton(
              text: 'Non-expanded Secondary',
              variant: BlaButtonVariant.secondary,
              isExpanded: false,
              onPressed: () {},
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