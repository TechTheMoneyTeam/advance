// widgets/inputs/bla_seat_picker.dart
import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class BlaSeatPicker extends StatefulWidget {
  final int value;
  final int minValue;
  final int maxValue;
  final String title;
  final ValueChanged<int>? onChanged;
  
  const BlaSeatPicker({
    Key? key,
    required this.value,
    this.minValue = 1,
    this.maxValue = 8,
    this.title = 'Select passengers',
    this.onChanged,
  }) : super(key: key);
  
  @override
  State<BlaSeatPicker> createState() => _BlaSeatPickerState();
}

class _BlaSeatPickerState extends State<BlaSeatPicker> {
  late int _currentValue;
  
  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(BlaSpacings.m),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Text(
            widget.title,
            style: BlaTextStyles.heading,
          ),
          
          SizedBox(height: BlaSpacings.l),
          
          // Seat counter
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Decrement button
              _buildButton(
                icon: Icons.remove_circle_outline,
                onPressed: _currentValue > widget.minValue
                    ? () => _updateValue(_currentValue - 1)
                    : null,
              ),
              
              // Value display
              Container(
                width: 80,
                alignment: Alignment.center,
                child: Text(
                  '$_currentValue',
                  style: BlaTextStyles.heading,
                ),
              ),
              
              // Increment button
              _buildButton(
                icon: Icons.add_circle_outline,
                onPressed: _currentValue < widget.maxValue
                    ? () => _updateValue(_currentValue + 1)
                    : null,
              ),
            ],
          ),
          
          SizedBox(height: BlaSpacings.m),
          
          // Seat label
          Text(
            _currentValue == 1 ? 'passenger' : 'passengers',
            style: BlaTextStyles.bodyMedium.copyWith(
              color: BlaColors.secondaryText,
            ),
          ),
          
          SizedBox(height: BlaSpacings.l),
          
          // Confirm button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: BlaColors.primary,
             
                padding: EdgeInsets.symmetric(vertical: BlaSpacings.m),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                if (widget.onChanged != null) {
                  widget.onChanged!(_currentValue);
                }
                Navigator.of(context).pop(_currentValue);
              },
              child: Text(
                'Confirm',
                style: BlaTextStyles.button,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildButton({
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    final color = onPressed != null ? BlaColors.primary : BlaColors.disabledText;
    
    return IconButton(
      icon: Icon(
        icon,
        size: 32,
        color: color,
      ),
      onPressed: onPressed,
    );
  }
  
  void _updateValue(int newValue) {
    setState(() {
      _currentValue = newValue;
    });
  }
}