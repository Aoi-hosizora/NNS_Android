import 'package:http/http.dart' as http;
import "package:html/parser.dart";
import "package:html/dom.dart";
import './CommonUtil.dart';

class NetUtils {
    NetUtils._();

    /// NNS URL: `https://nihongonosensei.net/`
    static const String NNS_URL = "https://nihongonosensei.net/";

    /// User-Agent
    static const _UA = "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36";

    /// Get Url Resp
    static Future<String> _getResponse(String url) async {
        String ret = "";
        try {
            var httpClient = new http.Client();
            await httpClient.get(url, headers: {'User-Agent': _UA}).then((resp) {
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

    static List<String> _parseBili(String htmlDoc) {
        Document document = parse(htmlDoc);
        List<Element> elements = document.body.querySelectorAll("div.panel ul.title").first.querySelectorAll('a');
        CommonUtil.loge("_parseBili", elements.length);
        
        List<String> ret = new List<String>();
        elements.forEach((elem) => ret.add(elem.text.trim()) );
        return ret;
    }

    static Future<String> getTmpData() async {
        String httpDoc = await _getResponse("https://www.bilibili.com");
        List<String> ret = _parseBili(httpDoc);
        CommonUtil.loge("getNNSData", ret.toString());
        return ret.toString();
    }
}