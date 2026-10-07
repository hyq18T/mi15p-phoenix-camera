.class public final Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$3;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "PhoenixMasterLiveTailBridge.java"

.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge;->hookSnapshotMethod(Ljava/lang/Class;Ljava/lang/ClassLoader;)V
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

    iput-object p1, p0, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$3;->val$loader:Ljava/lang/ClassLoader;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method

# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 16

    :try_start_0
    move-object/from16 v15, p1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    sget-wide v4, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge;->zoomStamp:J

    sget-wide v6, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge;->needMicros:J

    sub-long v8, v2, v4


    const-wide/16 v0, 0x7d0

    cmp-long v1, v8, v0

    if-gez v1, :done

    invoke-virtual {v15}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :done

    instance-of v1, v0, Lym/k;

    if-eqz v1, :done

    check-cast v0, Lym/k;

    iget-wide v2, v0, Lym/k;->g:J

    iget-wide v4, v0, Lym/k;->f:J

    sget-wide v6, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge;->needMicros:J

    add-long/2addr v6, v2

    cmp-long v8, v4, v6

    if-gez v8, :ok

    iput-wide v6, v0, Lym/k;->f:J

    move-wide v4, v6

    :ok
    nop
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :done
    return-void

    :catchall_0
    move-exception v0

    const-string v1, "PHX77"

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method