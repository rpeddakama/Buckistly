import 'package:bucketlist/models/activityModel.dart';
import 'package:bucketlist/models/destinationModel.dart';
import 'package:bucketlist/models/experienceModel.dart';

List<Activity> activities = [
  Activity(
    imageUrl: 'assets/images/eiffeltower.jpg',
    name: 'Eiffel Tower',
    type: 'International Landmark',
    startTimes: ['9:00 am', '11:00 am'],
    rating: 5,
    price: 30,
  ),
  Activity(
    imageUrl: 'assets/images/versailles.jpg',
    name: 'Palace of Versailles',
    type: 'Sightseeing Tour',
    startTimes: ['11:00 pm', '1:00 pm'],
    rating: 4,
    price: 210,
  ),
  Activity(
    imageUrl: 'assets/images/louvre.jpg',
    name: 'The Louvre',
    type: 'Museum',
    startTimes: ['12:30 pm', '2:00 pm'],
    rating: 3,
    price: 125,
  ),
];

final List<Experience> experiences = [
  Experience(
    imageUrl: 'assets/images/skydiving.jpg',
    name: 'Skydiving',
  ),
  Experience(
    imageUrl: 'assets/images/scubadiving.jpg',
    name: 'Scuba Diving',
  ),
  Experience(
    imageUrl: 'assets/images/dolphin.jpg',
    name: 'Swimming with Dolphins',
  ),
];

List<Destination> destinations = [
  Destination(
    imageUrl: 'assets/images/hawaii.jpg',
    city: 'Honolulu',
    country: 'Hawaii, USA',
    description: 'Visit Hawaii for an amazing and unforgettable adventure.',
    activities: activities,
  ),
  Destination(
    imageUrl: 'assets/images/paris.jpg',
    city: 'Paris',
    country: 'France',
    description: 'Visit Paris for an amazing and unforgettable adventure.',
    activities: activities,
  ),
  Destination(
    imageUrl: 'assets/images/iceland.jpg',
    city: 'Reykjavik',
    country: 'Iceland',
    description: 'Visit Iceland for an amazing and unforgettable adventure.',
    activities: activities,
  ),
  Destination(
    imageUrl: 'assets/images/tokyo.jpg',
    city: 'Tokyo',
    country: 'Japan',
    description: 'Visit Tokyo for an amazing and unforgettable adventure.',
    activities: activities,
  )
];
