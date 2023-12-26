import 'package:flutter/material.dart';

class PlannerCard extends StatelessWidget {
  // members
  final String startHour;
  final String startMinute;
  final String endHour;
  final String endMinute;

  final String planTitle;
  final List<String> participant;

  final Color bgColor;

  // constructor
  const PlannerCard({
    super.key,
    required this.startHour,
    required this.startMinute,
    required this.endHour,
    required this.endMinute,
    required this.planTitle,
    required this.participant,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(45),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 35,
          left: 17,
          right: 17,
          bottom: 17,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  startHour,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    height: 0.9,
                  ),
                ),
                Text(
                  startMinute,
                ),
                const Text(
                  '|',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                Text(
                  endHour,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    height: 0.9,
                  ),
                ),
                Text(
                  endMinute,
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  planTitle,
                  style: const TextStyle(
                    fontSize: 62,
                    fontWeight: FontWeight.w500,
                    height: 0.9,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    for (String name in participant)
                      Row(
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: name == 'ME'
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              color: name == 'ME'
                                  ? Colors.black
                                  : Colors.black.withOpacity(0.5),
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
