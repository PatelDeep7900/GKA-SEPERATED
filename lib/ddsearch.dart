import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gka/models/csc/CountryModel.dart';

import 'user_model.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dropdownSearch Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _formKey = GlobalKey<FormState>();
  final _popupBuilderKey = GlobalKey<DropdownSearchState<String>>();
  final myKey = GlobalKey<DropdownSearchState<MultiLevelString>>();


  @override
  Widget build(BuildContext context) {
    void _handleCheckBoxState({bool updateState = true}) {
      var selectedItem = _popupBuilderKey.currentState?.popupGetSelectedItems ?? [];
      var isAllSelected = _popupBuilderKey.currentState?.popupIsAllItemSelected ?? false;

      if (updateState) setState(() {});
    }

    _handleCheckBoxState(updateState: false);

    return Scaffold(
      appBar: AppBar(title: Text("DropdownSearch Demo")),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: EdgeInsets.all(4),
            children: <Widget>[


              Padding(padding: EdgeInsets.all(8)),
              Text("[Favorites examples]"),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: DropdownSearch<CountryModel>(
                      asyncItems: (filter) => getData(filter),
                      compareFn: (i, s) => i.isEqual(s),
                      popupProps: PopupPropsMultiSelection.modalBottomSheet(
                        isFilterOnline: true,
                        showSelectedItems: true,
                        showSearchBox: true,
                        itemBuilder: _customPopupItemBuilderExample2,
                        favoriteItemProps: FavoriteItemProps(
                          showFavoriteItems: true,
                          favoriteItems: (us) {
                            return us.where((e) => e.name.contains("Mrs")).toList();
                          },
                        ),
                      ),
                    ),
                  ),

                ],
              ),],
          ),
        ),
      ),
    );
  }

  Widget _customDropDownExampleMultiSelection(BuildContext context, List<UserModel> selectedItems) {
    if (selectedItems.isEmpty) {
      return ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: CircleAvatar(),
        title: Text("No item selected"),
      );
    }

    return Wrap(
      children: selectedItems.map((e) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(e.avatar),
              ),
              title: Text(e.name),
              subtitle: Text(
                e.createdAt.toString(),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _customPopupItemBuilderExample2(BuildContext context, CountryModel item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.name.toString()),
        subtitle: Text(item.id.toString()),

      ),
    );
  }

  Future<List<CountryModel>> getData(String filter) async {
    var response = await Dio().get(
      "http://192.168.10.141:8084/GKARESTAPI/c_cscpicker",
      queryParameters: {"filter": filter},
    );

    final data = response.data;
    if (data != null) {
      return CountryModel.fromJsonList(data);

    }

    return [];
  }
}

class _CheckBoxWidget extends StatefulWidget {
  final Widget child;
  final bool? isSelected;
  final ValueChanged<bool?>? onChanged;

  _CheckBoxWidget({required this.child, this.isSelected, this.onChanged});

  @override
  CheckBoxState createState() => CheckBoxState();
}

class CheckBoxState extends State<_CheckBoxWidget> {
  bool? isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  void didUpdateWidget(covariant _CheckBoxWidget oldWidget) {
    if (widget.isSelected != isSelected) isSelected = widget.isSelected;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0x88F44336),
            Colors.blue,
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Select: '),
              Checkbox(
                  value: isSelected,
                  tristate: true,
                  onChanged: (bool? v) {
                    if (v == null) v = false;
                    setState(() {
                      isSelected = v;
                      if (widget.onChanged != null) widget.onChanged!(v);
                    });
                  }),
            ],
          ),
          Expanded(child: widget.child),
        ],
      ),
    );
  }
}

class MultiLevelString {
  final String level1;
  final List<MultiLevelString> subLevel;
  bool isExpanded;

  MultiLevelString({
    this.level1 = "",
    this.subLevel = const [],
    this.isExpanded = false,
  });

  MultiLevelString copy({
    String? level1,
    List<MultiLevelString>? subLevel,
    bool? isExpanded,
  }) =>
      MultiLevelString(
        level1: level1 ?? this.level1,
        subLevel: subLevel ?? this.subLevel,
        isExpanded: isExpanded ?? this.isExpanded,
      );

  @override
  String toString() => level1;
}