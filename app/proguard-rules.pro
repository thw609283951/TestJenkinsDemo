
#混淆时包 名不使用大小写混合 aA Aa
-dontusemixedcaseclassnames

# 不混淆第三方引用的库
-dontskipnonpubliclibraryclasses
# 混淆后生产映射文件 map 类名->转化后类名的映射
# 存放在app\build\outputs\mapping\release中
-verbose
-dontwarn

# 不优化
-dontoptimize
# 代码循环优化次数，0-7，默认为5
-optimizationpasses 5
# 不做预校验
-dontpreverify
# 忽略警告
-ignorewarning

# 混淆前后的映射
-printmapping mapping.txt

# apk 包内所有 class 的内部结构
-dump class_files.txt

# 未混淆的类和成员
-printseeds seeds.txt

# 列出从 apk 中删除的代码
-printusage unused.txt

# 保留Annotation不混淆
-keepattributes *Annotation*,InnerClasses
# 避免混淆泛型
-keepattributes Signature
# 抛出异常时保留代码行号
-keepattributes SourceFile,LineNumberTable
# 指定混淆是采用的算法，后面的参数是一个过滤器
# 这个过滤器是谷歌推荐的算法，一般不做更改
-optimizations !code/simplification/cast,!field/*,!class/merging/*

# 关闭log
#-assumenosideeffects class android.util.Log {
#    public static boolean isLoggable(java.lang.String, int);
#    public static int v(...);
#    public static int i(...);
#    public static int w(...);
#    public static int d(...);
#    public static int e(...);
#}


#-------------------------------------通用混淆配置 start ---------------------------------------

# 对于继承Android的四大组件等系统类，保持原样
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference
-keep public class com.android.vending.licensing.ILicensingService
-keep class android.support.**{*;}
-keep class android.support.v4.** { *; }
-keep interface android.support.v4.app.** { *; }
-keep public class * extends android.support.v4.**
-keep public class * extends android.support.v7.**
-keep public class * extends android.support.annotation.**

-dontwarn android.support.v4.**
-dontwarn com.android.support.**
-dontwarn android.support.**


# 保对所有类的native方法名不进行混淆
-keepclasseswithmembernames class *{
    native <methods>;
}
# 对所有类的初始化方法的方法名不进行混淆
-keepclasseswithmembers class *{
    public <init>(android.content.Context, android.util.AttributeSet);
}
-keepclasseswithmembers class *{
    public <init>(android.content.Context, android.util.AttributeSet,int);
}
# 保护继承至View对象中的set/get方法
-keepclassmembers public class * extends android.view.View {
   void set*(***);
   *** get*();
   public <init>(android.content.Context);
   public <init>(android.content.Context, android.util.AttributeSet);
   public <init>(android.content.Context, android.util.AttributeSet, int);
}
# 对枚举类型enum的所有类的以下指定方法的方法名不进行混淆
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
# 对实现了Parcelable接口的所有类的类名不进行混淆，对其成员变量为Parcelable$Creator类型的成员变量的变量名不进行混淆
-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}
-keepclassmembers class * implements android.os.Parcelable {
     public <fields>;
     private <fields>;
}

# 保留Serializable序列化的类不被混淆
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    !static !transient <fields>;
    !private <fields>;
    !private <methods>;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# 对于带有回调函数的onXXEvent、**On*Listener的，不能被混淆
-keepclassmembers class * {
    void *(**On*Event);
    void *(**On*Listener);
}

# webView处理，项目中没有使用到webView忽略即可
-keepclassmembers class fqcn.of.javascript.interface.for.webview {
    public *;
}
-keepclassmembers class * extends android.webkit.webViewClient {
    public void *(android.webkit.WebView, java.lang.String, android.graphics.Bitmap);
    public boolean *(android.webkit.WebView, java.lang.String);
}
-keepclassmembers class * extends android.webkit.webViewClient {
    public void *(android.webkit.webView, jav.lang.String);
}

-keep class **.R$* {
*;
}
#----------------------------------------通用混淆配置 end ------------------------------------

#-----------处理反射类---------------



#-----------处理js交互---------------



#-----------处理实体类---------------



#-----------处理第三方依赖库---------

#保持gson不被混淆
-keep class com.google.gson.** {*;}
#-keep class com.google.**{*;}
-keep class sun.misc.Unsafe { *; }
-keep class com.google.gson.stream.** { *; }
-keep class com.google.gson.examples.android.model.** { *; }
-keep class com.google.** {
    <fields>;
    <methods>;
}

#okhttp
-dontwarn okhttp3.**
-keep class okhttp3.**{*;}
-dontwarn com.squareup.okhttp.**
-keep class com.squareup.okhttp.** {*;}
-keep interface com.squareup.okhttp.** {*;}
#okio
-dontwarn okio.**
-keep class okio.**{*;}

# RxJava RxAndroid
-dontwarn sun.misc.**
-keepclassmembers class rx.internal.util.unsafe.*ArrayQueue*Field* {
    long producerIndex;
    long consumerIndex;
}
-keepclassmembers class rx.internal.util.unsafe.BaseLinkedQueueProducerNodeRef {
    rx.internal.util.atomic.LinkedQueueNode producerNode;
}
-keepclassmembers class rx.internal.util.unsafe.BaseLinkedQueueConsumerNodeRef {
    rx.internal.util.atomic.LinkedQueueNode consumerNode;
}

#butterknife
-keep class butterknife.** { *; }
-dontwarn butterknife.internal.**
-keep class **$$ViewBinder { *; }
-keepclasseswithmembernames class * {
    @butterknife.* <fields>;
}
-keepclasseswithmembernames class * {
    @butterknife.* <methods>;
}

#glide
-keep public class * implements com.bumptech.glide.module.GlideModule
-keep public enum com.bumptech.glide.load.resource.bitmap.ImageHeaderParser$** {
  **[] $VALUES;
  public *;
}

#utilcode
-keep class com.blankj.utilcode.** { *; }
-keepclassmembers class com.blankj.utilcode.** { *; }
-dontwarn com.blankj.utilcode.**

#zxing
-dontwarn com.google.zxing.**
-keep  class com.google.zxing.**{*;}

-keep class * extends java.lang.annotation.Annotation { *; }
-keep interface * extends java.lang.annotation.Annotation { *; }

-dontwarn cn.bertsir.zbar.**
-keep  class cn.bertsir.zbar.**{*;}
#------tbs腾讯x5混淆规则-------
#-optimizationpasses 7
#-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*
-dontoptimize
-dontusemixedcaseclassnames
-verbose
-dontskipnonpubliclibraryclasses
-dontskipnonpubliclibraryclassmembers
-dontwarn dalvik.**
#-overloadaggressively

#@proguard_debug_start
# ------------------ Keep LineNumbers and properties ---------------- #
-keepattributes Exceptions,InnerClasses,Signature,Deprecated,SourceFile,LineNumberTable,*Annotation*,EnclosingMethod
-renamesourcefileattribute TbsSdkJava
-keepattributes SourceFile,LineNumberTable
#@proguard_debug_end

# --------------------------------------------------------------------------
# Addidional for x5.sdk classes for apps

-keep class com.tencent.smtt.export.external.**{
    *;
}

-keep class com.tencent.tbs.video.interfaces.IUserStateChangedListener {
    *;
}

-keep class com.tencent.smtt.sdk.CacheManager {
    public *;
}

-keep class com.tencent.smtt.sdk.CookieManager {
    public *;
}

-keep class com.tencent.smtt.sdk.WebHistoryItem {
    public *;
}

-keep class com.tencent.smtt.sdk.WebViewDatabase {
    public *;
}

-keep class com.tencent.smtt.sdk.WebBackForwardList {
    public *;
}

-keep public class com.tencent.smtt.sdk.WebView {
    public <fields>;
    public <methods>;
}

-keep public class com.tencent.smtt.sdk.WebView$HitTestResult {
    public static final <fields>;
    public java.lang.String getExtra();
    public int getType();
}

-keep public class com.tencent.smtt.sdk.WebView$WebViewTransport {
    public <methods>;
}

-keep public class com.tencent.smtt.sdk.WebView$PictureListener {
    public <fields>;
    public <methods>;
}


-keepattributes InnerClasses

-keep public enum com.tencent.smtt.sdk.WebSettings$** {
    *;
}

-keep public enum com.tencent.smtt.sdk.QbSdk$** {
    *;
}

-keep public class com.tencent.smtt.sdk.WebSettings {
    public *;
}


-keepattributes Signature
-keep public class com.tencent.smtt.sdk.ValueCallback {
    public <fields>;
    public <methods>;
}

-keep public class com.tencent.smtt.sdk.WebViewClient {
    public <fields>;
    public <methods>;
}

-keep public class com.tencent.smtt.sdk.DownloadListener {
    public <fields>;
    public <methods>;
}

-keep public class com.tencent.smtt.sdk.WebChromeClient {
    public <fields>;
    public <methods>;
}

-keep public class com.tencent.smtt.sdk.WebChromeClient$FileChooserParams {
    public <fields>;
    public <methods>;
}

-keep class com.tencent.smtt.sdk.SystemWebChromeClient{
    public *;
}
# 1. extension interfaces should be apparent
-keep public class com.tencent.smtt.export.external.extension.interfaces.* {
    public protected *;
}

# 2. interfaces should be apparent
-keep public class com.tencent.smtt.export.external.interfaces.* {
    public protected *;
}

-keep public class com.tencent.smtt.sdk.WebViewCallbackClient {
    public protected *;
}

-keep public class com.tencent.smtt.sdk.WebStorage$QuotaUpdater {
    public <fields>;
    public <methods>;
}

-keep public class com.tencent.smtt.sdk.WebIconDatabase {
    public <fields>;
    public <methods>;
}

-keep public class com.tencent.smtt.sdk.WebStorage {
    public <fields>;
    public <methods>;
}

-keep public class com.tencent.smtt.sdk.DownloadListener {
    public <fields>;
    public <methods>;
}

-keep public class com.tencent.smtt.sdk.QbSdk {
    public <fields>;
    public <methods>;
}

-keep public class com.tencent.smtt.sdk.QbSdk$PreInitCallback {
    public <fields>;
    public <methods>;
}
-keep public class com.tencent.smtt.sdk.CookieSyncManager {
    public <fields>;
    public <methods>;
}

-keep public class com.tencent.smtt.sdk.Tbs* {
    public <fields>;
    public <methods>;
}

-keep public class com.tencent.smtt.utils.LogFileUtils {
    public <fields>;
    public <methods>;
}

-keep public class com.tencent.smtt.utils.TbsLog {
    public <fields>;
    public <methods>;
}

-keep public class com.tencent.smtt.utils.TbsLogClient {
    public <fields>;
    public <methods>;
}

-keep public class com.tencent.smtt.sdk.CookieSyncManager {
    public <fields>;
    public <methods>;
}

# Added for game demos
-keep public class com.tencent.smtt.sdk.TBSGamePlayer {
    public <fields>;
    public <methods>;
}

-keep public class com.tencent.smtt.sdk.TBSGamePlayerClient* {
    public <fields>;
    public <methods>;
}

-keep public class com.tencent.smtt.sdk.TBSGamePlayerClientExtension {
    public <fields>;
    public <methods>;
}

-keep public class com.tencent.smtt.sdk.TBSGamePlayerService* {
    public <fields>;
    public <methods>;
}

-keep public class com.tencent.smtt.utils.Apn {
    public <fields>;
    public <methods>;
}
# end


-keep public class com.tencent.smtt.export.external.extension.proxy.ProxyWebViewClientExtension {
    public <fields>;
    public <methods>;
}

-keep class MTT.ThirdAppInfoNew {
    *;
}

-keep class com.tencent.mtt.MttTraceEvent {
    *;
}

# Game related
-keep public class com.tencent.smtt.gamesdk.* {
    public protected *;
}

-keep public class com.tencent.smtt.sdk.TBSGameBooter {
        public <fields>;
        public <methods>;
}

-keep public class com.tencent.smtt.sdk.TBSGameBaseActivity {
    public protected *;
}

-keep public class com.tencent.smtt.sdk.TBSGameBaseActivityProxy {
    public protected *;
}

-keep public class com.tencent.smtt.gamesdk.internal.TBSGameServiceClient {
    public *;
}
#---------------------------------------------------------------------------
