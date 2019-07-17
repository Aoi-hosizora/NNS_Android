package com.aoihosizora.nihongonosensei.ui.frag;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

public abstract class BaseFragment extends Fragment {

    public View view;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        if (null != view) {
            ViewGroup parent = (ViewGroup) view.getParent();
            if (null != parent)
                parent.removeView(view);
        }
        else
            setupView(inflater, container);

        return view;
    }

    protected abstract void setupView(LayoutInflater inflater, ViewGroup container);

    protected void ShowLogE(String FunctionName, String Msg) {
        String TAG = "NNS";
        String ClassName = this.getClass().getSimpleName();
        String log = ClassName + ": " + FunctionName + "()###" + Msg;
        Log.e(TAG, log);
    }
}
