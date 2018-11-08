package com.haisheng.testjenkinsdemo.utils;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;
import android.webkit.JavascriptInterface;


import com.blankj.utilcode.util.LogUtils;
import com.tencent.smtt.sdk.WebView;

import java.lang.ref.WeakReference;


public class AndroidToJs extends  Object{
    private final static String TAG = AndroidToJs.class.getSimpleName();
    private WeakReference<WebView> mWeakReference;

    public AndroidToJs(WebView webView) {
        mWeakReference = new WeakReference<>(webView);
    }

    // 定义JS需要调用的方法
    // 被JS调用的方法必须加入@JavascriptInterface注解
    @JavascriptInterface
    public void goBack() {
        LogUtils.i(TAG,"goBack");
        WebView webView = mWeakReference.get();
        ((Activity)webView.getContext()).onBackPressed();
    }

    @JavascriptInterface
    public void clearCache() {
        LogUtils.i(TAG,"clearCache");
        WebView webView = mWeakReference.get();
        webView.clearCache(true);
    }
}