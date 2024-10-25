// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dartz/dartz.dart';
part 'email_address.freezed.dart';

class EmailAddress {
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }

  const EmailAddress._(this.value);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
    };
  }

  factory EmailAddress.fromMap(Map<String, dynamic> map) {
    return EmailAddress(
      map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmailAddress.fromJson(String source) =>
      EmailAddress.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'EmailAddress(value: $value)';

  @override
  bool operator ==(covariant EmailAddress other) {
    if (identical(this, other)) return true;

    return other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}

@freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.invalidEmail({required String failedValue}) =
      InvalidEmail<T>;
  const factory ValueFailure.shortPassword({required String failedValue}) =
      ShortPassword<T>;
}

void showingTheEmailAddressOrFailure() {
  final emailAddress = EmailAddress('dfsf');
  String emailText = emailAddress.value.fold(
      (left) => 'Failure happened, more precisely: $left', (right) => right);

  String emailText2 =
      emailAddress.value.getOrElse(() => 'Some failure happened');
}
