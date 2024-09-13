import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';


class DataTableExample extends StatefulWidget {
  @override
  _DataTableExampleState createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  late Future<List<List<dynamic>>> _data;

  @override
  void initState() {
    super.initState();
    _data = loadAndProcessCSV();
  }

  Future<List<List<dynamic>>> loadAndProcessCSV() async {
    // Load CSV file from assets
    String csvString = await rootBundle.loadString('assets/Master Files/Hokkaido Tactical Map - 1-master.csv');

    // Convert CSV string to 2D list
    List<List<dynamic>> csvData = CsvToListConverter().convert(csvString);

    // Ensure that all rows have the same number of columns as the headers
    List<List<dynamic>> formattedData = ensureColumns(csvData);

    return formattedData;
  }

  List<List<dynamic>> ensureColumns(List<List<dynamic>> data) {
    if (data.isEmpty) return [];

    // Extract column headers
    List<dynamic> headers = data[0];
    int numColumns = headers.length;

    // Ensure that each row has the same number of columns as the headers
    List<List<dynamic>> output = [headers];
    for (var row in data.sublist(1)) {
      if (row.length < numColumns) {
        row.addAll(List.filled(numColumns - row.length, ''));
      }
      output.add(row.sublist(0, numColumns));
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DataTable Example'),
      ),
      body: FutureBuilder<List<List<dynamic>>>(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available.'));
          }

          List<List<dynamic>> data = snapshot.data!;

          // Extract column headers from the first row of the 2D list
          final headers = data.isNotEmpty ? data[0] : [];

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: headers.map((header) => DataColumn(
                label: Text(header.toString()),
              )).toList(),
              rows: data.sublist(1).map((row) {
                return DataRow(
                  cells: row.map((cell) => DataCell(
                    Text(cell.toString()),
                  )).toList(),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
