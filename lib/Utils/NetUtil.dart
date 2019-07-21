import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import "package:html/parser.dart";
import "package:html/dom.dart";
import 'package:sprintf/sprintf.dart';

import '../Constants/Consts.dart';
import './CommonUtil.dart';
import '../Models/Lists/KiziListItem.dart';
import '../Models/Lists/GrammarListItem.dart';
import '../Models/Entities/KiziItem.dart';
import '../Models/Entities/GrammarItem.dart';

class NetUtil {
    NetUtil._();

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
            }).whenComplete( () => httpClient.close() );
        }   
        on SocketException catch (ex) {
            // SocketException: OS Error: No route to host, errno = 113, address = nihongonosensei.net, port = 40593
            // http://www.cndartlang.com/708.html ??
            CommonUtil.loge("_getResponse", ex);
            throw HttpException(ex.message);
        }
        on TimeoutException catch (ex) {
            CommonUtil.loge("_getResponse", ex);
            throw HttpException(ex.message);
        }
        catch (ex) {
            CommonUtil.loge("_getResponse", ex);
            throw ex;
        }
        return ret;
    }

    /// Get One Page Items List
    static Future<List<KiziListItem>> _getOnePageList(String url, String type, {int page: 1}) async {
        String htmlDoc = await _getResponse(sprintf("$url$_NNS_PAGE_URL", [page]));
        Document doc = parse(htmlDoc);
        Element section = doc.querySelector("#list");

        List<KiziListItem> listitems = new List<KiziListItem>();

        List<String> titles = section.querySelectorAll("section h2 a").map((a) => a.text).toList();
        List<String> urls = section.querySelectorAll("section h2 a").map((a) => a.attributes['href']).toList();
        List<String> arasuzi = section.querySelectorAll("section .exsp p").map((p) => p.text).toList();
        List<String> dates = section.querySelectorAll("section time").map((time) => time.text).toList();

        for (var idx = 0; idx < titles.length; idx++) 
            listitems.add(KiziListItem(title: titles[idx], url: urls[idx], arasuzi: arasuzi[idx], date: dates[idx], type: type));

        return listitems;
    }

    /// Get All Grammar List
    static Future<List<GrammarListItem>> _getOneGrammarClassList(String grammarClass) async {
        String htmlDoc = await _getResponse(NNS_BUNPOU_URL);
        Document document = parse(htmlDoc);
        Element clearfix = document.querySelector(".clearfix");
        List<Element> lias = new List<Element>();
        switch (grammarClass) {
            case Consts.N1:
                lias = clearfix.querySelector("p#linkn1").nextElementSibling.querySelectorAll("a");
            break;
            case Consts.N1W:
                lias = clearfix.querySelector("p#linkn1").nextElementSibling.nextElementSibling.nextElementSibling.querySelectorAll("a");
            break;
            case Consts.N2:
                lias = clearfix.querySelector("p#linkn2").nextElementSibling.querySelectorAll("a");
            break;
            case Consts.N3:
                lias = clearfix.querySelector("p#linkn3").nextElementSibling.querySelectorAll("a");
            break;
            case Consts.N45:
                lias = clearfix.querySelector("p#linkn4n5").nextElementSibling.querySelectorAll("a");
            break;
            case Consts.N0:
                lias = clearfix.querySelector("p#linkn0").nextElementSibling.nextElementSibling.querySelectorAll("a");
            break;
        }
        return lias.map((a) => GrammarListItem(title: a.text, url: a.attributes["href"], grammarClass: grammarClass)).toList();
    }

    /// Parse Relative Url To Absolute Url
    static String _parseImgHtml(String htmlDoc) {
        return htmlDoc
            .replaceAll("<img src=\"./pic/", "<img src=\"${NNS_URL}pic/") // <img src="./pic/ -> <img src="https://nihongonosensei.net/pic/
            .replaceAll("<noscript>", "")
            .replaceAll("</noscript>", "");
    }

    /////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////// Public: ////////////////////////////////////////

    /// get 日本語教師のお仕事 Page Data
    /// 
    /// @param `page` 1..n
    static Future<List<KiziListItem>> getSHIGOTOPageData({int page: 1}) async {
        List<KiziListItem> shigotos = await _getOnePageList(NNS_SHIGOTO_URL, Consts.TShitoko, page: page);
        // CommonUtil.loge("getSHIGOTOData", shigotos.length.toString() + shigotos.toString());
        return shigotos;
    }

    /// get 中国での生活 Page Data
    /// 
    /// @param `page` 1..n
    static Future<List<KiziListItem>> getSEIKATUPageData({int page: 1}) async {
        List<KiziListItem> setkatus = await _getOnePageList(NNS_SEIKATU_URL, Consts.TSeikatu, page: page);
        // CommonUtil.loge("getSHIGOTOData", setkatus.length.toString() + setkatus.toString());
        return setkatus;
    }

    /// get 日本語の文法 Page Data
    /// 
    /// @param `grammarClass` GrammarListItem.N1
    static Future<List<GrammarListItem>> getGrammarPageData(String grammarClass) async {
        List<GrammarListItem> grammars = await _getOneGrammarClassList(grammarClass);
        // CommonUtil.loge("getGrammarPageData", grammars.length.toString() + grammars.toString());
        return grammars;
    }

    /// get 日本語教師のお仕事 中国での生活 記事 htmlDoc
    /// 
    /// @param `type` KiziType
    /// @param `item` KiziListItem
    static Future<KiziItem> getKiziContent(KiziListItem item) async {
        String httpDoc = await _getResponse(item.url); // new
        Document document = parse(httpDoc);

        String title = document.querySelector("#mainEntity .entry-title").text;
        String date = document.querySelector("#mainEntity time").text;

        // String content = _parseImgHtml(document.querySelector("#mainEntity .clearfix").text).replaceFirst(item.type, "");
        document.querySelector("#mainEntity .clearfix .meta").remove();
        String content = _parseImgHtml(document.querySelector("#mainEntity .clearfix").innerHtml);

        /*
        <p class="meta">
            <i class="fa fas fa-folder"></i>
            <span class="category" itemprop="keywords">
                <a href="https://nihongonosensei.net/?cat=3">中国での生活</a>
            </span>
        </p>
        */

        /* inner: 
        <p>
            <img 
                src="data:image/gif;base64,R0lGODlhAQABAPAAAAAAAP///yH5BAEAAAEALAAAAAABAAEAAAICTAEAOw=="
                class="lazy" 
                data-src="./pic/19061607.jpg" 
                alt=""
            >
            <noscript>
                <img 
                    src="https://nihongonosensei.net/pic/19061607.jpg" 
                    alt="" 
                />
            </noscript>
        </p> 
        */

        /* text: 
        <img 
            src="https://nihongonosensei.net/pic/19061607.jpg" 
            alt="" 
        />
        */

        return KiziItem(type: item.type, title: title, content: content, url: item.url, date: date);
    }

    static Future<GrammarItem> getGmrContent(GrammarListItem item) async {
        String httpDoc = await _getResponse(item.url);
        Document document = parse(httpDoc);
        
        String title = document.querySelector(".entry-title").text;
        document.querySelector("#mainEntity .clearfix .meta").remove();
        String content = _parseImgHtml(document.querySelector("#mainEntity .clearfix").innerHtml);

        return GrammarItem(title: title, url: item.url, content: content, grammarClass: item.grammarClass);
    }
}