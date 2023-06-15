import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'offices.g.dart';

@JsonSerializable()
class OfficesList {
  List<NewOffices> offices;
  OfficesList({required this.offices});

  factory OfficesList.fromJson(Map<String, dynamic> json) =>
      _$OfficesListFromJson(json);
  Map<String, dynamic> toJson() => _$OfficesListToJson(this);
}

@JsonSerializable()
class NewOffices {
  final String? name;
  final String? address;
  final String? image;
  NewOffices({this.name, this.address, this.image});

  factory NewOffices.fromJson(Map<String, dynamic> json) =>
      _$NewOfficesFromJson(json);
  Map<String, dynamic> toJson() => _$NewOfficesToJson(this);
}

Future<OfficesList> getOfficesList() async {
  const url = 'https://about.google/static/data/locations.json';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return OfficesList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
