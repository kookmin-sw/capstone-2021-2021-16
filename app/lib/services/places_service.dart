import 'package:app/models/place_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:app/models/place.dart';
class PlacesService{

  Future<List<PlaceSearch>> getAutocomplete(String search) async{
    final key = 'AIzaSyDvQG6Q4TwziVQt5jiUwoeHZO27fJjK8O4';
    var url =
        Uri.parse('https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&language=ko-KR&key=$key');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

  Future<Place> getPlace(String placeId) async{
    final key = 'AIzaSyDvQG6Q4TwziVQt5jiUwoeHZO27fJjK8O4';
    var url =
        Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?key=$key&place_id=$placeId');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String,dynamic>;
    return Place.fromJson(jsonResult);
  }

  Future<List<Place>> getPlaces(double lat, double lng, String placeType) async{
    final key = 'AIzaSyDvQG6Q4TwziVQt5jiUwoeHZO27fJjK8O4';
    var url =
        Uri.parse('https://maps.googleapis.com/maps/api/place/textsearch/json?type=$placeType&location=$lat,$lng&rankby=distance&key=$key');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}