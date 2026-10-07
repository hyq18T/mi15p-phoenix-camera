.class public final Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$5;
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

    iput-object p1, p0, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$5;->val$loader:Ljava/lang/ClassLoader;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 14

    :try_start_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x3

    aget-object v12, v0, v1

    check-cast v12, Ljava/lang/Long;

    invoke-virtual {v12}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    const/4 v1, 0x4

    aget-object v12, v0, v1

    check-cast v12, Ljava/lang/Long;

    invoke-virtual {v12}, Ljava/lang/Long;->longValue()J

    move-result-wide v5

    sget v13, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge;->mlMode:I

    const/4 v12, 0x2

    if-eq v13, v12, :fresh

    const/4 v12, 0x3

    if-eq v13, v12, :fresh

    goto :log

    :fresh
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v10

    sget-wide v8, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge;->mlStamp:J

    sub-long/2addr v10, v8

    const-wide/16 v8, 0x7d0

    cmp-long v13, v10, v8

    if-ltz v13, :doPatch

    goto :log

    :doPatch
    const-wide/32 v10, 0x7a1200

    invoke-static {v10, v11}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v12

    const/4 v1, 0x3

    aput-object v12, v0, v1

    const/4 v1, 0x3

    aget-object v12, v0, v1

    check-cast v12, Ljava/lang/Long;

    invoke-virtual {v12}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    :log
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