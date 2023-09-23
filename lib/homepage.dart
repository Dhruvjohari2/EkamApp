import 'dart:convert';
import 'package:doctorekam/doctordetails.dart';
import 'package:doctorekam/select_package.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'demo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;
  List responseData = [];
  Future<void> fetchData() async {
    final url = Uri.parse(
      'https://my-json-server.typicode.com/githubforekam/doctor-appointment/doctors',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        responseData = json.decode(response.body);
        setState(() {
          loading = false;
        });
        debugPrint('responseData: $responseData');
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Doctor App'),
      ),
      body: loading == true
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: responseData.length,
                  itemBuilder: (e, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DoctorDetails(
                              id:index,
                            ),
                          ),
                        );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) => SelectPackage(),
                        //   ),
                        // );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(responseData[index]['doctor_name']),
                            Text(responseData[index]['speciality']),
                            Text(responseData[index]['location']),
                            Text(responseData[index]['patients_served'].toString()),
                            Text(responseData[index]['years_of_experience'].toString()),
                            Text(responseData[index]['rating'].toString()),
                            Text(responseData[index]['number_of_reviews'].toString()),
                            Text(responseData[index]['availability'].toString()),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}
