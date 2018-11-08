package com.haisheng.testjenkinsdemo.ui;

import android.app.Activity;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.Toast;

import com.blankj.utilcode.util.SnackbarUtils;
import com.haisheng.testjenkinsdemo.BuildConfig;
import com.haisheng.testjenkinsdemo.R;
import com.haisheng.testjenkinsdemo.runtimepermissions.PermissionsManager;
import com.haisheng.testjenkinsdemo.runtimepermissions.PermissionsResultAction;
import com.haisheng.testjenkinsdemo.utils.AndroidToJs;
import com.haisheng.testjenkinsdemo.widget.X5ProgressWebView;

import static com.blankj.utilcode.util.SnackbarUtils.LENGTH_LONG;

public class MainActivity extends AppCompatActivity {

    X5ProgressWebView webView;
    LinearLayout errorPage;

    private static final String mUrl = BuildConfig.APP_HOST_ADDRESS;
    private Activity mContext;
    private long firstTime = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        requestPermission();
        initView();
    }

    private void initView(){
        webView = findViewById(R.id.webView);
        errorPage = findViewById(R.id.error_page);

        errorPage.setOnClickListener(v -> {
            webView.loadUrl(webView.getUrl());
            errorPage.setVisibility(View.GONE);
        });

        webView.setLoadListener(new X5ProgressWebView.OnLoadListener() {
            @Override
            public void loadSuccess() {
            }

            @Override
            public void loadError() {
                errorPage.setVisibility(View.VISIBLE);
            }
        });
        webView.addJavascriptInterface(new AndroidToJs(webView),"app");
        webView.loadUrl(mUrl);
    }


    @Override
    protected void onResume() {
        super.onResume();
        webView.onResume();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        webView.destroy();
    }

    @Override
    public void onBackPressed() {
        if(null != webView &&webView.canGoBack()){
            webView.goBack();
            return;
        }
        long secondTime = System.currentTimeMillis();
        if (secondTime - firstTime > 2000) {
            View view = getWindow().getDecorView().findViewById(android.R.id.content);
            SnackbarUtils.with(view).setMessage("再按一次退出程序").setDuration
                    (LENGTH_LONG).show();
            firstTime = secondTime;
        } else {
            super.onBackPressed();
        }
    }

    /**
     * 适配android6.0以上权限
     */
    private void requestPermission() {
        /**
         * 请求所有必要的权限
         */
        PermissionsManager.getInstance().requestAllManifestPermissionsIfNecessary(this, new
                PermissionsResultAction() {
                    @Override
                    public void onGranted() {
//                Toast.makeText(MainActivity.this, "All permissions have been granted",
                    }

                    @Override
                    public void onDenied(String permission) {
                        Toast.makeText(MainActivity.this, "Permission " + permission + " has been denied", Toast.LENGTH_SHORT).show();
                    }
                });
    }
}
