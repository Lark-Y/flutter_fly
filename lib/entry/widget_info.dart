
import 'package:json_annotation/json_annotation.dart';

part 'widget_info.g.part';


List<WidgetInfo> getWidgetInfoList(List<dynamic> list) {
  List<WidgetInfo> result = [];
  list.forEach((element) {
    result.add(WidgetInfo.fromJson(element));
  });
  return result;
}

@JsonSerializable()
class WidgetInfo extends Object {
  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'desc')
  String? desc;

  @JsonKey(name: 'url')
  String? url;

  @JsonKey(name: 'tags')
  String? tags;

  WidgetInfo({
    this.title, this.desc, this.url, this.tags
});


  factory WidgetInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$WidgetInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WidgetInfoToJson(this);


}