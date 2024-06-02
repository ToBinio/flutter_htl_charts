import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_htl_charts/domain/branch.dart';
import 'package:flutter_htl_charts/domain/room.dart';
import 'package:flutter_htl_charts/domain/school.dart';
import 'package:flutter_htl_charts/provider/schoolsProvider.dart';
import 'package:provider/provider.dart';

class RoomSelector extends StatefulWidget {
  final Function callback;

  const RoomSelector({super.key, required this.callback});

  @override
  State<RoomSelector> createState() => _RoomSelectorState();
}

class _RoomSelectorState extends State<RoomSelector> {
  School? selectedSchool;
  final TextEditingController schoolController = TextEditingController();

  Branch? selectedBranch;
  final TextEditingController branchController = TextEditingController();

  Room? selectedRoom;
  final TextEditingController roomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var schoolsProvider = Provider.of<SchoolsProvider>(context);

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownMenu<School>(
            initialSelection: selectedSchool,
            controller: schoolController,
            requestFocusOnTap: true,
            label: const Text("Schule"),
            width: 150,
            onSelected: (School? school) async {
              if (selectedSchool == school) {
                return;
              }

              selectedBranch = null;
              branchController.text = "";
              selectedRoom = null;
              roomController.text = "";
              widget.callback(null);

              selectedSchool = school;

              await school!.fetchBranches(context);
              setState(() {});
            },
            dropdownMenuEntries: schoolsProvider.schools
                .map<DropdownMenuEntry<School>>((School school) {
              return DropdownMenuEntry<School>(
                value: school,
                label: school.name,
              );
            }).toList(),
          ),
        ),
        if (selectedSchool != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownMenu<Branch>(
              initialSelection: selectedBranch,
              controller: branchController,
              requestFocusOnTap: true,
              label: const Text("Abteilung"),
              width: 150,
              onSelected: (Branch? branch) async {
                if (selectedBranch == branch) {
                  return;
                }

                selectedRoom = null;
                roomController.text = "";
                widget.callback(null);

                selectedBranch = branch;
                await branch!.fetchRooms(context);
                setState(() {});
              },
              dropdownMenuEntries: (selectedSchool!.branches ?? [])
                  .map<DropdownMenuEntry<Branch>>((Branch branch) {
                return DropdownMenuEntry<Branch>(
                  value: branch,
                  label: branch.name,
                );
              }).toList(),
            ),
          ),
        if (selectedBranch != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownMenu<Room>(
              initialSelection: selectedRoom,
              controller: roomController,
              requestFocusOnTap: true,
              label: const Text("Raum"),
              width: 150,
              onSelected: (Room? room) async {
                selectedRoom = room;
                widget.callback(room);

                setState(() {});
              },
              dropdownMenuEntries: (selectedBranch!.rooms ?? [])
                  .map<DropdownMenuEntry<Room>>((Room room) {
                return DropdownMenuEntry<Room>(
                  value: room,
                  label: room.name,
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
