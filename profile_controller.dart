import 'dart:convert';

import 'package:api_practice/data/json_bean/get_continents.dart';
import 'package:api_practice/data/json_bean/get_customer_profile.dart';
import 'package:api_practice/data/repo/home_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ProfileController{
  final dio = Dio();


  Future<GetCustomerProfile?> fetchProfile(String customerId) async {
    return await HomeRepo().getCustomerProfile(customerId);
  }

  Future<GetCustomerProfile?> printCustomerProfile() async {
    var dio = Dio(
      BaseOptions(
          baseUrl: "https://jojobike.microcrm.in/",
      )
    );
    try {
      var response = await dio.request(
        'api/customer-profile',
        queryParameters: {
          'customer_id': 1,
        },
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        print('Response Status Code: ${response.statusCode}');
        return GetCustomerProfile.fromJson(response.data);
      }
      else {
        print('Response Status Code: ${response.statusCode}');
        print('Response Status Message: ${response.statusMessage}');
        return null;
      }
    }
    catch (e) {
      print('Error: $e');
      return null;
    }
  }

  List<GetContinents> contiList = [];

  Future<List<GetContinents?>> getContinents() async{
    final response = await dio.get('https://dummy-json.mock.beeceptor.com/continents');
    // print("list response \n $response");

    final continents = response.data;

    if(response.data==200){
      for (var i in continents) {
        // print("Code: ${continent["code"]}");
        GetContinents getContinents = GetContinents(
          code: i['code'],
          name: i['name'],
          areaSqKm: i['areaSqKm'],
          population: i['population'],
          countries: i['countries'],

        );
        contiList.add(getContinents);
      }
      return contiList;
    }
    else {
      return contiList;
    }

  }





}