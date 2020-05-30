import 'package:servers/model/server_model.dart';
import 'package:ssh/ssh.dart';

class ResourceRepository {
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

  Future<Map<String, String>> getResources(ServerModel server) async {
    final connection = await _conectWithServer(server);

    /* final responses =
        await Future.wait([_getCpuUsage(connection), _getRamUsage(connection), _getDiskUsage(connection)]); */

    final Map<String,String> responses = {};

    responses['CPU'] = await _getCpuUsage(connection);
    responses['RAM'] = await _getRamUsage(connection);
    responses['DISK'] = await _getDiskUsage(connection);

    return responses;
  }

  Future<String> _getCpuUsage(SSHClient connection) async {
    final response = await connection.execute("top -b -n 10 -d.2 | grep 'Cpu' |  awk 'NR==3{ print(\$2)}'");

    return response;
  }

  Future<String> _getRamUsage(SSHClient connection) async {
    final response = await connection.execute("free -m | awk \'NR==2{printf \"%.2f%%\t\t\", \$3*100/\$2 }\'");

    return response;
  }

  Future<String> _getDiskUsage(SSHClient connection) async {
    final response = await connection.execute("df -h | awk \'\$NF==\"/\"{printf \"%s\t\t\", \$5}\'");

    return response;
  }
}
