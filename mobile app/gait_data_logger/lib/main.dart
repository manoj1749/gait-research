// Flutter Sensor Data Logger App
// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:csv/csv.dart';
import 'package:open_file_plus/open_file_plus.dart';

void main() => runApp(const SensorLoggerApp());

class SensorLoggerApp extends StatelessWidget {
  const SensorLoggerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoggingHome(),
    );
  }
}

class LoggingHome extends StatefulWidget {
  const LoggingHome({super.key});

  @override
  _LoggingHomeState createState() => _LoggingHomeState();
}

class _LoggingHomeState extends State<LoggingHome> {
  late WebSocketChannel channel;
  bool loggingActive = false;
  List<List<String>> csvData = [];
  String displayedData = "";
  String? csvFilePath;

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  void startLogging(String url) {
    channel = WebSocketChannel.connect(Uri.parse(url));
    setState(() {
      loggingActive = true;
    });
    channel.stream.listen((message) {
      processMessage(message);
    }, onError: (error) {
      showMessage("WebSocket Error: $error");
    }, onDone: () {
      setState(() {
        loggingActive = false;
      });
      showMessage("WebSocket Closed.");
    });
  }

  void stopLogging() {
    channel.sink.close();
    setState(() {
      loggingActive = false;
    });
    showMessage("Logging Stopped.");
  }

void processMessage(String message) {
  String timestamp = DateTime.now().toString();
  List<String> dataLines = message.split('\n');

  // Extract hardcoded data lengths
  List<String> mpuData = [
    dataLines.firstWhere((line) => line.contains("MPU6050 1"), orElse: () => "MPU6050_1 Missing"),
    dataLines.firstWhere((line) => line.contains("MPU6050 2"), orElse: () => "MPU6050_2 Missing"),
    dataLines.firstWhere((line) => line.contains("MPU6050 3"), orElse: () => "MPU6050_3 Missing"),
    dataLines.firstWhere((line) => line.contains("MPU6050 4"), orElse: () => "MPU6050_4 Missing"),
  ];

  List<String> flexData = [
    dataLines.firstWhere((line) => line.contains("Bend Sensor 1"), orElse: () => "Flex Sensor 1 Missing"),
    dataLines.firstWhere((line) => line.contains("Bend Sensor 2"), orElse: () => "Flex Sensor 2 Missing"),
  ];

  print(mpuData);
  print(flexData);
  csvData.add([timestamp, mpuData[0],mpuData[1],mpuData[2],mpuData[3], flexData[0],flexData[1]]);
  displayedData = "$timestamp\n${mpuData[0]}\n${mpuData[1]}\n${mpuData[2]}\n${mpuData[3]}\n${flexData[0]}\n${flexData[1]}\n$displayedData";
  // for (int i = 0; i < 4; i++) {
  //   String currentFlex = i < 2 ? flexData[i] : "";

  //   // csvData.add([timestamp, mpuData[i], currentFlex]);
  //   displayedData = "$timestamp\n${mpuData[i]}\n$currentFlex\n$displayedData";
  // }
}


  Future<void> viewCsvFile() async {
    final directory = await getApplicationDocumentsDirectory();
    String timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
    csvFilePath = '${directory.path}/sensor_data_$timestamp.csv';
    String csvContent = const ListToCsvConverter().convert(csvData);
    File csvFile = File(csvFilePath!);
    await csvFile.writeAsString(csvContent);
    await OpenFile.open(csvFilePath);
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController urlController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Sensor Data Logger")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                labelText: "WebSocket URL",
                hintText: "ws://192.168.4.1/ws",
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: SingleChildScrollView(
                  child: Text(displayedData, style: const TextStyle(fontSize: 14)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            loggingActive
                ? ElevatedButton(
                    onPressed: stopLogging,
                    child: const Text("Stop Logging"),
                  )
                : ElevatedButton(
                    onPressed: () {
                      if (urlController.text.isNotEmpty) {
                        startLogging(urlController.text);
                      } else {
                        startLogging("ws://192.168.4.1/ws");
                      }
                    },
                    child: const Text("Start Logging"),
                  ),
            if (!loggingActive && csvData.isNotEmpty)
              ElevatedButton(
                onPressed: viewCsvFile,
                child: const Text("View CSV File"),
              ),
          ],
        ),
      ),
    );
  }
}
