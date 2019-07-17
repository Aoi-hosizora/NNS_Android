package com.aoihosizora.nihongonosensei.ui.main;

import android.content.Context;
import android.support.annotation.Nullable;
import android.support.annotation.StringRes;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;

import com.aoihosizora.nihongonosensei.R;
import com.aoihosizora.nihongonosensei.ui.frag.CategoryFragment;
import com.aoihosizora.nihongonosensei.ui.frag.ColoumFragment;
import com.aoihosizora.nihongonosensei.ui.frag.GrammarFragment;
import com.aoihosizora.nihongonosensei.ui.frag.HomeFragment;

public class SectionsPagerAdapter extends FragmentPagerAdapter {

    @StringRes
    private static final int[] TAB_TITLES = new int[]{R.string.str_HomeFragment_TabTitle,
            R.string.str_GrammarFragment_TabTitle,
            R.string.str_ColumnFragment_TabTitle,
            R.string.str_CategoryFragment_TabTitle};

    private final Context mContext;

    public SectionsPagerAdapter(Context context, FragmentManager fm) {
        super(fm);
        mContext = context;
    }

    @Override
    public Fragment getItem(int position) {
        switch (position) {
            case 0:
                return new HomeFragment();
            case 1:
                return new GrammarFragment();
            case 2:
                return new ColoumFragment();
            case 3:
                return new CategoryFragment();
        }
        return new Fragment();
    }

    @Nullable
    @Override
    public CharSequence getPageTitle(int position) {
        return mContext.getResources().getString(TAB_TITLES[position]);
    }

    @Override
    public int getCount() {
        // Show 2 total pages.
        return 4;
    }
}