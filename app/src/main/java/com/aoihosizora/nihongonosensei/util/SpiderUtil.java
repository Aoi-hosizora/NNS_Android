package com.aoihosizora.nihongonosensei.util;

import android.util.Log;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class SpiderUtil {

    private static void ShowLogE(String FunctionName, String Msg) {
        String TAG = "NNS";
        String ClassName = "SpiderUtil";
        String log = ClassName + ": " + FunctionName + "()###" + Msg;
        Log.e(TAG, log);
    }

    /**
     * 通过 OkHttpClient 发出请求获取 HTML 文档，使用新线程访问
     * @param URL
     * @return
     */
    public static String getRequestHTML(String URL) {
        OkHttpClient okHttpClient = new OkHttpClient();
        Request request = new Request.Builder().url(URL).build();
        String htmlData = "";
        try {
            Response response = okHttpClient.newCall(request).execute();
            htmlData = response.body().string();
        }
        catch (IOException ex) {
            ex.printStackTrace();
        }
        catch (NullPointerException ex) {
            ex.printStackTrace();
        }
        return htmlData;
    }

    /**
     * 临时处理文档，筛选信息
     * @param htmlData
     */
    public static void ResolveTag(String htmlData) {
        Document document = Jsoup.parse(htmlData);
        Elements elements = document.select("div.panel").first().select("ul.title a");
        List<String> list = new ArrayList<>();

        for (Element element : elements) {
            list.add(element.text());
        }

        for (String str : list) {
            ShowLogE("ResolveTag", "info: " + str);
        }

    }
}
