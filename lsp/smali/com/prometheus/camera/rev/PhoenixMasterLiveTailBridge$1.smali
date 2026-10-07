.class public final Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$1;
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

    iput-object p1, p0, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$1;->val$loader:Ljava/lang/ClassLoader;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method

# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 18

    :try_start_0
    move-object/from16 v15, p1

    iget-object v0, v15, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x3

    aget-object v0, v0, v1

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v2

    const/4 v3, 0x2

    if-ne v2, v3, :done

    iget-object v0, v15, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v4

    iget-object v0, v15, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x1

    aget-object v0, v0, v1

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v5

    iget-object v0, v15, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x2

    aget-object v0, v0, v1

    check-cast v0, Ljava/lang/Float;

    invoke-virtual {v0}, Ljava/lang/Float;->floatValue()F

    move-result v6

    sub-float v7, v5, v4

    invoke-static {v7}, Ljava/lang/Math;->abs(F)F

    move-result v7

    const/high16 v8, 0x3f800000    # 1.0f

    sub-float/2addr v7, v8

    invoke-static {v7}, Ljava/lang/Math;->abs(F)F

    move-result v7

    const v8, 0x3d199998    # 0.0375f

    mul-float/2addr v7, v8

    const v8, 0x3e99999a    # 0.3f

    add-float/2addr v7, v8

    add-float/2addr v6, v7

    add-float/2addr v6, v8

    const v8, 0x49742400    # 1000000.0f

    mul-float/2addr v6, v8

    float-to-long v9, v6

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v11

    sput-wide v11, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge;->zoomStamp:J

    sput-wide v9, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge;->needMicros:J

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