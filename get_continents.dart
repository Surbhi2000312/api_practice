import 'dart:convert';
GetContinents getContinentsFromJson(String str) => GetContinents.fromJson(json.decode(str));
String getContinentsToJson(GetContinents data) => json.encode(data.toJson());
class GetContinents {
  GetContinents({
      this.code, 
      this.name, 
      this.areaSqKm, 
      this.population, 
      this.lines, 
      this.countries, 
      this.oceans, 
      this.developedCountries,});

  GetContinents.fromJson(dynamic json) {
    code = json['code'];
    name = json['name'];
    areaSqKm = json['areaSqKm'];
    population = json['population'];
    lines = json['lines'] != null ? json['lines'].cast<String>() : [];
    countries = json['countries'];
    oceans = json['oceans'] != null ? json['oceans'].cast<String>() : [];
    developedCountries = json['developedCountries'] != null ? json['developedCountries'].cast<String>() : [];
  }
  String? code;
  String? name;
  num? areaSqKm;
  num? population;
  List<String>? lines;
  num? countries;
  List<String>? oceans;
  List<String>? developedCountries;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['name'] = name;
    map['areaSqKm'] = areaSqKm;
    map['population'] = population;
    map['lines'] = lines;
    map['countries'] = countries;
    map['oceans'] = oceans;
    map['developedCountries'] = developedCountries;
    return map;
  }



}