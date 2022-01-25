import 'package:flutter/material.dart';

class SubscribedPackages extends StatefulWidget {
  const SubscribedPackages({ Key? key }) : super(key: key);

  @override
  State<SubscribedPackages> createState() => SubscribedPackagesState();
}

class SubscribedPackagesState extends State<SubscribedPackages> {
  final _savedPackageItems = <String>{};

  Widget _buildList() {
    final List<String> subscribedPackageItems = <String>['Unlimited downloads!', 'Chat with professionals!'];
    //final List<int> colorCodes = <int>[600, 500];

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: subscribedPackageItems.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildRow(subscribedPackageItems[index]);
      }
    );
  }

  Widget _buildRow(packageName) {         //the list subscribed package funtion
    final _alreadySaved = _savedPackageItems.contains(packageName);

    return ListTile(
      title: Text(packageName, style: const TextStyle(fontSize: 18.0)),
      trailing: Icon(_alreadySaved ? Icons.favorite : Icons.favorite_border,
                    color: _alreadySaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if(_alreadySaved) {
            _savedPackageItems.remove(packageName);
          } 
          else {
            _savedPackageItems.add(packageName);
          }
        });
      } //onTap function
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = 
          _savedPackageItems.map((packageName) {
            return ListTile(
              title: Text(packageName, style: const TextStyle(fontSize: 16.0))
            );
          });

          //To create dividers
          final List<Widget> dividers = ListTile.divideTiles(
            context: context,
            tiles: tiles
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Subscribed Packages')
            ),
            body: ListView(children: dividers));
        }
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    //return Container(color: const Color(0xFFC2DFE3));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patreon Subscriptions'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved
          )
        ],
        ),
        body: _buildList(),
        //const Text('Hello'),
    );
  }
}
