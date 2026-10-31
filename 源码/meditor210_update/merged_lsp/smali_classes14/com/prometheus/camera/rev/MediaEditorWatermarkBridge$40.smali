.class Lcom/prometheus/camera/rev/MediaEditorWatermarkBridge$40;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "MediaEditorWatermarkBridge.java"


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 0

    invoke-static {}, Lcom/prometheus/camera/rev/MeAi;->restore()V

    return-void
.end method

.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 0

    invoke-static {}, Lcom/prometheus/camera/rev/MeAi;->applyAi()V

    return-void
.end method
