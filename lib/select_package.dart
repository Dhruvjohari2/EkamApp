import 'dart:convert';
import 'package:doctorekam/review_summary.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import "package:fluttertoast/fluttertoast.dart";


class SelectPackage extends StatefulWidget {
  const SelectPackage(
      {super.key,
      required this.date,
      required this.time,
      required this.name,
      required this.speciality,
      required this.location,
      required this.image});

  final String date;
  final String time;
  final String name;
  final String image;
  final String speciality;
  final String location;

  @override
  State<SelectPackage> createState() => _SelectPackageState();
}

class _SelectPackageState extends State<SelectPackage> {
  bool loading = true;
  List<String> options = [];
  Map<String, dynamic> data = {};
  String? selectedOption;
  String? selectedId; // To store the selected item's ID

  List iconsForList = [
    const Icon(Icons.message),
    const Icon(Icons.call),
    const Icon(Icons.video_camera_back_outlined),
    const Icon(Icons.person)
  ];
  List messageForList = [
    "Chat with Doctor",
    "Voice Call with Doctor",
    "Video Call with Doctor",
    "In Person visit with Doctor"
  ];

  Future<void> fetchOptions() async {
    final response = await http.get(Uri.parse(
        'https://my-json-server.typicode.com/githubforekam/doctor-appointment/appointment_options'));

    if (response.statusCode == 200) {
      data = json.decode(response.body);

      if (data.containsKey('duration')) {
        final List<dynamic> durations = data['duration'];

        setState(() {
          loading = false;
          options = durations.map((item) => item.toString()).toList();
        });
      } else {
        throw Exception('Duration not found in API response');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Package'),
      ),
      body: loading == true
          ? const Center(child: CircularProgressIndicator())
          : Container(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: const Text(
                      'Select Duration',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(
                          Icons.timer,
                          color: Colors.blue,
                        ),
                        DropdownButton<String>(
                          value: selectedOption,
                          onChanged: (newValue) {
                            setState(() {
                              selectedOption = newValue!;
                            });
                          },
                          items: options.map((option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: const Text(
                      ' Select Package',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: data['package'].length,
                        itemBuilder: (e, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    color: Colors.lightBlue,
                                  ),
                                  child: iconsForList[index],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(data['package'][index]),
                                    Text(messageForList[index]),
                                  ],
                                ),
                                Radio(
                                  value: messageForList[index],
                                  groupValue: selectedId,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedId = value;
                                      debugPrint('selectedId : $selectedId');
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if(selectedId == null && selectedOption == null){
                        Fluttertoast.showToast(
                          msg: "Please select the Duration & Package",
                          backgroundColor: Colors.grey,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ReviewSummary(
                                  duration: selectedOption!,
                                  type: selectedId!,
                                  date: widget.date,
                                  time: widget.time,
                                  name: widget.name,
                                  image: widget.image,
                                  speciality: widget.speciality,
                                  location: widget.location,
                                ),
                          ),
                        );
                      }
                    },
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
    );
  }
}
