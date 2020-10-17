import 'package:bloc_state_management/pages/news_page.dart';
import 'package:flutter/material.dart';
import 'package:bloc_state_management/widgets/btnAction.dart';
import 'package:bloc_state_management/bloc/counter_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    print('dispose');
    counterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.ac_unit),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NewsPage()));
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder(
              initialData: 0,
              stream: counterBloc.stateStream,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text('${snapshot.error}');
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnAction(CounterAction.Increment),
          BtnAction(CounterAction.Dicrement),
          BtnAction(CounterAction.Reset),
        ],
      ),
    );
  }
}
