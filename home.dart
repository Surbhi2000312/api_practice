import 'package:api_practice/controller/profile_controller.dart';
import 'package:api_practice/data/json_bean/get_continents.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

 import 'dart:html' as html;


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final dio = Dio();
  List<GetContinents> contiList = [];

  Future<List<GetContinents?>> getContinents() async {
    final response = await dio.get('https://dummy-json.mock.beeceptor.com/continents');

    if (response.statusCode == 200) {
      final continents = response.data;

      contiList.clear();
      for (var i in continents) {
        GetContinents getContinents = GetContinents(
          code: i['code'],
          name: i['name'],
          areaSqKm: i['areaSqKm'],
          population: i['population'],
          countries: i['countries'],
        );
        contiList.add(getContinents);
      }
    }
    return contiList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Continents')),
      body: FutureBuilder<List<GetContinents?>>(
        future: getContinents(),
        builder: (context, AsyncSnapshot<List<GetContinents?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Show loading indicator
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));  // Handle errors
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Continents Found'));  // No data found
          } else {
            return ListView.builder(
              itemCount: contiList.length,
              itemBuilder: (context, index) {
                GetContinents continent = contiList[index];
                return ListTile(
                  title: Text(continent.name ?? 'Unknown'),
                  subtitle: Text('Code: ${continent.code}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

