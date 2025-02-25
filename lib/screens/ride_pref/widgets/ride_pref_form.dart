import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/screens/location_picker/location_picker_screen.dart';
import 'package:week_3_blabla_project/utils/animations_util.dart';
import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

/// A Ride Preference Form is a view to select:
///   - A departure location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------
  @override
  void initState() {
    super.initState();
    // Initialize attributes with optional initial RidePref
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate ?? DateTime.now();
      requestedSeats = widget.initRidePref!.requestedSeats ?? 1;
    } else {
      departureDate = DateTime.now();
      requestedSeats = 1; // Default value
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void _onDepartureChanged(Location? newLocation) {
    setState(() {
      departure = newLocation;
    });
  }

  void _onArrivalChanged(Location? newLocation) {
    setState(() {
      arrival = newLocation;
    });
  }

  void _onDateChanged(DateTime newDate) {
    setState(() {
      departureDate = newDate;
    });
  }

  void _onSeatsChanged(int newSeats) {
    setState(() {
      requestedSeats = newSeats;
    });
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  Widget _buildLocationPicker(String label, Location? currentLocation, Function(Location?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        // Here you can replace with a dropdown or suggestions list
        ElevatedButton(
          onPressed: () async {
            // Logic to pick location
            Location? selectedLocation = await _showLocationPicker(isArrival: false);
            onChanged(selectedLocation);
          },
          child: Text(currentLocation?.name ?? 'Select $label'),
        ),
      ],
    );
  }

  Future<Location?> _showLocationPicker({required bool isArrival}) async {
      final selectedLocation = await Navigator.of(context).push<Location>(
    AnimationsUtils.createBottomToTopRoute(
      LocationPickerScreen(
        title: isArrival ? 'Select destination' : 'Select departure',
        excludeLocation: isArrival ? departure : arrival,
      ),
    ),
  );
  
  if (selectedLocation != null) {
    setState(() {
      if (isArrival) {
        arrival = selectedLocation;
      } else {
        departure = selectedLocation;
      }
    });
  }
  }

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLocationPicker('Departure Location', departure, _onDepartureChanged),
        const SizedBox(height: 16),
        _buildLocationPicker('Arrival Location', arrival, _onArrivalChanged),
        const SizedBox(height: 16),
        Text('Departure Date: ${departureDate.toLocal()}'),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            DateTime? selectedDate = await _selectDate(context);
            if (selectedDate != null) {
              _onDateChanged(selectedDate);
            }
          },
          child: const Text('Pick Departure Date'),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text('Requested Seats: '),
            DropdownButton<int>(
              value: requestedSeats,
              items: List.generate(10, (index) => index + 1)
                  .map((seats) => DropdownMenuItem<int>(
                        value: seats,
                        child: Text(seats.toString()),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  _onSeatsChanged(value);
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
  }
}