import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import '../api.dart';

ListView buildPredsList(data) {
  return ListView.builder(
    itemBuilder: (context, index) {
      // get keys to a lost (the words)
      var keys = [];
      data.forEach((K, V) {
        keys.add(K);
      });
      // header row
      if (index == 0) {
        return Container(
          color: Colors.red[100],
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Word"),
              Text(
                "Classification",
                maxLines: 2,
              ),
            ],
          ),
        );
      }
      // reset index to ignore row
      index -= 1;
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(keys[index]),
            Text(
              data[keys[index]],
              maxLines: 2,
              overflow: TextOverflow.visible,
            ),
          ],
        ),
      );
    },
    itemCount: data.keys.length + 1,
    shrinkWrap: true,
  );
}

Consumer buildConsumer() {
  return Consumer(builder: (context, watch, child) {
    // set initial value
    var res = watch(responseProvider);
    return res.when(
      data: (data) {
        // handle returned error
        if (data['detail'] != null) {
          return FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
                Text(
                  data['detail'],
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          );
        } else
          return buildPredsList(data);
      },
      loading: () => Padding(
        padding: const EdgeInsets.all(10.0),
        child: CircularProgressIndicator(),
      ),
      error: (err, stack) => Text(err.toString()),
    );
  });
}
