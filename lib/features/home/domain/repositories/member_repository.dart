import 'package:j_donuts/features/home/domain/entities/member.dart';

abstract interface class MemberRepository {
  Stream<Member?> watchMember();
}
