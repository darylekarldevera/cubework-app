import 'package:cubework_app_client/constants/amenities_options.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:cubework_app_client/constants/space_types.dart';

class ExploreScreenFilter extends StatefulWidget {
  const ExploreScreenFilter({super.key});

  @override
  State<ExploreScreenFilter> createState() => _ExploreScreenFilterState();

  static void show(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return const ExploreScreenFilter();
        });
  }
}

class _ExploreScreenFilterState extends State<ExploreScreenFilter> {
  String? selectedSpaceType;
  String? selectedAvailability;
  String? selectedSpaceCategory;

  FocusNode spaceTypeFocusNode = FocusNode();
  IconData spaceTypeDropDownIcon = Icons.arrow_drop_down;

  FocusNode availabilityFocusNode = FocusNode();
  IconData availabilityDropDownIcon = Icons.arrow_drop_down;

  FocusNode spaceCategoryFocusNode = FocusNode();
  IconData spaceCategoryDropDownIcon = Icons.arrow_drop_down;

  @override
  void initState() {
    super.initState();
    spaceTypeFocusNode.addListener(() => setState(() {
          spaceTypeDropDownIcon = spaceTypeFocusNode.hasFocus
              ? Icons.arrow_drop_up
              : Icons.arrow_drop_down;
        }));

    availabilityFocusNode.addListener(() => setState(() {
          availabilityDropDownIcon = availabilityFocusNode.hasFocus
              ? Icons.arrow_drop_up
              : Icons.arrow_drop_down;
        }));

    spaceCategoryFocusNode.addListener(() => setState(() {
          spaceCategoryDropDownIcon = spaceCategoryFocusNode.hasFocus
              ? Icons.arrow_drop_up
              : Icons.arrow_drop_down;
        }));
  }

  @override
  Widget build(BuildContext context) {
    const double fortyPercentWidth = 0.4;
    const double sixPercentHeight = 0.075;

    final mediaQuery = MediaQuery.of(context);
    final mediaQueryWidth = mediaQuery.size.width * fortyPercentWidth;
    final mediaQueryHeight = mediaQuery.size.height * sixPercentHeight;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.80,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          title: Container(
            alignment: Alignment.topLeft,
            child: const Text("Filter"),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        // space type dropdown
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: const Text("Space Type", style: TextStyle(fontSize: 12)),
                subtitle: DropdownButton2<String>(
                  focusNode: spaceTypeFocusNode,
                  hint: const Text("Select"),
                  value: selectedSpaceType,
                  iconStyleData: IconStyleData(
                    icon: Icon(spaceTypeDropDownIcon),
                  ),
                  buttonStyleData: const ButtonStyleData(
                    height: 35,
                    width: double.infinity,
                    padding: EdgeInsets.only(bottom: 5),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: MediaQuery.of(context).size.height * 0.35,
                  ),
                  items: spaceTypes.entries
                      .map((entry) => DropdownMenuItem(
                            value: entry.key,
                            child: Text(entry.value),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedSpaceType = value;
                    });
                  },
                ),
              ),
            ),
            // availability dropdown
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                  title: const Text("Availability",
                      style: TextStyle(fontSize: 12)),
                  subtitle: DropdownButton2(
                    focusNode: availabilityFocusNode,
                    value: selectedAvailability,
                    hint: const Text("Select"),
                    iconStyleData: IconStyleData(
                      icon: Icon(availabilityDropDownIcon),
                    ),
                    buttonStyleData:
                        const ButtonStyleData(width: double.infinity),
                    items: const [
                      DropdownMenuItem(
                        value: "complete",
                        child: Text("Complete"),
                      ),
                      DropdownMenuItem(
                        value: "partial",
                        child: Text("Partial"),
                      ),
                    ],
                    onChanged: (value) => {selectedAvailability = value},
                  )),
            ),
            // space category
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: const Text("Space Category",
                      style: TextStyle(fontSize: 12)),
                  subtitle: DropdownButton2<String>(
                    focusNode: spaceCategoryFocusNode,
                    hint: const Text("Select"),
                    value: selectedSpaceCategory,
                    iconStyleData: IconStyleData(
                      icon: Icon(spaceCategoryDropDownIcon),
                    ),
                    buttonStyleData: const ButtonStyleData(
                      width: double.infinity,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: MediaQuery.of(context).size.height * 0.35,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "dedicatedSpace",
                        child: Text("Dedicated Space"),
                      ),
                      DropdownMenuItem(
                        value: "conferenceRooms",
                        child: Text("Conference Rooms"),
                      )
                    ],
                    onChanged: (value) => {
                      setState(() {
                        selectedSpaceCategory = value;
                      })
                    },
                  ),
                )),
            // Amenities
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Amenities", style: TextStyle(fontSize: 12)),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                    ),
                    itemCount: amenitiesOptions.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        value: false,
                        checkColor: Colors.green,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                            "${amenitiesOptions.values.elementAt(index)}",
                            style: const TextStyle(fontSize: 10)),
                        onChanged: (bool? value) {},
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        persistentFooterButtons: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: mediaQueryWidth,
                height: mediaQueryHeight,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.white),
                    foregroundColor: WidgetStateProperty.all(Colors.green),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.green)),
                    ),
                  ),
                  onPressed: () {
                    print("Filter");
                  },
                  child: const Text("Clear"),
                ),
              ),
              SizedBox(
                width: mediaQueryWidth,
                height: mediaQueryHeight,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.green),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.green)),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Apply"),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
