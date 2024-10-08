import 'dart:ui';

import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  List<List<dynamic>> data = [];

  List<List<dynamic>> convertTo6x10(List<List<dynamic>> input) {
    // Flatten the list if necessary (in this case, input[0] is already a flat list)
    List<dynamic> flatList = input.expand((i) => i).toList();

    // Define the number of columns
    int columns = 6;

    // Convert the flat list into a 2D list with 6 columns
    List<List<dynamic>> output = [];
    for (int i = 0; i < flatList.length; i += columns) {
      // Ensure we don't go out of bounds with the sublist
      output.add(flatList.sublist(i, (i + columns > flatList.length) ? flatList.length : i + columns));
    }

    return output;
  }


  List<List<dynamic>> removeLastColumn(List<List<dynamic>> twoDList) {
    // Iterate through each row and remove the last element if the row is not empty
    for (var row in twoDList) {
      if (row.isNotEmpty) {
        row.removeLast();
      }
    }
    return twoDList;
  }
  List<List<dynamic>> input = [
    [
      'ID', 'Description', 'Faction', 'X', 'Y', 'Group',
      1, '1x DDG; 1x FFG; 1x Corvette; 1x Minesweeper; 2x Helicopter', 'RED', 5, 12, 'Surface',
      2, 'Maritime Militia Vessel', 'RED', 4, 7, 'Surface',
      3, 'Maritime Militia Vessel', 'RED', 2, 6, 'Surface',
      4, 'Maritime Militia Vessel', 'RED', 2, 5, 'Surface',
      5, 'Maritime Militia Vessel', 'RED', 3, 3, 'Surface',
      6, 'Merchant vessel', 'PURPLE', 4, 1, 'Surface',
      7, 'Merchant vessel', 'PURPLE', 6, 3, 'Surface',
      8, 'Merchant vessel', 'PURPLE', 9, 5, 'Surface',
      9, 'Merchant vessel', 'PURPLE', 5, 8, 'Surface',
    ]
  ];


  String map="M A P";
  String player="player";

  List map_asset= [
    "assets/No Grid Maps/Hokkaido Tactical Map - 1.png",
    "assets/No Grid Maps/Hokkaido Tactical Map - 2.png",
    "assets/No Grid Maps/Hokkaido Tactical Map - 3.png",
    "assets/No Grid Maps/Hokkaido Tactical Map - 4.png",
    "assets/No Grid Maps/Miyako Straight Tactical Map - 1.png",
    "assets/No Grid Maps/Miyako Straight Tactical Map - 2.png",
    "assets/No Grid Maps/Operational Map.png",
    "assets/No Grid Maps/Sakishimas Tactical Map - 1.png",
    "assets/No Grid Maps/Sakishimas Tactical Map - 2.png"
  ];

  @override
  void initState() {
    super.initState();
    valueChoose = map_asset[0];
    _loadCSV();
    List<List<dynamic>> output = convertTo6x10(input);
    print(output);
    output = removeLastColumn(output);
    data= output;
    print(data);
  }

  void _loadCSV() async {
    final rawData = await rootBundle.loadString('assets/Master Files/Hokkaido Tactical Map - 1-master.csv');
    // Parse CSV string to 2D list
    List<List<dynamic>> input = CsvToListConverter().convert(rawData);


  }

  String valueChoose ="";
  @override
  Widget build(BuildContext context) {
    final headers = data.isNotEmpty ? data[0] : [];
    return Scaffold(
        body:  Center(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/2.4,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.grey[400],
                      child: Column(
                          children: [
                            Container(
                                height: MediaQuery.of(context).size.height/2.5,
                                width: MediaQuery.of(context).size.width/2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          AutoSizeText('Selected Map :',style: GoogleFonts.robotoSlab(fontSize: 20,),),
                                          SizedBox(width: 10,),
                                          DropdownButton(
                                              value: valueChoose,
                                              items: map_asset.map((value_items) {
                                                return DropdownMenuItem(
                                                  value: value_items,
                                                  child: AutoSizeText(value_items.toString().substring(20,value_items.toString().length-4),style: GoogleFonts.robotoSlab(fontSize: 20,),),
                                                );
                                              }).toList(),
                                              onChanged: (newValue){
                                                setState(() {
                                                  valueChoose = newValue.toString();
                                                });
                                              })
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Container(
                                        height: MediaQuery.of(context).size.height/20,
                                        width: MediaQuery.of(context).size.width/2,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(onPressed: (){}, child:
                                            AutoSizeText('Choose another Map',style: GoogleFonts.robotoSlab(fontSize: 20,),)),
                                            AutoSizeText('Current Player : $player',style: TextStyle(fontSize: 20,),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Text('Define Assets:',style: TextStyle(fontSize: 20,),),
                                      SizedBox(height: 4,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 300,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                labelText: 'Asset Name',
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(onPressed: (){}, child:
                                          Text('Define',style: TextStyle(fontSize: 20,),)),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(onPressed: (){}, child:
                                          Text('Mark as Killed',style: TextStyle(fontSize: 20,),)),
                                          ElevatedButton(onPressed: (){}, child:
                                          Text('Unkill an Asset',style: TextStyle(fontSize: 20,),)),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(onPressed: (){}, child:
                                          Text('Switch Player',style: TextStyle(fontSize: 20,),)),
                                          ElevatedButton(onPressed: (){}, child:
                                          Text('Assign a Job',style: TextStyle(fontSize: 20,),)),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(onPressed: (){}, child:
                                          Text('Edit an Asset',style: TextStyle(fontSize: 20,),)),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                            ),
                            Container(
                                height: MediaQuery.of(context).size.height/2,
                                width: MediaQuery.of(context).size.width/2.2,
                                color: Colors.grey[400],
                                child: Center(
                                  child:SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                      border: TableBorder.all(
                                        color: Colors.black,
                                      ),
                                      horizontalMargin: 10,
                                     dividerThickness: 1,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                      ),
                                      dataRowHeight: 25,
                                      columnSpacing: 25,
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
                                  ),
                                )),

                          ]),
                    ),


                    Container(
                      width: MediaQuery.of(context).size.width/1.72,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.red,
                      child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width/1.5,
                              height: MediaQuery.of(context).size.height/1.2,
                              color: Colors.orange,
                              child: GridPaper(
                                interval: 45,
                                divisions: 2,
                                subdivisions: 1,
                                color: Colors.black45,
                                child: Image.asset('$valueChoose',fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width/1.5,
                              height: MediaQuery.of(context).size.height/6,
                              color: Colors.grey[400],
                              child: Center(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 15,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onPressed: (){}, icon: Image.asset('assets/Tool Icons/Fighter-Air.png',
                                        height: 50,
                                        width: 50,
                                      )),
                                      SizedBox(
                                        width:  2,
                                      ),
                                      IconButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 200,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onPressed: (){}, icon: Image.asset('assets/Tool Icons/Helo-Air.png',
                                        height: 50,
                                        width: 50,
                                      )),
                                      SizedBox(
                                        width:  2,
                                      ),
                                      IconButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 200,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onPressed: (){}, icon: Image.asset('assets/Tool Icons/LUSV-Surface.png',
                                        height: 50,
                                        width: 50,
                                      )),
                                      SizedBox(
                                        width:  2,
                                      ),
                                      IconButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 200,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onPressed: (){}, icon: Image.asset('assets/Tool Icons/LUUV-Undersea.png',
                                        height: 50,
                                        width: 50,
                                      )),
                                      SizedBox(
                                        width:  2,
                                      ),
                                      IconButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 200,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onPressed: (){}, icon: Image.asset('assets/Tool Icons/Maritime Militia-Surface.png',
                                        height: 50,
                                        width: 50,
                                      )),
                                      SizedBox(
                                        width:  2,
                                      ),
                                      IconButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 200,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onPressed: (){}, icon: Image.asset('assets/Tool Icons/MPA-Air.png',
                                        height: 50,
                                        width: 50,
                                      )),
                                      SizedBox(
                                        width:  2,
                                      ),
                                      IconButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 200,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onPressed: (){}, icon: Image.asset('assets/Tool Icons/Musv-Surface.png',
                                        height: 50,
                                        width: 50,
                                      )),
                                      SizedBox(
                                        width:  2,
                                      ),
                                      IconButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 200,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onPressed: (){}, icon: Image.asset('assets/Tool Icons/Saildrone-Air.png',
                                        height: 50,
                                        width: 50,
                                      )),
                                      SizedBox(
                                        width:  2,
                                      ),
                                      IconButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 200,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onPressed: (){}, icon: Image.asset('assets/Tool Icons/SUAS-Air.png',
                                        height: 50,
                                        width: 50,
                                      )),
                                      SizedBox(
                                        width:  2,
                                      ),
                                      IconButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 200,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onPressed: (){}, icon: Image.asset('assets/Tool Icons/Submarine-Undersea.png',
                                        height: 50,
                                        width: 50,
                                      )),
                                      SizedBox(
                                        width:  2,
                                      ),
                                      IconButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 200,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onPressed: (){}, icon: Image.asset('assets/Tool Icons/Surface Ship-Surface.png',
                                        height: 50,
                                        width: 50,
                                      )),
                                      SizedBox(
                                        width:  2,
                                      ),
                                      IconButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 200,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onPressed: (){}, icon: Image.asset('assets/Tool Icons/SUUV-Undersea.png',
                                        height: 50,
                                        width: 50,
                                      )),
                                      SizedBox(
                                        width:  2,
                                      ),
                                      IconButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 200,
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onPressed: (){}, icon: Image.asset('assets/Tool Icons/USA Helo-Air.png',
                                        height: 50,
                                        width: 50,
                                      )),


                                    ]),
                              ),
                            ),
                          ]),
                    ),
                  ])
          ),
        ));
  }
}
