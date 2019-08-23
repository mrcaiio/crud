import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //API Url
  String url = 'https://jsonplaceholder.typicode.com';

  //Get
  Future<List> getData() async {
    http.Response response = await http.get(url + '/posts');
    return json.decode(response.body);
  }

  //Post
  _post() async {
    var body = json.encode({
      "userId": 120,
      "id": null,
      "title": "Teste",
      "body":
          "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
    });

    http.Response response = await http.post(url + '/posts',
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: body);

    print(response.statusCode);
    print(response.body);
  }

  //Put
  _put() async {
    var body = json.encode({
      "userId": 120,
      "id": null,
      "title": "Teste",
      "body":
          "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
    });

    http.Response response = await http.put(url + '/posts/1',
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: body);

    print(response.statusCode);
    print(response.body);
  }

  //Delete
  _delete() async {
    http.Response response = await http.delete(url + '/posts/1',
        headers: {"Content-type": "application/json; charset=UTF-8"});
    print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 20,
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.save),
                    onPressed: _post,
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: _put,
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: _delete,
                  ),
                ],
              ),
              Expanded(
                child: FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                        break;
                      case ConnectionState.active:
                      case ConnectionState.done:
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(snapshot.data[index]['title']),
                                subtitle: Text(snapshot.data[index]['body']),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                              snapshot.data[index]['title']),
                                          content: Text(
                                              snapshot.data[index]['body']),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Close'),
                                            )
                                          ],
                                        );
                                      });
                                },
                              );
                            });
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
