.class final Lcom/prometheus/camera/natural15pro/NaturalHook$BuilderSetHook;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "NaturalHook.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/prometheus/camera/natural15pro/NaturalHook;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "BuilderSetHook"
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 126
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/prometheus/camera/natural15pro/NaturalHook$1;)V
    .locals 0

    .line 126
    invoke-direct {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook$BuilderSetHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 5

    .line 129
    sget-object p0, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$400()Ljava/lang/ThreadLocal;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/Boolean;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    return-void

    .line 133
    :cond_0
    :try_start_0
    iget-object p0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v0, 0x0

    aget-object p0, p0, v0

    instance-of p0, p0, Landroid/hardware/camera2/CaptureRequest$Key;

    if-nez p0, :cond_1

    return-void

    .line 136
    :cond_1
    iget-object p0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object p0, p0, v0

    check-cast p0, Landroid/hardware/camera2/CaptureRequest$Key;

    .line 137
    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    check-cast v1, Landroid/hardware/camera2/CaptureRequest$Builder;

    .line 139
    invoke-virtual {p0}, Landroid/hardware/camera2/CaptureRequest$Key;->getName()Ljava/lang/String;

    move-result-object v2

    const-string v3, "com.xiaomi.sessionparams.stylizationType"

    .line 141
    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    .line 142
    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x1

    aget-object p1, p1, v2

    invoke-static {p1}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$500(Ljava/lang/Object;)Z

    move-result p1

    .line 143
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$600()Ljava/util/Map;

    move-result-object v3

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    invoke-interface {v3, v1, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 144
    invoke-static {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$702(Landroid/hardware/camera2/CaptureRequest$Key;)Landroid/hardware/camera2/CaptureRequest$Key;

    if-eqz p1, :cond_2

    .line 145
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$800()Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object p0

    invoke-virtual {p0, v0, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result p0

    if-eqz p0, :cond_2

    const-string p0, "vivid builder marked"

    .line 146
    invoke-static {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$900(Ljava/lang/String;)V

    .line 148
    :cond_2
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$1000()V

    return-void

    :cond_3
    const-string p0, "com.xiaomi.mivi2.renderType"

    .line 152
    invoke-virtual {p0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_4

    .line 153
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$1100()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p0

    const-string p1, "builder set"

    .line 156
    invoke-static {p1, p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$1200(Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_4
    :goto_0
    return-void
.end method
