import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {

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
  }

  String valueChoose ="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Center(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/3,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.grey[400],
                      child: Column(
                          children: [
                            Container(
                                height: MediaQuery.of(context).size.height/2,
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
                              width: MediaQuery.of(context).size.width/2,
                              color: Colors.grey[400],
                              child: Center(
                                child: Text("ref table",style: TextStyle(fontSize: 20,),),
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/1.5,
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
