package com.haisheng.testjenkinsdemo;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

public class MainActivity extends AppCompatActivity {

    private ProgressWebView webView;

    private String mUrl = "http://zs1.aada.top/app/index.php?i=6&c=entry&do=shop&m=sz_yi";

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
