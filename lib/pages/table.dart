import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:management/constant/colors.dart';
import 'package:management/constant/number_ext.dart';
import 'package:management/entities/user.dart';
import 'package:management/widgets/input_field.dart';

class DataTableDemo extends StatefulWidget {
  const DataTableDemo({
    super.key,
    required this.users,
    required this.onHandleSearch,
    required this.handleDelete,
  });

  final List<User> users;
  final Function(String searchText) onHandleSearch;
  final Function(String id) handleDelete;

  @override
  State<DataTableDemo> createState() => _DataTableDemoState();
}

class _DataTableDemoState extends State<DataTableDemo> {
  final headers = [
    "First Name",
    "Last Name",
    "Phone Number",
    "Computer Name",
    "Computer Serial Number",
    "UUID",
    "Actions",
  ];

  var searchText = "";

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      header: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Client List'),
            Row(
              children: [
                SizedBox(
                  width: 320,
                  child: NInputField(
                    hintText: "Enter Search details",
                    onChange: (str) {
                      searchText = str;
                    },
                  ),
                ),
                12.width,
                GestureDetector(
                  onTap: () {
                    widget.onHandleSearch(searchText);
                  },
                  child: const CircleAvatar(
                    backgroundColor: AppColors.kPrimary,
                    radius: 20,
                    child: Icon(
                      Ionicons.search_outline,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      rowsPerPage: 4,
      columns: List.generate(
        headers.length,
        (index) => DataColumn(
          label: Text(headers[index]),
        ),
      ),
      source: _DataSource(
        context: context,
        users: widget.users,
        handleDelete: widget.handleDelete,
      ),
    );
  }
}

class _Row {
  _Row(this.user);

  bool selected = false;
  final User user;
}

class _DataSource extends DataTableSource {
  final List<User> users;
  final Function(String id) handleDelete;

  _DataSource({
    required this.context,
    required this.users,
    required this.handleDelete,
  }) {
    _rows = users.map((e) => _Row(e)).toList();
  }

  final BuildContext context;
  List<_Row> _rows = [];

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        if (value == null) return;

        if (row.selected != value) {
          _selectedCount += value ? 1 : -1;
          assert(_selectedCount >= 0);
          row.selected = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(Text(row.user.fname)),
        DataCell(Text(row.user.lname)),
        DataCell(Text(row.user.phoneNumber)),
        DataCell(Text(row.user.pcName)),
        DataCell(Text(row.user.pcSN)),
        DataCell(Text(row.user.uuid)),
        DataCell(
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  handleDelete(row.user.uuid);
                },
                child: const Icon(
                  Icons.delete,
                  size: 20,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
