import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sms/models.dart';
import 'package:telephony/telephony.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Home extends HookConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phone = ModalRoute.of(context)!.settings.arguments as PhoneArg;
    final msg = useTextEditingController();
    final focusNode = useFocusNode();
    final Telephony telephony = Telephony.instance;
    return Scaffold(
      appBar: AppBar(title: Text(phone.number)),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            reverse: true,
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                  child: Container(
                    // decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(
                      8,
                    ),

                    // height: 55,

                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: msg,
                              focusNode: focusNode,
                              // autofocus: true,
                              // focusNode: myFocusNode,
                              decoration: InputDecoration(
                                  hintText: "ادخل نص الرسالة",
                                  border: InputBorder.none),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(55),
                                color: Colors.white),
                            child: IconButton(
                              onPressed: () async {
                                bool? permissionsGranted = await telephony
                                    .requestPhoneAndSmsPermissions;
                                telephony
                                    .sendSms(
                                        to: phone.number, message: msg.text)
                                    .then((value) {
                                  focusNode.unfocus();
                                  msg.clear();
                                });
                                debugPrint('clicked');
                              },
                              icon: Icon(
                                Iconsax.send_2,
                                size: 35,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(55),
                        color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
