import 'package:flutter/material.dart';
import '../../theme/theme.dart';

enum BlaButtonVariant {
  primary,
  secondary,
}

class BlaButton extends StatelessWidget {
  final String text;
  final BlaButtonVariant variant;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool isExpanded;
  final bool isLoading;

  const BlaButton({
    Key? key,
    required this.text,
    this.variant = BlaButtonVariant.primary,
    this.icon,
    this.onPressed,
    this.isEnabled = true,
    this.isExpanded = true,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine button colors based on variant and enabled state
    final backgroundColor = _getBackgroundColor();
    final textColor = _getTextColor();
    final borderColor = _getBorderColor();

    // Create the button content with or without icon
    Widget buttonContent = isLoading
        ? _buildLoadingContent(textColor)
        : _buildButtonContent(textColor);

    // Create the button with appropriate styling
    return Container(
      width: isExpanded ? double.infinity : null,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: borderColor,
          width: variant == BlaButtonVariant.secondary ? 2 : 0,
        ),
      ),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: (isEnabled && !isLoading) ? onPressed : null,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: buttonContent,
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (!isEnabled) {
      return BlaColors.greyLight; // Assuming you have a disabled background color
    }

    switch (variant) {
      case BlaButtonVariant.primary:
        return BlaColors.primary;
      case BlaButtonVariant.secondary:
        return Colors.transparent;
    }
  }

  Color _getTextColor() {
    if (!isEnabled) {
      return BlaColors.greyLight; 
    }

    switch (variant) {
      case BlaButtonVariant.primary:
        return BlaColors.white; 
      case BlaButtonVariant.secondary:
        return BlaColors.primary;
    }
  }

  Color _getBorderColor() {
    if (!isEnabled) {
      return BlaColors.greyLight; 
    }

    switch (variant) {
      case BlaButtonVariant.primary:
        return Colors.transparent;
      case BlaButtonVariant.secondary:
        return BlaColors.primary;
    }
  }

  Widget _buildButtonContent(Color textColor) {
    if (icon == null) {
      return Text(
        text,
        style: BlaTextStyles.button.copyWith(color: textColor),
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: textColor, size: 20),
          SizedBox(width: BlaSpacings.s), 
          Text(
            text,
            style: BlaTextStyles.button.copyWith(color: textColor),
          ),
        ],
      );
    }
  }

  Widget _buildLoadingContent(Color textColor) {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(textColor),
      ),
    );
  }
}