  
class AuthenticationException implements Exception{
  final String message;

  AuthenticationException({this.message = 'Ha ocurrido un error desconocido. '});
}