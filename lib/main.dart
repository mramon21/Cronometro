import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:async';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cronômetro',
      home: Cronometro(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Cronometro extends StatefulWidget {
  const Cronometro({super.key});

  @override
  _CronometroState createState() => _CronometroState();
}

class _CronometroState extends State<Cronometro> {
  final Stopwatch stopwatch = Stopwatch();
  Timer? timer;

  void iniciar() {
    stopwatch.start();
    timer ??= Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
  }

  bool get isRunning => stopwatch.isRunning;

  void parar() {
    setState(() {
      stopwatch.stop();
    });
  }

  void zerar() {
    stopwatch.reset();
  }

  @override
  Widget build(BuildContext context) {
    final duration = stopwatch.elapsed;

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String threeDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final milliseconds = threeDigits(duration.inMilliseconds.remainder(1000));

    final tempoFormatado = "$hours:$minutes:$seconds:$milliseconds";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Cronômetro"),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(child: SizedBox(height: 200)),
            Text(tempoFormatado, style: const TextStyle(fontSize: 40)),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.grey,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                    ),
                    onPressed: () {
                      setState(() {
                        isRunning ? parar() : iniciar();
                      });
                    },
                    child: Icon(
                      isRunning ? Icons.pause : Icons.play_arrow,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.grey,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                    ),
                    onPressed: () {
                      setState(() {
                        parar();
                        zerar();
                      });
                    },
                    child: Icon(Icons.restart_alt, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
