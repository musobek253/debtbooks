const String historyUser = 'history_user';

class DebtorHistoryUserFildes {
  static const String columnid = 'id';
  static const String columnname = 'name';
  static const String columnkoment = 'koment';
  static const String columnsumm = 'summ';
  static const String columndebtorUserId = 'userId';
  static const String columnDatetime = "datetime";
}

class DebtorUserHistory {
  final String? id;
  final String? name;
  final String? koment;
  final int? summ;
  final DateTime? dateTime;
  final String? debtorUserId;
  DebtorUserHistory({
    required this.id,
    required this.koment,
    required this.dateTime,
    required this.name,
    required this.summ,
    required this.debtorUserId,
  });

  Map<String, dynamic> toMap() => {
        DebtorHistoryUserFildes.columnid: id,
        DebtorHistoryUserFildes.columnname: name,
        DebtorHistoryUserFildes.columnkoment: koment,
        DebtorHistoryUserFildes.columndebtorUserId: debtorUserId,
        DebtorHistoryUserFildes.columnsumm: summ,
        DebtorHistoryUserFildes.columnDatetime:
            dateTime!.millisecondsSinceEpoch,
      };

  factory DebtorUserHistory.fromMap(Map<String, dynamic> map) =>
      DebtorUserHistory(
          id: map['id'],
          name: map['name'],
          koment: map['koment'],
          summ: map['summ'],
          dateTime: DateTime.fromMillisecondsSinceEpoch(map['datetime'] as int),
          debtorUserId: map['userId']);
}
