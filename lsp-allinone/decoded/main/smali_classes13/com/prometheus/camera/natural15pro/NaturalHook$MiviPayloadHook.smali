.class final Lcom/prometheus/camera/natural15pro/NaturalHook$MiviPayloadHook;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "NaturalHook.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/prometheus/camera/natural15pro/NaturalHook;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "MiviPayloadHook"
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 161
    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/prometheus/camera/natural15pro/NaturalHook$1;)V
    .locals 0

    .line 161
    invoke-direct {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook$MiviPayloadHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 8

    const-string p0, "payload module="

    const-string v0, "t0 hit #"

    .line 165
    :try_start_0
    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x0

    aget-object v1, v1, v2

    instance-of v1, v1, Landroid/hardware/camera2/CaptureRequest$Builder;

    if-nez v1, :cond_0

    return-void

    .line 168
    :cond_0
    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v1, v1, v2

    check-cast v1, Landroid/hardware/camera2/CaptureRequest$Builder;

    .line 170
    iget-object v3, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v4, 0x1

    aget-object v3, v3, v4

    instance-of v3, v3, [B

    if-nez v3, :cond_1

    return-void

    .line 174
    :cond_1
    invoke-static {v1}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$1300(Landroid/hardware/camera2/CaptureRequest$Builder;)Z

    move-result v1

    .line 175
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$1400()I

    move-result v3

    .line 176
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$1500()Ljava/util/concurrent/atomic/AtomicInteger;

    move-result-object v5

    invoke-virtual {v5}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    move-result v5
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/16 v6, 0x14

    const-string v7, " vivid="

    if-gt v5, v6, :cond_2

    .line 178
    :try_start_1
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, " module="

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string v0, " len="

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v0, v0, v4

    check-cast v0, [B

    array-length v0, v0

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$900(Ljava/lang/String;)V

    .line 181
    :cond_2
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$1600()Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object v0

    invoke-virtual {v0, v2, v4}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 182
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0, p0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    const-string p0, " payload="

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object p0, p0, v4

    check-cast p0, [B

    .line 183
    invoke-static {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$1700([B)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 182
    invoke-static {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$900(Ljava/lang/String;)V

    :cond_3
    if-eqz v1, :cond_8

    const/16 p0, 0xa3

    if-eq v3, p0, :cond_4

    goto :goto_0

    .line 188
    :cond_4
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$1800()Z

    move-result p0

    if-eqz p0, :cond_5

    return-void

    .line 192
    :cond_5
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$1000()V

    .line 193
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$1900()Z

    move-result p0

    if-nez p0, :cond_6

    return-void

    .line 196
    :cond_6
    iget-object p0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object p0, p0, v4

    check-cast p0, [B

    invoke-static {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$2000([B)[B

    move-result-object p0

    if-nez p0, :cond_7

    return-void

    .line 200
    :cond_7
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aput-object p0, v0, v4

    .line 201
    iget-object p0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object p0, p0, v4

    check-cast p0, [B

    invoke-static {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$2100([B)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$2200(Ljava/lang/String;)V

    .line 202
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$2300()Ljava/util/concurrent/atomic/AtomicBoolean;

    move-result-object p0

    invoke-virtual {p0, v2, v4}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result p0

    if-eqz p0, :cond_9

    const-string p0, "MIVI payload rewritten to lut_cvstyle_natural"

    .line 203
    invoke-static {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$900(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_1

    :cond_8
    :goto_0
    return-void

    :catchall_0
    move-exception p0

    const-string p1, "MIVI payload"

    .line 206
    invoke-static {p1, p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->access$1200(Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_9
    :goto_1
    return-void
.end method
