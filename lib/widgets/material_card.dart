import 'package:flutter/material.dart';

class MaterialCard extends StatefulWidget {
  final snap;
  const MaterialCard({Key? key, this.snap}) : super(key: key);

  @override
  State<MaterialCard> createState() => _MaterialCardState();
}

class _MaterialCardState extends State<MaterialCard> {
  @override
  Widget build(BuildContext context) {
    return
      Padding(
          padding: EdgeInsets.all(4),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.library_books_rounded,
                  size: 36, color: Colors.blueGrey.shade400,
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.snap['subName']}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.snap['subTopic'],
                        style: TextStyle(
                            fontWeight: FontWeight.w100, fontSize: 12),
                      ),
                    ]),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.snap['dateTime'],
                        style:
                        TextStyle(fontWeight: FontWeight.w100, fontSize: 12),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ));
  }
}
