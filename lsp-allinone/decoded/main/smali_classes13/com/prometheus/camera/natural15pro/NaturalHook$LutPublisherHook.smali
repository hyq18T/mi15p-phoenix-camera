.class final Lcom/prometheus/camera/natural15pro/NaturalHook$LutPublisherHook;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "NaturalHook.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/prometheus/camera/natural15pro/NaturalHook;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "LutPublisherHook"
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 257
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/prometheus/camera/natural15pro/NaturalHook$1;)V
    .locals 0

    .line 257
    invoke-direct {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook$LutPublisherHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 6

    const-string p0, "published lut_cvstyle_natural bytes="

    const/4 v0, 0x0

    .line 261
    :try_start_0
    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const-string v2, "b"

    .line 262
    invoke-static {v1, v2}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    .line 263
    instance-of v3, v2, Ljava/lang/String;

    if-eqz v3, :cond_2

    const-string v3, "lut_cvstyle_natural"

    .line 264
    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    goto :goto_0

    .line 268
    :cond_0
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$1000()V

    .line 269
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$3000()[B

    move-result-object v2

    if-nez v2, :cond_1

    const-string p0, "LUT asset missing; publisher skipped"

    .line 271
    invoke-static {p0, v0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$1200(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 272
    invoke-virtual {p1, v0}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    return-void

    :cond_1
    const-string v3, "c"

    .line 276
    invoke-static {v1, v3}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    const-string v4, "d"

    .line 277
    invoke-static {v1, v4}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    const-string v4, "com.xiaomi.camera.mivi.filter.MIVILutSaver"

    .line 279
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$3100()Ljava/lang/ClassLoader;

    move-result-object v5

    .line 278
    invoke-static {v4, v5}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v4

    const-string v5, "writeLutToDir"

    .line 280
    filled-new-array {v3, v1, v2}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v4, v5, v1}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 282
    invoke-virtual {p1, v0}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    .line 283
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$3200()Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v3

    const/4 v4, 0x0

    const/4 v5, 0x1

    invoke-virtual {v3, v4, v5}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 284
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, p0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    array-length p0, v2

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p0, " result="

    invoke-virtual {v3, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$900(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :cond_2
    :goto_0
    return-void

    :catchall_0
    move-exception p0

    const-string v1, "LUT publish"

    .line 288
    invoke-static {v1, p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$1200(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 289
    invoke-virtual {p1, v0}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    :cond_3
    :goto_1
    return-void
.end method
