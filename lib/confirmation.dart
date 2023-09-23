import 'dart:convert';

import 'package:doctorekam/view_bookings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Confirmation extends StatefulWidget {
  const Confirmation({super.key});

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  bool loading = true;
  Map<String, dynamic> responseData = {};
  Future<void> fetchData() async {
    final url = Uri.parse(
      'https://my-json-server.typicode.com/githubforekam/doctor-appointment/booking_confirmation',
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
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation'),
      ),
      body: loading == true
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              width: 200,
                              height: 200,
                              child: Image.asset(
                                'assets/images/check.png',
                              ),
                            ),
                            const Text(
                              'Appointment Confirmed!',
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.w600),
                            ),
                            const Text(
                                'You have sucessfully Booked Your Appoitment with'),
                            Text(
                              responseData['doctor_name'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Esther Howard',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_month,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        responseData['appointment_date'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.timer_sharp,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        responseData['appointment_time'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ViewBookings(),
                            ),
                          );
                        },
                        child: const Text('View Appointments')),
                    ElevatedButton(
                        onPressed: () {}, child: const Text('Book Another')),
                  ],
                ),
              ),
            ),
    );
  }
}
