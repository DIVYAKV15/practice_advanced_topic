import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main()
{
  runApp(MaterialApp(home: ChangeNotifierProvider(create: ThemeProvider(),child: ChangeAppTheme()),));
}

class ChangeAppTheme extends StatelessWidget {
  const ChangeAppTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
