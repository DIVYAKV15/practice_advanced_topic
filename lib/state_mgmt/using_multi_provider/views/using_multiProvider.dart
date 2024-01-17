import 'package:flutter/material.dart';
import 'package:practice_advanced_topic/state_mgmt/using_multi_provider/provider/auth_provider.dart';
import 'package:practice_advanced_topic/state_mgmt/using_multi_provider/provider/counter_provider_ex.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    home: MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => CountProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => AuthProvider(),
      ),
    ], child: const UsingMultiProvider()),
  ));
}

class UsingMultiProvider extends StatelessWidget {
  const UsingMultiProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("counter value", style: TextStyle(fontSize: 20)),
            ElevatedButton(
                onPressed: () {
                  Provider.of<CountProvider>(context, listen: false)
                      .increment();
                },
                child: const Text("Increment Counter")),
            //instead of creating object we can directly call
            Text("Count Value:${Provider.of<CountProvider>(context).count}",
                style: const TextStyle(fontSize: 20)),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Auth Details",
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false).loogedIn
                      ? Provider.of<AuthProvider>(context, listen: false)
                          .logOut()
                      : Provider.of<AuthProvider>(context, listen: false)
                          .logIn();
                },
                child: const Text("Switch Login")),
            Consumer<AuthProvider>(
              builder: (context, authProvider, child) => Text(
                  "user is ${authProvider.loogedIn ? "Logged In" : "LoggedO Out"}"),
            ),
          ],
        ),
      ),
    );
  }
}
