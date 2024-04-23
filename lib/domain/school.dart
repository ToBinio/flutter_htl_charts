import 'package:flutter/cupertino.dart';
import 'package:flutter_htl_charts/util/data.dart';

import 'branch.dart';

class School {
  String name;
  List<Branch>? branches;

  School(this.name);

  Future<List<Branch>> fetchBranches(BuildContext context) async {
    return branches ??= await DataFetcher.getBranches(context, this);
  }
}
