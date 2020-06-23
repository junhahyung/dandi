import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_architecture/core/models/post.dart';
import 'package:provider_architecture/core/models/user.dart';
import 'package:provider_architecture/ui/shared/app_colors.dart';
import 'package:provider_architecture/ui/shared/text_styles.dart';
import 'package:provider_architecture/ui/shared/ui_helpers.dart';
import 'package:provider_architecture/ui/widgets/comments.dart';
import 'package:provider_architecture/ui/views/detail_view.dart';

import 'package:provider_architecture/models/Record.dart';
import 'package:provider_architecture/models/RecordList.dart';
import 'package:provider_architecture/models/RecordService.dart';
import 'package:provider_architecture/helpers/Constants.dart';
//import 'DetailsPage.dart';

class PostView extends StatefulWidget {
  @override
  _PostView createState() {
    return _PostView();
  }
}

class _PostView extends State<PostView> {
  //final Post post;
  //PostView({this.post});
  final TextEditingController _filter = new TextEditingController();

  RecordList _records = new RecordList();
  RecordList _filteredRecords = new RecordList();

  String _searchText = "";

  Icon _searchIcon = new Icon(Icons.search);

  Widget _appBarTitle = new Text(appTitle);

  @override
  void initState() {
    super.initState();

    _records.records = new List();
    _filteredRecords.records = new List();

    _getRecords();
  }

  void _getRecords() async {
    RecordList records = await RecordService().loadRecords();
    setState(() {
      for (Record record in records.records) {
        this._records.records.add(record);
        this._filteredRecords.records.add(record);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      backgroundColor: appGreyColor,
      body: _buildList(context),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
        elevation: 0.1,
        backgroundColor: appGreyColor,
        centerTitle: true,
        title: _appBarTitle,
        actions: [new IconButton(
            icon: _searchIcon,
            onPressed: _searchPressed
        )
        ]
    );
  }

  Widget _buildList(BuildContext context) {
    if (!(_searchText.isEmpty)) {
      _filteredRecords.records = new List();
      for (int i = 0; i < _records.records.length; i++) {
        //for (int j = 0; j < _records.records[i].career.length; j++) {
        if (_records.records[i].name.toLowerCase().contains(
            _searchText.toLowerCase())
            || _records.records[i].address.toLowerCase().contains(
                _searchText.toLowerCase())
        )
        {
          _filteredRecords.records.add(_records.records[i]);
        }
      };
    }
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: this._filteredRecords.records.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, Record record) {
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
                  tag: "avatar_" + record.name,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(record.photo),
                  )
              )
          ),
          title: Text(
            record.name,
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
                            text: record.address,
                            style: TextStyle(color: Colors.grey),
                          ),
                          maxLines: 3,
                          softWrap: true,
                        )
                      ]))
            ],
          ),
          trailing:
          Icon(Icons.keyboard_arrow_right, color: Color.fromRGBO(21, 48, 132, 1), size: 30.0),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => new DetailPage(record: record)));
          },
        ),
      ),
    );
  }
  //search
  _PostView() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          _resetRecords();
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  void _resetRecords() {
    this._filteredRecords.records = new List();
    for (Record record in _records.records) {
      this._filteredRecords.records.add(record);
    }
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          style: new TextStyle(color: Colors.black),
          decoration: new InputDecoration(
            prefixIcon: new Icon(Icons.search, color: Colors.black),
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text(appTitle);
        _filter.clear();
      }
    });
  }

}
