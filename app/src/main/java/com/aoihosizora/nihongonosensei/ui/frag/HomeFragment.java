package com.aoihosizora.nihongonosensei.ui.frag;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.aoihosizora.nihongonosensei.R;
import com.aoihosizora.nihongonosensei.util.SpiderUtil;

public class HomeFragment extends Fragment {

    private View view;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        if (null != view) {
            ViewGroup parent = (ViewGroup) view.getParent();
            if (null != parent)
                parent.removeView(view);
        }
        else {
            view = inflater.inflate(R.layout.fragment_home, container, false);

            setupView();
        }
        return view;
    }

    private TextView m_TestTextView;

    private void setupView() {
        m_TestTextView = view.findViewById(R.id.id_HomeFragment_TestTextView);

        new Thread() {
            public void run() {
                String HtmlData = SpiderUtil.getRequestHTML("https://www.bilibili.com");
                SpiderUtil.ResolveTag(HtmlData);
            }
        }.start();
    }
}
