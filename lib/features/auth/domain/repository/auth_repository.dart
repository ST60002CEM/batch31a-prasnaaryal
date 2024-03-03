import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hamropasalmobile/core/failure/failure.dart';
import 'package:hamropasalmobile/features/auth/data/model/user_profile_model.dart';
import 'package:hamropasalmobile/features/auth/domain/entity/auth_entity.dart';


enum Status { 
   authenticated, 
   unAuthenticated, 
  
}  

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerUser(AuthEntity user);
  Future<Either<Failure, String>> loginUser(String email, String password);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
  Future<Status> userStatus();
  Future<Either<Failure, UserWrapper>> getProfile();
  Future<Either<Failure, void>> logout();

  
}
