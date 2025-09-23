import 'package:flutter/material.dart';


abstract class BaseView extends StatefulWidget {
  const BaseView({super.key});
}
 abstract class BaseViewState<Page extends BaseView> extends State<Page>{

 }

