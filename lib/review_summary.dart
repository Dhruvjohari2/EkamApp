import 'package:doctorekam/confirmation.dart';
import 'package:flutter/material.dart';

class ReviewSummary extends StatefulWidget {
  const ReviewSummary(
      {super.key,
      required this.duration,
      required this.type,
      required this.date,
      required this.time,
      required this.speciality,
      required this.location, required this.name, required this.image});

  final String speciality;
  final String location;
  final String duration;
  final String type;
  final String image;
  final String name;
  final String date;
  final String time;

  @override
  State<ReviewSummary> createState() => _ReviewSummaryState();
}

class _ReviewSummaryState extends State<ReviewSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Summary'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.grey,
                    ),
                    child: Image.network(widget.image),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              widget.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            )),
                        Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(widget.speciality)),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.pin_drop_outlined,
                                color: Colors.blue,
                              ),
                              Expanded(child: Text(widget.location)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Divider(
                height: 1,
                thickness: 1,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date and Hour',
                        style: TextStyle(color: Colors.grey[700], fontSize: 15),
                      ),
                      Text(
                        '${widget.date} | ${widget.time}',
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Package',
                        style: TextStyle(color: Colors.grey[700], fontSize: 15),
                      ),
                      Text(
                        widget.type ?? '',
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Duration',
                        style: TextStyle(color: Colors.grey[700], fontSize: 15),
                      ),
                      Text(
                        widget.duration ?? '',
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Booking for',
                        style: TextStyle(color: Colors.grey[700], fontSize: 15),
                      ),
                      Text(
                        'self',
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Confirmation(),
                    ),
                  );
                },
                child: const Text('Confirm'))
          ],
        ),
      ),
    );
  }
}
