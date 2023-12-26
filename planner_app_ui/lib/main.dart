import 'package:flutter/material.dart';
import 'package:planner_app_ui/widgets/planner_card.dart';

void main() {
  runApp(const MyPlannerApp());
}

class MyPlannerApp extends StatelessWidget {
  const MyPlannerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF1D1D1D),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.person_pin,
                      color: Colors.brown.shade400,
                      size: 75,
                    ),
                    const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 40,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Monday 16',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SingleChildScrollView(
                      // 날짜 스크롤
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const Text(
                            'TODAY',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            child: Icon(
                              Icons.circle,
                              color: Color(0xFFA6226F),
                              size: 11,
                            ),
                          ),
                          Text(
                            '17',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 43,
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Text(
                            '18',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 43,
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Text(
                            '19',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 43,
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Text(
                            '20',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 43,
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Text(
                            '21',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 43,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PlannerCard(
                        startHour: '11',
                        startMinute: '30',
                        endHour: '12',
                        endMinute: '20',
                        planTitle: 'DESIGN\nMETTING',
                        participant: ['ALEX', 'HELENA', 'NANA'],
                        bgColor: Color(0xFFFFF754),
                      ),
                      SizedBox(height: 8),
                      PlannerCard(
                        startHour: '12',
                        startMinute: '35',
                        endHour: '14',
                        endMinute: '10',
                        planTitle: 'DAILY\nPROJECT',
                        participant: ['ME', 'RICHARD', 'CIRY', '+4'],
                        bgColor: Color(0xFF935FC5),
                      ),
                      SizedBox(height: 8),
                      PlannerCard(
                        startHour: '15',
                        startMinute: '00',
                        endHour: '16',
                        endMinute: '30',
                        planTitle: 'WEEKLY\nPLANNING',
                        participant: ['DEN', 'NANA', 'MARK'],
                        bgColor: Color(0xFFB3EC4D),
                      ),
                      // PlannerCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
