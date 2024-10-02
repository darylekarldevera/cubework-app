import 'package:flutter/material.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        SizedBox(
          height: 200,
          width: double.infinity,
          child: Column(
            children: [
              const Text("My Account",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"),
                      ),
                      Text("John Doe", style: TextStyle(fontSize: 20)),
                      Text("daryle@gmail.com")
                    ]),
                  ),
                ),
              )
            ],
          ),
        ),
        Wrap(
          children: [
            Transform.translate(
              offset: const Offset(20, 10),
              child: const Text("Setting",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: InkWell(
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: const Text("Language",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    leading: const Icon(Icons.language),
                                    onTap: () {
                                      print("Language");
                                      // Navigator.pushNamed(context, "/change-password");
                                    },
                                  ),
                                ),
                                const Icon(Icons.arrow_right_sharp)
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: const Text("Display Theme",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    leading: const Icon(Icons.brightness_6),
                                    subtitle: const Text("Light"),
                                    onTap: () {
                                      print("Language");
                                      // Navigator.pushNamed(context, "/change-password");
                                    },
                                  ),
                                ),
                                const Icon(Icons.arrow_right_sharp)
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    textColor: const Color(0xFFF44336),
                                    title: const Text("Logout",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    leading: const Icon(Icons.logout,
                                        color: Color(0xFFF44336)),
                                    onTap: () {
                                      print("Language");
                                      // Navigator.pushNamed(context, "/change-password");
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ))),
              ),
            )
          ],
        )
      ],
    ));
  }
}
