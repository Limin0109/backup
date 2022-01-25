import 'package:biofuture/page/subsribe_patreon.dart';
import 'package:flutter/material.dart';

class SubscriptionList extends StatefulWidget {
  const SubscriptionList({Key? key}) : super(key: key);

  @override
  State<SubscriptionList> createState() => _SubscriptionListState();
}

class _SubscriptionListState extends State<SubscriptionList> {
  //final _savedSubPatreons = <String>{};

  Widget _buildList() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 100,
            color: const Color(0xFFE0FBFC), //Colors.amber[600],
            child: const Center(child: Text('View Current Patreon Packages')),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => SubscribedPackages()));
          },
          child: Container(
            height: 100,
            color: const Color(0xFFC2DFE3), //Colors.amber[500],
            child: const Center(child: Text('Subscribe Patreon Packages')),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 100,
            color: const Color(0xFF9DB4C0), //Colors.amber[100],
            child: const Center(child: Text('Cancel Patreon Packages')),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //return Container(color: const Color(0xFFC2DFE3));
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(), title: const Text('Patreon Subscriptions')),
      body: _buildList(),
      //const Text('Hello'),
    );
  }
}
