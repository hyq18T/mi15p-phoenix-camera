.class public final Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$6;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "PhoenixMasterLiveTailBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge;->install(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$loader:Ljava/lang/ClassLoader;


# direct methods
.method constructor <init>(Ljava/lang/ClassLoader;)V
    .locals 0

    iput-object p1, p0, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$6;->val$loader:Ljava/lang/ClassLoader;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 8

    :try_start_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    sput-wide v2, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge;->mlStamp:J

    const/4 v2, 0x0

    sput v2, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge;->mlMode:I

    const-string v3, "l"

    invoke-static {v0, v3}, Lde/robv/android/xposed/XposedHelpers;->getBooleanField(Ljava/lang/Object;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :a

    const/4 v5, 0x1

    sput v5, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge;->mlMode:I

    :a
    const-string v3, "m"

    invoke-static {v0, v3}, Lde/robv/android/xposed/XposedHelpers;->getBooleanField(Ljava/lang/Object;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :b

    const/4 v5, 0x2

    sput v5, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge;->mlMode:I

    :b
    const-string v3, "n"

    invoke-static {v0, v3}, Lde/robv/android/xposed/XposedHelpers;->getBooleanField(Ljava/lang/Object;Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :c

    const/4 v5, 0x3

    sput v5, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge;->mlMode:I

    :c
    nop
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-void

    :catchall_0
    move-exception v0

    const-string v1, "PHX77"

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method