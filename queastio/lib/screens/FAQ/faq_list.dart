import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queastio/models/faq.dart';
import 'package:queastio/screens/FAQ/faq_tile.dart';

class FaqList extends StatefulWidget {
  @override
  _FaqListState createState() => _FaqListState();
}

class _FaqListState extends State<FaqList> {
  @override
  Widget build(BuildContext context) {
    final faqs = Provider.of<List<Faq>>(context);

    return ListView.builder(
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        return FaqTile(faq: faqs[index]);
      },
    );
  }
}
