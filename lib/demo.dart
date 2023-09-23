import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final String _endpoint =
      "https://my-json-server.typicode.com/githubforekam/doctor-appointment/doctors";
  final List<String> _date = ["2023-09-18", "2023-09-20", "2023-09-21"];

  int _dateIndex = 0;
  int _timeIndex = 0;

  List<String> getTime(List<String> timeData) {
    final List<String> res = [];

    for (var ele in timeData) {
      final dateRes = ele.split("-");
      res.addAll(dateRes);
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {
    final res = ref.watch(getDoctorData(_endpoint));
    debugPrint('res ${res.value![0].location}');

    if (!res.hasValue) {
      return Scaffold(
        appBar: AppBar(title: const Text("Doctor App")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final String selectedDate = _date[_dateIndex];
    final List<String> resData = res.value![0].availability[selectedDate] ?? [];

    final timeData = getTime(resData);

    return Scaffold(
      appBar: AppBar(title: const Text("Doctor App")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(res.value![0].image),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          res.value![0].doctorName,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          res.value![0].speciality,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.pin_drop_outlined,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(res.value![0].location),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              thickness: 0.5,
              height: 2,
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.blue[100],
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        '${res.value![0].patientsServed}+',
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'Patients',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.blue[100],
                        ),
                        child: const Icon(
                          Icons.shopping_bag,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        '${res.value![0].yearsOfExperience}+',
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'Year Exp.',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.blue[100],
                        ),
                        child: const Icon(
                          Icons.star,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        '${res.value![0].rating}+',
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'Rating',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.blue[100],
                        ),
                        child: const Icon(
                          Icons.message,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        '${res.value![0].numberOfReviews}+',
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'Reviews',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                'BOOK APPOINTMENT ',
                style: TextStyle(color: Colors.grey[500], fontSize: 15),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.8,
              child: const Text(
                'Day',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ListView.builder(
                // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _date.length,
                // physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (e, index) {
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _dateIndex = index;
                        _timeIndex = 0;
                      });
                    },
                    style: ButtonStyle(
                      foregroundColor: const MaterialStatePropertyAll(
                        Colors.white,
                      ),
                      backgroundColor: MaterialStatePropertyAll(
                        _dateIndex == index ? Colors.blue : Colors.grey[400],
                      ),
                    ),
                    child: Text(_date[index]),
                  );
                },
              ),
            ),
            const SizedBox(height: 25),
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.8,
              child: const Text(
                'Time',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: timeData.length,
                itemBuilder: (e, index) {
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _timeIndex = index;
                      });
                    },
                    style: ButtonStyle(
                      foregroundColor: const MaterialStatePropertyAll(
                        Colors.white,
                      ),
                      backgroundColor: MaterialStatePropertyAll(
                        _timeIndex == index ? Colors.blue : Colors.grey[400],
                      ),
                    ),
                    child: Text(timeData[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
