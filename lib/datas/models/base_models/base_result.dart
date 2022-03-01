import 'package:eng_questions/enums/result_status.dart';

class BaseResult<I> {
  int pageSize = 0;
  int pageCount = 0;
  ResultStatus type = ResultStatus.danger; //
  String? message;
  I? data;

  BaseResult({
    this.pageSize = 0,
    this.pageCount = 0,
    this.type = ResultStatus.danger,
    this.message,
    this.data,
  });
}
