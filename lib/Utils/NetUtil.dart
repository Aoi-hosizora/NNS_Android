import 'package:http/http.dart' as http;
import 'package:nihongo_no_sensei/Utils/CommonUtil.dart';

class NetUtils {
    NetUtils._();

    /// NNS URL: `https://nihongonosensei.net/`
    static const String NNS_URL = "https://nihongonosensei.net/";

    /// Get Url Resp
    static Future<String> _getResponse(String url) async {
        String ret = "";
        try {
            var httpClient = new http.Client();
            await httpClient.get(url).then((resp) {
                if (resp.statusCode == 200)
                    ret = resp.body;
            }, onError: (err) {
                print(err.toString());
            }).whenComplete( () => httpClient.close() );
        }   
        catch (ex) {
            print(ex.toString());
        }
        return ret;
    }

    static Future<String> getNNSData() async {
        String resp = await _getResponse(NNS_URL);
        CommonUtil.v("getNNSData", resp);
        return resp;
    }
}

