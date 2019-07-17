package com.aoihosizora.nihongonosensei.ui.frag;

import android.view.LayoutInflater;
import android.view.ViewGroup;
import android.widget.TextView;

import com.aoihosizora.nihongonosensei.R;
import com.aoihosizora.nihongonosensei.util.SpiderUtil;

public class HomeFragment extends BaseFragment {

    private TextView m_TestTextView;

    @Override
    protected void setupView(LayoutInflater inflater, ViewGroup container) {
        view = inflater.inflate(R.layout.fragment_home, container, false);
        m_TestTextView = view.findViewById(R.id.id_HomeFragment_DynamicTextView);

        new Thread() {
            public void run() {
                String HtmlData = SpiderUtil.getRequestHTML("https://www.bilibili.com");
                SpiderUtil.ResolveTag(HtmlData);
            }
        }.start();
    }
}
