class MoodData {
  String label;
  int value;
  MoodData({required this.label, required this.value});

  String getDisplayValue() {
    return isValid() ? value.toString() : '';
  }

  bool isValid() {
    return value >= 0;
  }
}

final moodDataList = [
  MoodData(value: 86, label: '六'),
  MoodData(value: 80, label: '日'),
  MoodData(value: -1, label: '一'),
  MoodData(value: 90, label: '二'),
  MoodData(value: 92, label: '三'),
  MoodData(value: 97, label: '四'),
  MoodData(value: 81, label: '五'),
];
