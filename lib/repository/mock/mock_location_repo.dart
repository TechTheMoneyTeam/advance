import '../../model/ride/locations.dart';
import '../location_repo.dart';



class MockLocationsRepository implements LocationsRepository {
  @override
  List<Location> getLocations() {
    return [
      Location(name: 'Phnom Penh', country: Country.cambodia),
      Location(name: 'Siem Reap', country: Country.cambodia),
      Location(name: 'Battambang', country: Country.cambodia),
      Location(name: 'Sihanoukville', country: Country.cambodia),
      Location(name: 'Kampot', country: Country.cambodia),
    ];
  }
}