import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../models/user.dart';
import '../../view_models/user_view_model.dart';
import 'package:grosseries/components/input_qty.dart';

class ManageReminders extends StatefulWidget {
  const ManageReminders({super.key});

  @override
  State<ManageReminders> createState() => _ManageRemindersState();
}

class _ManageRemindersState extends State<ManageReminders> {
  @override
  Widget build(BuildContext context) {
    User? currentUser = context.watch<UserViewModel>().currentUser;
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          backgroundColor: Colors.yellow[200],
          elevation: 1,
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.black),
            onPressed: (() => GoRouter.of(context).pop()),
          ),
          title: const Text('Manage Reminders'),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_horiz, color: Colors.black),
              onPressed: (() => GoRouter.of(context).go("/edit_profile_more")),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: SwitchListTile(
                    title: const Text(
                        'Turn on push notifications and always cook your food before it expires.',
                        style: TextStyle(fontSize: 15)),
                    value: currentUser!.notificationsEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        currentUser.notificationsEnabled = value;
                      });
                    })),
            const Padding(
                padding: EdgeInsets.all(25),
                child: Text(
                    "When would you like to receive a reminder that your items are about to expire?",
                    style: TextStyle(fontSize: 15))),
            InputQty(
              initVal: currentUser.notificationDayAmount,
              minVal: 0,
              maxVal: 100,
              onQtyChanged: (val) {
                currentUser.notificationDayAmount = val!.toInt();
              },
              id: currentUser.id,
              view: 'manage-reminders',
            ),
            const Text("days")
          ],
        ));
  }
}
