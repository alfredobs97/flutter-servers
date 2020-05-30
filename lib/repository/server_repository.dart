import 'package:servers/model/server_model.dart';
import 'package:ssh/ssh.dart';

class ServerRepository {
  List<ServerModel> _servers = [];

  addServer(ServerModel server) {
    _servers.add(server);
  }

  List<ServerModel> getServers() {
    print(this._servers.length);
    return this._servers;
  }

  Future<SSHClient> _conectWithServer(ServerModel server) async {
    var client = new SSHClient(
      host: server.host,
      port: server.port,
      username: server.username,
      passwordOrKey: server.password,
    );

    await client.connect();

    return client;
  }

  Future<bool> tryConectWithServer(ServerModel server) async {
    var client = new SSHClient(
      host: server.host,
      port: server.port,
      username: server.username,
      passwordOrKey: server.password,
    );

    try {
      await client.connect();
      return true;
    } catch (e) {
      return false;
    }
  }

  getOS(ServerModel server) async {
    final connection = await _conectWithServer(server);
    final response = await connection.execute('cat /etc/os-release');

    _getOsFromString(response);
    print(response);
  }

  _getOsFromString(String response) {
  }
}
