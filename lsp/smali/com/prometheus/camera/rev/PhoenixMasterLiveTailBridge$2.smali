.class public final Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$2;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "PhoenixMasterLiveTailBridge.java"

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

    iput-object p1, p0, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$2;->val$loader:Ljava/lang/ClassLoader;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method

# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
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

    iget-object v14, v15, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v0, 0x0

    aget-object v1, v14, v0

    check-cast v1, Ljava/lang/Long;

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    const/4 v0, 0x1

    aget-object v1, v14, v0

    check-cast v1, Ljava/lang/Long;

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    const/4 v0, 0x2

    aget-object v1, v14, v0

    check-cast v1, Ljava/lang/Long;

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v6

    const/4 v0, 0x3

    aget-object v1, v14, v0

    check-cast v1, Ljava/lang/Long;

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v8

    sget-wide v10, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge;->needMicros:J

    add-long v12, v6, v10

    cmp-long v0, v4, v12

    if-gez v0, :tail_ok

    invoke-static {v12, v13}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const/4 v0, 0x1

    aput-object v1, v14, v0

    move-wide v4, v12

    :tail_ok
    sub-long v10, v12, v2

    const-wide/32 v0, 0x493e0

    add-long/2addr v10, v0

    cmp-long v0, v8, v10

    if-gez v0, :t_ok

    invoke-static {v10, v11}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const/4 v0, 0x3

    aput-object v1, v14, v0

    move-wide v8, v10

    :t_ok
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