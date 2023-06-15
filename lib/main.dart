import 'package:flutter/material.dart';

import 'offices.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Networking Json demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Networking Json'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<OfficesList>? officesList;
  @override
  void initState() {
    super.initState();
    officesList = getOfficesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: FutureBuilder<OfficesList>(
          future: officesList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.offices.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text('${snapshot.data?.offices[index].name}'),
                        subtitle:
                            Text('${snapshot.data?.offices[index].address}'),
                        leading: Image.network(
                            '${snapshot.data?.offices[index].image}'),
                        isThreeLine: true,
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return const Text('Error!');
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
