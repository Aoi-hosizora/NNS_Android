import 'package:http/http.dart' as http;
import "package:html/parser.dart";
import "package:html/dom.dart";
import 'package:sprintf/sprintf.dart';

import './CommonUtil.dart';
import '../Models/Lists/KiziListItem.dart';
import '../Models/Lists/GrammarListItem.dart';

class NetUtils {
    NetUtils._();

    /// NNS HP URL: `https://nihongonosensei.net/`
    static const String NNS_URL = "https://nihongonosensei.net/";
    /// NNS 日本語教師のお仕事 URL: `?cat=7`
    static const String NNS_SHIGOTO_URL = "$NNS_URL?cat=7";
    /// NNS 中国での生活 URL: `?cat=3`
    static const String NNS_SEIKATU_URL = "$NNS_URL?cat=3";
    /// NNS 日本語の文法 URL: `?page_id=10246`
    static const String NNS_BUNPOU_URL = "$NNS_URL?page_id=10246";

    /// NNS PAGE URL: `&paged=%d`
    static const String _NNS_PAGE_URL = "&paged=%d";

    /// User-Agent
    static const _UA = "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36";

    /// Img Absolute Url: `http://nihongonosensei.net/pic/`
    static const _Img_A_URL = "${NNS_URL}pic/";
    /// Img Relative Url: `./pic/`
    static const _Img_R_URL = "./pic/";
    /// Moto Img Html Block: `<img src="`
    static const _Img_Block = "<img src=\"";

    //////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////// Private: ////////////////////////////////////////

    /// Get Url Resp
    static Future<String> _getResponse(String url) async {
        String ret = "";
        try {
            var httpClient = new http.Client();
            await httpClient.get(url, headers: {'User-Agent': _UA}).then((resp) {
                if (resp.statusCode == 200)
                    ret = resp.body;
            }, onError: (err) {
                CommonUtil.loge("_getResponse", err.toString());
            }).whenComplete( () => httpClient.close() );
        }   
        catch (ex) {
            CommonUtil.loge("_getResponse", ex.toString());
        }
        return ret;
    }

    /// Get One Page Items List
    static Future<List<KiziListItem>> _getOnePageList(String url, {int page: 1}) async {
        String htmlDoc = await _getResponse(sprintf("$url$_NNS_PAGE_URL", [page]));
        Document doc = parse(htmlDoc);
        Element section = doc.querySelector("#list");

        List<KiziListItem> listitems = new List<KiziListItem>();

        List<String> titles = section.querySelectorAll("section h2 a").map((a) => a.text).toList();
        List<String> urls = section.querySelectorAll("section h2 a").map((a) => a.attributes['href']).toList();
        List<String> arasuzi = section.querySelectorAll("section .exsp p").map((p) => p.text).toList();
        List<String> dates = section.querySelectorAll("section time").map((time) => time.text).toList();

        for (var idx = 0; idx < titles.length; idx++) 
            listitems.add(KiziListItem(title: titles[idx], url: urls[idx], arasuzi: arasuzi[idx], date: dates[idx]));

        return listitems;
    }

    /// Get All Grammar List
    static Future<List<GrammarListItem>> _getOneGrammarClassList(String grammarClass) async {
        String htmlDoc = await _getResponse(NNS_BUNPOU_URL);
        Document document = parse(htmlDoc);
        Element clearfix = document.querySelector(".clearfix");
        List<Element> lias = new List<Element>();
        switch (grammarClass) {
            case GrammarListItem.N1:
                lias = clearfix.querySelector("p#linkn1").nextElementSibling.querySelectorAll("a");
            break;
            case GrammarListItem.N1W:
                lias = clearfix.querySelector("p#linkn1").nextElementSibling.nextElementSibling.nextElementSibling.querySelectorAll("a");
            break;
            case GrammarListItem.N2:
                lias = clearfix.querySelector("p#linkn2").nextElementSibling.querySelectorAll("a");
            break;
            case GrammarListItem.N3:
                lias = clearfix.querySelector("p#linkn3").nextElementSibling.querySelectorAll("a");
            break;
            case GrammarListItem.N45:
                lias = clearfix.querySelector("p#linkn4n5").nextElementSibling.querySelectorAll("a");
            break;
            case GrammarListItem.N0:
                lias = clearfix.querySelector("p#linkn0").nextElementSibling.nextElementSibling.querySelectorAll("a");
            break;
        }
        return lias.map((a) => GrammarListItem(title: a.text, url: a.attributes["href"])).toList();
    }

    /// Parse Relative Url To Absolute Url
    static String _parseImgHtml(String htmlDoc) {
        return htmlDoc.replaceAll("$_Img_Block$_Img_R_URL", "$_Img_Block$_Img_A_URL");
    }

    /////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////// Public: ////////////////////////////////////////

    /// get 日本語教師のお仕事 Page Data
    /// 
    /// @param `page` 1..n
    static Future<List<KiziListItem>> getSHIGOTOPageData({int page: 1}) async {
        List<KiziListItem> shigotos = await _getOnePageList(NNS_SHIGOTO_URL, page: page);
        CommonUtil.loge("getSHIGOTOData", shigotos.length.toString() + shigotos.toString());
        return shigotos;
    }

    /// get 中国での生活 Page Data
    /// 
    /// @param `page` 1..n
    static Future<List<KiziListItem>> getSEIKATUPageData({int page: 1}) async {
        List<KiziListItem> setkatus = await _getOnePageList(NNS_SEIKATU_URL, page: page);
        CommonUtil.loge("getSHIGOTOData", setkatus.length.toString() + setkatus.toString());
        return setkatus;
    }

    /// get 日本語の文法 Page Data
    /// 
    /// @param `grammarClass` GrammarListItem.N1
    static Future<List<GrammarListItem>> getGrammarPageData(String grammarClass) async {
        List<GrammarListItem> grammars = await _getOneGrammarClassList(grammarClass);
        CommonUtil.loge("getGrammarPageData", grammars.length.toString() + grammars.toString());
        return grammars;
    }

    /// get 日本語教師のお仕事 中国での生活 記事 htmlDoc
    static Future<String> getKiziContent(String url) async {
        String httpDoc = await _getResponse(url);
        Document document = parse(httpDoc);
        return _parseImgHtml(document.querySelector("#mainEntity .clearfix").text);
    }
}