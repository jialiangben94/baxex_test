import 'package:baseX/baseX.dart';
import 'package:flutter/material.dart';

class BaseXConfig extends BaseX {
  @override
  Widget get defaultLoadingWidget => const Center(
          child: CircularProgressIndicator(
        color: Colors.black,
      ));
}
