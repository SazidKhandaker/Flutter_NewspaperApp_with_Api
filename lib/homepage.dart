import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:newspapaer_app/connect/connecthttp.dart';
import 'package:newspapaer_app/important/importantpage.dart';
import 'package:newspapaer_app/modeclass/modelclass.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageNo = 1;
  String sortBy = "popularity";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.red.shade100,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
          color: Colors.red.shade100,
        ),
        title: Text(
          "NewsPaper App",
          style: myStyle(20, Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 80,
                  child: Row(
                    children: [
                      ElevatedButton(onPressed: () {}, child: Text("Pervious")),
                      Container(
                        height: 20,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            shrinkWrap: true,
                            itemBuilder: ((context, index) {
                              return Container(
                                  height: 20,
                                  width: 20,
                                  color: pageNo == index
                                      ? Colors.blue
                                      : Colors.red,
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: GestureDetector(
                                      onDoubleTap: () {
                                        setState(() {
                                          pageNo = index;
                                        });
                                      },
                                      child:
                                          Center(child: Text('${index + 1}'))));
                            })),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {});
                          },
                          child: Text("Next")),
                    ],
                  )),
              FutureBuilder<List<Articles>>(
                future: CustomeHttp()
                    .fetchAllNewsData(pageNo: pageNo, sortBy: sortBy),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text(" Data has not come");
                  } else if (snapshot.data == null) {
                    return Text("No Data");
                  }
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.network(
                              "${snapshot.data![index + 3].urlToImage}"),
                          title: Text("${snapshot.data![index].title}"),
                          subtitle:
                              Text("${snapshot.data![index].description}"),
                        );
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
