package com.haisheng.testjenkinsdemo.ui;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;

import com.haisheng.testjenkinsdemo.R;

public class WelcomeActivity extends AppCompatActivity {
    /**
     * 延迟时间
     */
    private static final int DELAY_TIME = 2_000;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_welcome);
        // 利用消息处理器实现延迟跳转到登录窗口
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                // 启动登录窗口
                startActivity(new Intent(WelcomeActivity.this, MainActivity.class));
                // 关闭启动画面
                finish();
            }
        }, DELAY_TIME);
    }



}
