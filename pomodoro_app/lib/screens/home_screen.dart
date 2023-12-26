import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum Time {
  fiveSec,
  fiveMin,
  fifteenMin,
  twentyMin,
  twentyFiveMin,
  thirtyMin,
  thirtyFiveMin,
}

class _HomeScreenState extends State<HomeScreen> {
  static const fiveSeconds = 5;
  static const fiveMinutes = 300;
  static const fifteenMinutes = 900;
  static const twentyMinutes = 1200;
  static const twentyFiveMinutes = 1500;
  static const thirtyMinutes = 1800;
  static const thirtyFiveMinutes = 2100;

  static const finalRound = 2;
  static const finalGoal = 3;

  int selectedSeconds = twentyFiveMinutes;
  int totalSeconds = twentyFiveMinutes;
  bool isRunning = false;
  bool isBreakTime = false;
  int round = 0;
  int goal = 0;

  late Timer timer; //? 'late' => 늦은 초기화 선언
  late Timer breakTimer;

  void onBreakTick(Timer timer) {
    setState(() {
      if (totalSeconds == 0) {
        timer.cancel();
        totalSeconds = selectedSeconds;
        isBreakTime = false;
      } else {
        totalSeconds -= 1;
      }
    });
  }

  void onTick(Timer timer) {
    setState(() {
      if (totalSeconds == 0) {
        isRunning = false;
        round += 1;
        timer.cancel();

        //* 4번째 round인 경우
        if (round % finalRound == 0) {
          round = 0;
          goal += 1;
        }

        //* 12번째 goal인 경우
        if (goal % finalGoal == 0) {
          goal = 0;
        }

        //* breaktime
        startBreakTime();
      } else {
        totalSeconds -= 1;
      }
    });
  }

  void startBreakTime() {
    setState(() {
      totalSeconds = fiveMinutes;
      isBreakTime = true;
    });

    breakTimer = Timer.periodic(
      //? 'periodic' => duration마다 하위 함수를 실행
      const Duration(seconds: 1),
      onBreakTick,
    );
  }

  void onStartPressed() {
    if (isBreakTime) {
      return;
    }

    timer = Timer.periodic(
      //? 'periodic' => duration마다 하위 함수를 실행
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    setState(() {
      if (isRunning) {
        isRunning = false;
        timer.cancel();
      }

      if (isBreakTime) {
        isBreakTime = false;
        breakTimer.cancel();
      }

      totalSeconds = selectedSeconds;
    });
  }

  void onTimePressed(Time time) {
    if (isBreakTime) {
      return;
    }

    setState(() {
      if (time == Time.fiveSec) {
        selectedSeconds = fiveSeconds;
      } else if (time == Time.fifteenMin) {
        selectedSeconds = fifteenMinutes;
      } else if (time == Time.twentyMin) {
        selectedSeconds = twentyMinutes;
      } else if (time == Time.twentyFiveMin) {
        selectedSeconds = twentyFiveMinutes;
      } else if (time == Time.thirtyMin) {
        selectedSeconds = thirtyMinutes;
      } else if (time == Time.thirtyFiveMin) {
        selectedSeconds = thirtyFiveMinutes;
      } else {}

      onResetPressed();
    });
  }

  String minuteFormat(int totalSeconds) {
    var duration = Duration(seconds: totalSeconds);
    return duration.toString().substring(2, 4);
  }

  String secondFormat(int totalSeconds) {
    var duration = Duration(seconds: totalSeconds);
    return duration.toString().substring(5, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          //? Flexible widget => flex 값에 따라 연관 widget과의 비율로 크기가 정해짐
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 60,
                horizontal: 40,
              ),
              alignment: Alignment.topLeft,
              child: Text(
                'POMOTIMER',
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: Column(
              children: [
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Row(
                    //? '분' ':' '초' widget 3개 추가
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 190,
                        decoration: BoxDecoration(
                          color: isBreakTime
                              ? Colors.blue[900]!.withOpacity(0.5)
                              : Theme.of(context).cardColor,
                        ),
                        child: Text(
                          minuteFormat(totalSeconds),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.background,
                            fontSize: 80,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        ':',
                        style: TextStyle(
                          fontSize: 80,
                          color: isBreakTime
                              ? Colors.blue[900]!.withOpacity(0.5)
                              : Theme.of(context).cardColor.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 190,
                        decoration: BoxDecoration(
                          color: isBreakTime
                              ? Colors.blue[900]!.withOpacity(0.5)
                              : Theme.of(context).cardColor,
                        ),
                        child: Text(
                          secondFormat(totalSeconds),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.background,
                            fontSize: 80,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                              vertical: 7,
                              // horizontal: 2,
                            )),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            side: MaterialStateProperty.all(
                              BorderSide(
                                color: isBreakTime
                                    ? Colors.blue[900]!.withOpacity(0.5)
                                    : Theme.of(context).cardColor,
                                width: 3,
                              ),
                            ),
                          ),
                          onPressed: () => onTimePressed(Time.fifteenMin),
                          child: Text(
                            '15',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                              color: isBreakTime
                                  ? Colors.blue[900]!.withOpacity(0.5)
                                  : Theme.of(context).cardColor,
                            ),
                          ),
                        ),
                        OutlinedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                              vertical: 7,
                              // horizontal: 2,
                            )),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            side: MaterialStateProperty.all(
                              BorderSide(
                                color: isBreakTime
                                    ? Colors.blue[900]!.withOpacity(0.5)
                                    : Theme.of(context).cardColor,
                                width: 3,
                              ),
                            ),
                          ),
                          onPressed: () => onTimePressed(Time.twentyMin),
                          child: Text(
                            '20',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                              color: isBreakTime
                                  ? Colors.blue[900]!.withOpacity(0.5)
                                  : Theme.of(context).cardColor,
                            ),
                          ),
                        ),
                        OutlinedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                              vertical: 7,
                              // horizontal: 2,
                            )),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            side: MaterialStateProperty.all(
                              BorderSide(
                                color: isBreakTime
                                    ? Colors.blue[900]!.withOpacity(0.5)
                                    : Theme.of(context).cardColor,
                                width: 3,
                              ),
                            ),
                          ),
                          onPressed: () => onTimePressed(Time.twentyFiveMin),
                          child: Text(
                            '25',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                              color: isBreakTime
                                  ? Colors.blue[900]!.withOpacity(0.5)
                                  : Theme.of(context).cardColor,
                            ),
                          ),
                        ),
                        OutlinedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                              vertical: 7,
                              // horizontal: 2,
                            )),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            side: MaterialStateProperty.all(
                              BorderSide(
                                color: isBreakTime
                                    ? Colors.blue[900]!.withOpacity(0.5)
                                    : Theme.of(context).cardColor,
                                width: 3,
                              ),
                            ),
                          ),
                          onPressed: () => onTimePressed(Time.thirtyMin),
                          child: Text(
                            '30',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                              color: isBreakTime
                                  ? Colors.blue[900]!.withOpacity(0.5)
                                  : Theme.of(context).cardColor,
                            ),
                          ),
                        ),
                        OutlinedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                              vertical: 7,
                              // horizontal: 2,
                            )),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            side: MaterialStateProperty.all(
                              BorderSide(
                                color: isBreakTime
                                    ? Colors.blue[900]!.withOpacity(0.5)
                                    : Theme.of(context).cardColor,
                                width: 3,
                              ),
                            ),
                          ),
                          onPressed: () => onTimePressed(Time.thirtyFiveMin),
                          child: Text(
                            '35',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                              color: isBreakTime
                                  ? Colors.blue[900]!.withOpacity(0.5)
                                  : Theme.of(context).cardColor,
                            ),
                          ),
                        ),
                        OutlinedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                              vertical: 7,
                              // horizontal: 2,
                            )),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            side: MaterialStateProperty.all(
                              BorderSide(
                                color: isBreakTime
                                    ? Colors.blue[900]!.withOpacity(0.5)
                                    : Theme.of(context).cardColor,
                                width: 3,
                              ),
                            ),
                          ),
                          onPressed: () => onTimePressed(Time.fiveSec),
                          child: Text(
                            '* 5s',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                              color: isBreakTime
                                  ? Colors.blue[900]!.withOpacity(0.5)
                                  : Theme.of(context).cardColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Column(
                    children: [
                      Center(
                        child: IconButton(
                          iconSize: 120,
                          color: isBreakTime
                              ? Colors.blue[900]!.withOpacity(0.5)
                              : Theme.of(context).cardColor,
                          onPressed:
                              isRunning ? onPausePressed : onStartPressed,
                          icon: Icon(
                            isRunning ? Icons.pause_circle : Icons.play_circle,
                          ),
                        ),
                      ),
                      Center(
                        child: IconButton(
                          iconSize: 40,
                          color: Colors.black38,
                          onPressed: onResetPressed,
                          icon: const Icon(
                            Icons.refresh,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$round/$finalRound',
                        style: TextStyle(
                          fontSize: 30,
                          color: Theme.of(context).cardColor.withOpacity(0.5),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'ROUND',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).cardColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$goal/$finalGoal',
                        style: TextStyle(
                          fontSize: 30,
                          color: Theme.of(context).cardColor.withOpacity(0.5),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'GOAL',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).cardColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
