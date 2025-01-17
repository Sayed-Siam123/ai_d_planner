import 'package:equatable/equatable.dart';

class PasswordObscureState extends Equatable{

  final bool? isShow;

  const PasswordObscureState({
    this.isShow
  });

  @override
  // TODO: implement props
  List<Object?> get props => [isShow];

}
