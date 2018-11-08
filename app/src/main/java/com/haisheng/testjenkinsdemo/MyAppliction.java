package com.haisheng.testjenkinsdemo;

import android.app.Application;
import android.util.Log;

import com.blankj.utilcode.util.Utils;
import com.tencent.smtt.sdk.QbSdk;

public class MyAppliction extends Application {
    @Override
    public void onCreate() {
        super.onCreate();

        //x5内核初始化接口
        QbSdk.initX5Environment(getApplicationContext(),  mPreInitCallback);
        Utils.init((Application) getApplicationContext());
    }

    QbSdk.PreInitCallback mPreInitCallback = new QbSdk.PreInitCallback() {
        @Override
        public void onCoreInitFinished() {
        }

        @Override
        public void onViewInitFinished(boolean arg0) {
            //x5內核初始化完成的回调，为true表示x5内核加载成功，否则表示x5内核加载失败，会自动切换到系统内核。
            Log.d("app"," X5加载结果 "+ arg0);

        }
    };
}
