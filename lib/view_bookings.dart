import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ViewBookings extends StatefulWidget {
  const ViewBookings({super.key});

  @override
  State<ViewBookings> createState() => _ViewBookingsState();
}

class _ViewBookingsState extends State<ViewBookings> {
  bool loading = true;
  List responseData = [];
  Future<void> fetchData() async {
    final url = Uri.parse(
      'https://my-json-server.typicode.com/githubforekam/doctor-appointment/appointments',
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
        title: const Text('My Bookings'),
      ),
      body: loading == true
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: responseData.length,
                    itemBuilder: (e, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.black),
                        ),
                        child: Column(
                          children: [
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                width: double.infinity,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${responseData[index]['appointment_date']} - ${responseData[index]['appointment_time'].split('-')[0]}',
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                )),
                            const Divider(
                              height: 1,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Container(
                                    color: Colors.grey[200],
                                    width: 80,
                                    height: 80,
                                    child: const Icon(Icons.person,
                                        color: Colors.blue),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              responseData[index]
                                                  ['doctor_name'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            )),
                                        Row(
                                          children: [
                                            const Icon(Icons.pin_drop_outlined,
                                                color: Colors.blue),
                                            Expanded(
                                              child: Text(responseData[index]
                                                  ['location']),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.adf_scanner_sharp,
                                                color: Colors.blue),
                                            Expanded(
                                              child: Text(
                                                  'Booking ID : ${responseData[index]['booking_id']}'),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.lightBlue[100],foregroundColor: Colors.blue),
                                  onPressed: () {},
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white),
                                  onPressed: () {},
                                  child: const Text('Reschedule'),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ),
    );
  }
}
