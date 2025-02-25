import '../model/ride/locations.dart';
import '../dummy_data/dummy_data.dart';

///
/// This service handles:
/// - The list of available rides
///
class LocationsService {
  static const List<Location> availableLocations = fakeLocations;

  static List<Location> getLocations() {
    return availableLocations; // Return the list of available locations
  }
}