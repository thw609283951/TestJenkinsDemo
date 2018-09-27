package com.haisheng.testjenkinsdemo;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

public class MainActivity extends AppCompatActivity {

    private ProgressWebView webView;

    private String mUrl = BuildConfig.APP_HOST_ADDRESS;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        webView = findViewById(R.id.webView);
        webView.setLoadListener(new ProgressWebView.OnLoadListener() {
            @Override
            public void loadSuccess() {

            }

            @Override
            public void loadError() {

            }
        });

        webView.loadUrl(mUrl);
    }
}
