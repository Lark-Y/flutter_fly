
import 'package:flutter_fly/entry/widget_info.dart';
import 'package:flutter_fly/widgets/az_list/az_common.dart';

class WidgetInfoSuspension extends ISuspensionBean {
  WidgetInfoSuspension({required this.widgetInfo, this.tagIndex});

  final WidgetInfo widgetInfo;
  String? tagIndex;

  @override
  String getSuspensionTag() => tagIndex!;

}