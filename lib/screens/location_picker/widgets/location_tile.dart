
import 'package:flutter/material.dart';
import '../../../model/ride/locations.dart';
import '../../../theme/theme.dart';

class LocationTile extends StatelessWidget {
  final Location location;
  final bool isDisabled;
  final VoidCallback? onTap;
  
  const LocationTile({
    Key? key,
    required this.location,
    this.isDisabled = false,
    this.onTap,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled ? null : onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: BlaSpacings.m,
          vertical: BlaSpacings.m,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: BlaColors.borderLight,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // Location icon
            Icon(
              Icons.location_on_outlined,
              color: isDisabled ? BlaColors.disabledText : BlaColors.primary,
            ),
            
            SizedBox(width: BlaSpacings.m),
            
            // Location details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // City name
                  Text(
                    location.name,
                    style: BlaTextStyles.bodyMedium.copyWith(
                      color: isDisabled ? BlaColors.disabledText : BlaColors.primary,
                    ),
                  ),
                  
                  SizedBox(height: BlaSpacings.s / 2),
                  
                  // Country name
                  Text(
                    location.country.name,
                    style: BlaTextStyles.body.copyWith(
                      color: isDisabled ? BlaColors.disabledText : BlaColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
            
            // Disabled indicator or selection icon
            if (isDisabled)
              Icon(
                Icons.block,
                color: BlaColors.disabledText,
                size: 18,
              )
            else
              Icon(
                Icons.arrow_forward_ios,
                color: BlaColors.secondaryText,
                size: 18,
              ),
          ],
        ),
      ),
    );
  }
}