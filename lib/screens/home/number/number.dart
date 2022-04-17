import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sms/models.dart';
import 'package:sms/screens/home/home.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Number extends HookConsumerWidget {
  const Number({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phone = useTextEditingController();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(55),
                    color: Theme.of(context).primaryColor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: phone,
                    // autofocus: true,
                    // focusNode: myFocusNode,
                    decoration: InputDecoration(
                        hintText: "رقم الهاتف", border: InputBorder.none),
                  ),
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => Home(),
                        settings: RouteSettings(
                            name: 'home',
                            arguments: PhoneArg(number: phone.text))),
                  );
                },
                child: Text('متابعة'))
          ],
        ),
      ),
    );
  }
}
