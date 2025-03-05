import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';
import '../../model/user/user.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../repository/ride_repository.dart';

// Adding RideWithPreferences class that extends Ride
class RideWithPreferences extends Ride {
  final bool acceptPets;


  RideWithPreferences({
    required Location departureLocation,
    required Location arrivalLocation,
    required DateTime departureDate,
    required DateTime arrivalDateTime,
    required User driver,
    required int availableSeats,
    required double pricePerSeat,
    required this.acceptPets,

  }) : super(
    departureLocation: departureLocation,
    arrivalLocation: arrivalLocation,
    departureDate: departureDate,
    arrivalDateTime: arrivalDateTime,
    driver: driver,
    availableSeats: availableSeats,
    pricePerSeat: pricePerSeat,
  );
}

class MockRidesRepository implements RidesRepository {
  final List<Ride> _rides = [
    RideWithPreferences(
      departureLocation: Location(name: 'Battambang', country: Country.cambodia),
      arrivalLocation: Location(name: 'Siem Reap', country: Country.cambodia),
      departureDate: DateTime.now().copyWith(hour: 5, minute: 30),
      arrivalDateTime: DateTime.now().copyWith(hour: 5, minute: 30).add(const Duration(hours: 2)),
      driver: User(
        firstName: 'Kannika',
        lastName: '',
        email: '',
        phone: '',
        profilePicture: '',
        verifiedProfile: true,
      ),
      availableSeats: 2,
      pricePerSeat: 10.0,
      acceptPets: false,

    ),
    RideWithPreferences(
      departureLocation: Location(name: 'Battambang', country: Country.cambodia),
      arrivalLocation: Location(name: 'Siem Reap', country: Country.cambodia),
      departureDate: DateTime.now().copyWith(hour: 20, minute: 0),
      arrivalDateTime: DateTime.now().copyWith(hour: 20, minute: 0).add(const Duration(hours: 2)),
      driver: User(
        firstName: 'Chaylim',
        lastName: '',
        email: '',
        phone: '',
        profilePicture: '',
        verifiedProfile: true,
      ),
      availableSeats: 0,
      pricePerSeat: 10.0,
      acceptPets: false,

    ),
    RideWithPreferences(
      departureLocation: Location(name: 'Battambang', country: Country.cambodia),
      arrivalLocation: Location(name: 'Siem Reap', country: Country.cambodia),
      departureDate: DateTime.now().copyWith(hour: 5, minute: 0),
      arrivalDateTime: DateTime.now().copyWith(hour: 5, minute: 0).add(const Duration(hours: 3)),
      driver: User(
        firstName: 'Mengtech',
        lastName: '',
        email: '',
        phone: '',
        profilePicture: '',
        verifiedProfile: true,
      ),
      availableSeats: 1,
      pricePerSeat: 15.0,
      acceptPets: false,

    ),
    RideWithPreferences(
      departureLocation: Location(name: 'Battambang', country: Country.cambodia),
      arrivalLocation: Location(name: 'Siem Reap', country: Country.cambodia),
      departureDate: DateTime.now().copyWith(hour: 20, minute: 0),
      arrivalDateTime: DateTime.now().copyWith(hour: 20, minute: 0).add(const Duration(hours: 2)),
      driver: User(
        firstName: 'Limhao',
        lastName: '',
        email: '',
        phone: '',
        profilePicture: '',
        verifiedProfile: true,
      ),
      availableSeats: 2,
      pricePerSeat: 12.0,
      acceptPets: true,
 
    ),
    RideWithPreferences(
      departureLocation: Location(name: 'Battambang', country: Country.cambodia),
      arrivalLocation: Location(name: 'Siem Reap', country: Country.cambodia),
      departureDate: DateTime.now().copyWith(hour: 5, minute: 0),
      arrivalDateTime: DateTime.now().copyWith(hour: 5, minute: 0).add(const Duration(hours: 3)),
      driver: User(
        firstName: 'Sovanda',
        lastName: '',
        email: '',
        phone: '',
        profilePicture: '',
        verifiedProfile: true,
      ),
      availableSeats: 1,
      pricePerSeat: 15.0,
      acceptPets: false,

    ),
  ];

  @override
  List<Ride> getRides(RidePref preference,RidesFilter? filter) {
    return _rides.where((ride) {
      // Match departure and arrival
      if (ride.departureLocation.name != preference.departure.name ||
          ride.arrivalLocation.name != preference.arrival.name) {
        return false;
      }
      
      // Check available seats
      if (ride.availableSeats < preference.requestedSeats) {

        return false;
      }
         if (filter != null && filter.petAccepted && 
          !(ride is RideWithPreferences && (ride).acceptPets)) {
        return false;
      }
 
      
      return true;
    }).toList();
  }
}