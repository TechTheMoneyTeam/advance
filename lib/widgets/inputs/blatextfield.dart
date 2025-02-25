
import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class BlaTextField extends StatelessWidget {
  final String label;
  final String? value;
  final String placeholder;
  final IconData? icon;
  final bool isEnabled;
  final bool isRequired;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;

  const BlaTextField({
    Key? key,
    required this.label,
    this.value,
    this.placeholder = '',
    this.icon,
    this.isEnabled = true,
    this.isRequired = false,
    this.onTap,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null && value!.isNotEmpty;

    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: BlaSpacings.m, // Use defined spacing
          vertical: BlaSpacings.s,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isEnabled ? BlaColors.neutralLight : BlaColors.disabled,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label
            Row(
              children: [
                Text(
                  label,
                  style: BlaTextStyles.label.copyWith(
                    color: isEnabled ? BlaColors.textNormal : BlaColors.disabled,
                  ),
                ),
                if (isRequired)
                  Text(
                    ' *',
                    style: BlaTextStyles.label.copyWith(
                      color: BlaColors.error,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            // Value or placeholder
            Row(
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 18,
                    color: isEnabled
                        ? (hasValue ? BlaColors.primary : BlaColors.textNormal)
                        : BlaColors.disabled,
                  ),
                  SizedBox(width: BlaSpacings.s),
                ],
                Expanded(
                  child: Text(
                    hasValue ? value! : placeholder,
                    style: BlaTextStyles.body.copyWith(
                      color: isEnabled
                          ? (hasValue ? BlaColors.textNormal : BlaColors.secondary)
                          : BlaColors.disabled,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}