import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf_io.dart' as io;

void main() async {
  final router = Router();

  router.get('/', (Request request) {
    return Response.ok('Hello, World of Dart!');
  });

  router.get('/lifesigns', (Request request) {
    return Response.ok('getAll()');
  });

  router.post('/lifesigns', (Request request) {
    return Response.ok('create()');
  });

  router.get('/lifesigns/<id>', (Request request, String id) {
    return Response.ok('getById()');
  });

  router.put('/lifesigns/<id>', (Request request, String id) {
    return Response.ok('update()');
  });

  router.delete('/lifesigns/<id>', (Request request, String id) {
    return Response.ok('delete()');
  });

  final handler =
      const Pipeline().addMiddleware(logRequests()).addHandler(router);

  final server = await io.serve(handler, InternetAddress.anyIPv4, 8080);
  print('your server is running on localhost:${server.port}');
}

/*
/persons	GET	Hämta alla personer	getAll()
/persons	POST	Skapa ny person	create()
/persons/<id>	GET	Hämta specifik person	getById()
/persons/<id>	PUT	Uppdatera specifik person	update()
/persons/<id>	DELETE	Ta bort specifik person	delete()
*/