import 'package:flutter/material.dart';
import 'package:provider_architecture/models/Record.dart';

// 1
class DetailPage extends StatelessWidget {
  final Record record;
  // 2
  DetailPage({this.record});

  get MyList => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(225, 225, 225, 0.5),
          actions: [
            IconButton(
              icon: new Icon(Icons.more_horiz),
              onPressed: () {
                // TODO: implement
              },
            ),
          ],
        ),
        body: _buildProfile(context),
    );
  }


  Widget _buildProfile (BuildContext context) {

    List<String> myList = List<String>();
    for (int i = 0; i < record.career.length; i++){
      myList.add(record.career[i]);
      //return myList;
    }
    List<String> myListsub = List<String>();
    for (int i = 0; i < record.careersub.length; i++){
      myListsub.add(record.careersub[i]);
      //return myList;
    }

    return ListView(children :[
      Stack(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height - 82.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent),
            Positioned(
                bottom: 350.0,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(45.0),
                          bottomRight: Radius.circular(45.0),
                        ),
                        color: Color.fromRGBO(225, 225, 225, 0.5)),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width)),
            Positioned(
                top: 300.0,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45.0),
                          topRight: Radius.circular(45.0),
                        ),
                        color: Colors.blue),
                    height: MediaQuery.of(context).size.height - 100.0,
                    width: MediaQuery.of(context).size.width)),

            Positioned.fill(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Hero(
                        tag: record.name,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(record.photo),
                        ))
                )),
            //SizedBox(height: 20.0),
            Positioned.fill(
                top: 130.0,
                child: Align(
                    child: Column(
                      children: <Widget>[
                        Text(
                          record.name,
                          style: TextStyle(fontSize: 21, color: Color.fromRGBO(21, 48, 132, 1), fontWeight: FontWeight.bold, letterSpacing: 3),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          record.address + ' | ' + record.country,
                          style: TextStyle(fontSize: 12, color: Color.fromRGBO(65, 105, 225, 1), fontWeight: FontWeight.normal),
                        )
                      ],
                    ))
            ),
            SizedBox(height: 100.0),
            Positioned.fill(
              top: 300.0,
                child: Padding(
                    padding: new EdgeInsets.all(10.0),
                    child: GridView.builder(
                      itemCount: record.career.length,
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index){
                      return Container(
                          //margin: const EdgeInsets.only(top: 2.0, bottom: 1.0, right: 10.0),
                        child: Card(
                        //elevation: 20.0,
                          margin: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                        //margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
                          child: ListTile(
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                            leading: Container(
                                padding: EdgeInsets.only(right: 12.0),
                                //decoration: new BoxDecoration(
                                //    border: new Border(
                                //        right: new BorderSide(width: 1.0, color: Colors.cyan))),
                                child: Container(
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(record.photo),
                                     ),
                                      borderRadius: BorderRadius.circular(100.0),
                                    ),
                                )
                            ),
                            title: Text(
                              myList[index],//record.career[0],
                              style: TextStyle(fontSize: 12, color: Colors.black),
                            ),
                            subtitle: Row(
                              children: <Widget>[
                                new Flexible(
                                    child: new Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          RichText(
                                            text: TextSpan(
                                              text: myListsub[index],
                                              style: TextStyle(fontSize: 13, color: Colors.grey),
                                            ),
                                            //maxLines: 3,
                                            softWrap: true,
                                          )
                                        ]))
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => new DetailPage(record: record)));
                            },
                          ),
                        ),
                      )
                      );


                        /*

                      return Card(
                          margin: EdgeInsets.all(10.0),
                          color: Colors.purpleAccent,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0, top: 6.0, bottom: 2.0),
                            child: Center(child: Text(myList[index], style: TextStyle(fontSize: 14, color: Colors.black54))),
                      )
                      );

                      */
                }
                )
                )

                /*

                Column(
                  children: <Widget>[
                _buildCardItem(context)
  ]
    )
                */

            )
          ]
      ),
      //new Text(' ${record.contact}'),
    ]
    );
  }

/*
  Widget _buildCardItem(BuildContext context){
    List<String> myList = List<String>();
    for (int i = 0; i < record.career.length; i++){
      myList.add(record.career[i]);
      return myList;
    }

    return Card(
      key: ValueKey(record.name),
      //elevation: 1.0,
      margin: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.0)),
        child: ListTile(
          contentPadding:
          EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              //decoration: new BoxDecoration(
              //    border: new Border(
              //        right: new BorderSide(width: 1.0, color: Colors.cyan))),
              child: Hero(
                  tag: "avatar_" + record.career[0],
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(record.photo),
                  )
              )
          ),
          title: Text(
            myList,//record.career[0],
            style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 3),
          ),
          subtitle: Row(
            children: <Widget>[
              new Flexible(
                  child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: record.careersub[0],
                            style: TextStyle(color: Colors.grey),
                          ),
                          maxLines: 3,
                          softWrap: true,
                        )
                      ]))
            ],
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => new DetailPage(record: record)));
          },
        ),
      ),
    );
  }
  */

/*
  Widget _buildCard(BuildContext context) {
    _recordcareerList = new List();
      for (int i = 0; i < record.career.length; i++) {
        _recordcareerList.add(record.career[i]);
      };
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: this._recordcareerList.map((data) => _buildCardItem(context)).toList(),
    );
  }
*/

  }