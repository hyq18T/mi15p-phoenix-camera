.class final Lcom/prometheus/camera/natural15pro/NaturalHook$H1Hook;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "NaturalHook.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/prometheus/camera/natural15pro/NaturalHook;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "H1Hook"
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 211
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/prometheus/camera/natural15pro/NaturalHook$1;)V
    .locals 0

    .line 211
    invoke-direct {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook$H1Hook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 2

    .line 215
    :try_start_0
    iget-object p0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v0, 0x1

    aget-object p0, p0, v0

    instance-of p0, p0, Landroid/hardware/camera2/CaptureRequest$Builder;

    if-nez p0, :cond_0

    return-void

    .line 218
    :cond_0
    iget-object p0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object p0, p0, v0

    check-cast p0, Landroid/hardware/camera2/CaptureRequest$Builder;

    .line 220
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$1400()I

    move-result p1

    const/16 v1, 0xa3

    if-eq p1, v1, :cond_1

    return-void

    .line 223
    :cond_1
    invoke-static {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$1300(Landroid/hardware/camera2/CaptureRequest$Builder;)Z

    move-result p1

    if-nez p1, :cond_2

    return-void

    .line 226
    :cond_2
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$1800()Z

    move-result p1

    if-eqz p1, :cond_3

    return-void

    .line 229
    :cond_3
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$1000()V

    .line 230
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$1900()Z

    move-result p1

    if-nez p1, :cond_4

    return-void

    .line 233
    :cond_4
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$1100()V

    .line 234
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$2400()Ljava/lang/Object;

    move-result-object p1

    if-eqz p1, :cond_8

    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$2500()Ljava/lang/Object;

    move-result-object p1

    if-nez p1, :cond_5

    goto :goto_0

    .line 237
    :cond_5
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$2400()Ljava/lang/Object;

    move-result-object p1

    invoke-static {p0, p1}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$2600(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    if-eqz p1, :cond_6

    return-void

    .line 240
    :cond_6
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$2700()[B

    move-result-object p1

    if-nez p1, :cond_7

    return-void

    :cond_7
    const-string v1, "/data/vendor/camera/"

    .line 244
    invoke-static {v1}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$2200(Ljava/lang/String;)V

    .line 245
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$2400()Ljava/lang/Object;

    move-result-object v1

    invoke-static {p0, v1, p1}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$2800(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 246
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$2500()Ljava/lang/Object;

    move-result-object p1

    .line 247
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    .line 246
    invoke-static {p0, p1, v1}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$2800(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 248
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$2900()Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object p0

    const/4 p1, 0x0

    invoke-virtual {p0, p1, v0}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result p0

    if-eqz p0, :cond_9

    const-string p0, "vivid fallback injected"

    .line 249
    invoke-static {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$900(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :cond_8
    :goto_0
    return-void

    :catchall_0
    move-exception p0

    const-string p1, "vivid fallback"

    .line 252
    invoke-static {p1, p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$1200(Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_9
    :goto_1
    return-void
.end method
