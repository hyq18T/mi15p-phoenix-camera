.class public final Lcom/prometheus/camera/natural15pro/NaturalHook;
.super Ljava/lang/Object;
.source "NaturalHook.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/prometheus/camera/natural15pro/NaturalHook$BuilderSetHook;,
        Lcom/prometheus/camera/natural15pro/NaturalHook$MiviPayloadHook;,
        Lcom/prometheus/camera/natural15pro/NaturalHook$H1Hook;,
        Lcom/prometheus/camera/natural15pro/NaturalHook$LutPublisherHook;
    }
.end annotation


# static fields
.field private static final DISABLE_FLAG:Ljava/lang/String; = "/data/data/com.android.camera/files/natural15pro.off"

.field private static final INSTALLED:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private static final INTERNAL:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field

.field private static final LOG_DISABLED:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private static final LOG_FAIL:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private static final LOG_FALLBACK:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private static final LOG_PAYLOAD:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private static final LOG_PUBLISH:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private static final LOG_REWRITE:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private static final LOG_STYLE:Ljava/util/concurrent/atomic/AtomicBoolean;

.field private static final LOG_TAG:Ljava/lang/String; = "PhoenixNatural15Pro"

.field private static final LUT_NAME:Ljava/lang/String; = "lut_cvstyle_natural"

.field private static final LUT_PATH:Ljava/lang/String; = "/data/vendor/camera/"

.field private static final LUT_WRITTEN_AT:Ljava/util/concurrent/atomic/AtomicLong;

.field private static final PAYLOAD_HITS:Ljava/util/concurrent/atomic/AtomicInteger;

.field private static final PHOTO_MODULE:I = 0xa3

.field private static final PURE_LUT_SCRIPT:Ljava/lang/String; = "@CubeLutEffect;cube_strength=1.0;lut_type=0;@"

.field private static final RENDER_TYPE_FILTER:I = 0x1

.field private static final RENDER_TYPE_TAG:Ljava/lang/String; = "com.xiaomi.mivi2.renderType"

.field private static final STYLE_TAG:Ljava/lang/String; = "com.xiaomi.sessionparams.stylizationType"

.field private static final VIVID_BUILDERS:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Landroid/hardware/camera2/CaptureRequest$Builder;",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field

.field private static volatile appLoader:Ljava/lang/ClassLoader;

.field private static volatile assetFailed:Z

.field private static volatile fallbackPayload:[B

.field private static volatile lutBytes:[B

.field private static volatile miviRenderWrapper:Ljava/lang/Object;

.field private static volatile renderTypeWrapper:Ljava/lang/Object;

.field private static volatile styleKey:Landroid/hardware/camera2/CaptureRequest$Key;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/hardware/camera2/CaptureRequest$Key<",
            "*>;"
        }
    .end annotation
.end field

.field private static volatile tagHelper:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 35
    new-instance v0, Ljava/util/WeakHashMap;

    invoke-direct {v0}, Ljava/util/WeakHashMap;-><init>()V

    .line 36
    invoke-static {v0}, Ljava/util/Collections;->synchronizedMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    sput-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->VIVID_BUILDERS:Ljava/util/Map;

    .line 38
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->INSTALLED:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 39
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->LOG_STYLE:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 40
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->LOG_REWRITE:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 41
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->LOG_PUBLISH:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 42
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->LOG_PAYLOAD:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 43
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->LOG_FALLBACK:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 44
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->LOG_DISABLED:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 45
    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>(I)V

    sput-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->PAYLOAD_HITS:Ljava/util/concurrent/atomic/AtomicInteger;

    .line 47
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->LOG_FAIL:Ljava/util/concurrent/atomic/AtomicBoolean;

    .line 48
    new-instance v0, Ljava/util/concurrent/atomic/AtomicLong;

    const-wide/16 v1, 0x0

    invoke-direct {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicLong;-><init>(J)V

    sput-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->LUT_WRITTEN_AT:Ljava/util/concurrent/atomic/AtomicLong;

    .line 50
    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->INTERNAL:Ljava/lang/ThreadLocal;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 61
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$1000()V
    .locals 0

    .line 20
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->ensureAsset()V

    return-void
.end method

.method static synthetic access$1100()V
    .locals 0

    .line 20
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->ensureWrappers()V

    return-void
.end method

.method static synthetic access$1200(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 0

    .line 20
    invoke-static {p0, p1}, Lcom/prometheus/camera/natural15pro/NaturalHook;->logFailure(Ljava/lang/String;Ljava/lang/Throwable;)V

    return-void
.end method

.method static synthetic access$1300(Landroid/hardware/camera2/CaptureRequest$Builder;)Z
    .locals 0

    .line 20
    invoke-static {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->isVividBuilder(Landroid/hardware/camera2/CaptureRequest$Builder;)Z

    move-result p0

    return p0
.end method

.method static synthetic access$1400()I
    .locals 1

    .line 20
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->currentModule()I

    move-result v0

    return v0
.end method

.method static synthetic access$1500()Ljava/util/concurrent/atomic/AtomicInteger;
    .locals 1

    .line 20
    sget-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->PAYLOAD_HITS:Ljava/util/concurrent/atomic/AtomicInteger;

    return-object v0
.end method

.method static synthetic access$1600()Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1

    .line 20
    sget-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->LOG_PAYLOAD:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method

.method static synthetic access$1700([B)Ljava/lang/String;
    .locals 0

    .line 20
    invoke-static {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->preview([B)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$1800()Z
    .locals 1

    .line 20
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->disabled()Z

    move-result v0

    return v0
.end method

.method static synthetic access$1900()Z
    .locals 1

    .line 20
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->canApply()Z

    move-result v0

    return v0
.end method

.method static synthetic access$2000([B)[B
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 20
    invoke-static {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->rewritePayload([B)[B

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$2100([B)Ljava/lang/String;
    .locals 0

    .line 20
    invoke-static {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->lutPathOf([B)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$2200(Ljava/lang/String;)V
    .locals 0

    .line 20
    invoke-static {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->publishLut(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$2300()Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1

    .line 20
    sget-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->LOG_REWRITE:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method

.method static synthetic access$2400()Ljava/lang/Object;
    .locals 1

    .line 20
    sget-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->miviRenderWrapper:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$2500()Ljava/lang/Object;
    .locals 1

    .line 20
    sget-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->renderTypeWrapper:Ljava/lang/Object;

    return-object v0
.end method

.method static synthetic access$2600(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 20
    invoke-static {p0, p1}, Lcom/prometheus/camera/natural15pro/NaturalHook;->readTag(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$2700()[B
    .locals 1

    .line 20
    invoke-static {}, Lcom/prometheus/camera/natural15pro/NaturalHook;->syntheticPayload()[B

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$2800(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 0

    .line 20
    invoke-static {p0, p1, p2}, Lcom/prometheus/camera/natural15pro/NaturalHook;->setTag(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/lang/Object;Ljava/lang/Object;)V

    return-void
.end method

.method static synthetic access$2900()Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1

    .line 20
    sget-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->LOG_FALLBACK:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method

.method static synthetic access$3000()[B
    .locals 1

    .line 20
    sget-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->lutBytes:[B

    return-object v0
.end method

.method static synthetic access$3100()Ljava/lang/ClassLoader;
    .locals 1

    .line 20
    sget-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->appLoader:Ljava/lang/ClassLoader;

    return-object v0
.end method

.method static synthetic access$3200()Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1

    .line 20
    sget-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->LOG_PUBLISH:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method

.method static synthetic access$400()Ljava/lang/ThreadLocal;
    .locals 1

    .line 20
    sget-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->INTERNAL:Ljava/lang/ThreadLocal;

    return-object v0
.end method

.method static synthetic access$500(Ljava/lang/Object;)Z
    .locals 0

    .line 20
    invoke-static {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->isVivid(Ljava/lang/Object;)Z

    move-result p0

    return p0
.end method

.method static synthetic access$600()Ljava/util/Map;
    .locals 1

    .line 20
    sget-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->VIVID_BUILDERS:Ljava/util/Map;

    return-object v0
.end method

.method static synthetic access$702(Landroid/hardware/camera2/CaptureRequest$Key;)Landroid/hardware/camera2/CaptureRequest$Key;
    .locals 0

    .line 20
    sput-object p0, Lcom/prometheus/camera/natural15pro/NaturalHook;->styleKey:Landroid/hardware/camera2/CaptureRequest$Key;

    return-object p0
.end method

.method static synthetic access$800()Ljava/util/concurrent/atomic/AtomicBoolean;
    .locals 1

    .line 20
    sget-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->LOG_STYLE:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-object v0
.end method

.method static synthetic access$900(Ljava/lang/String;)V
    .locals 0

    .line 20
    invoke-static {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->log(Ljava/lang/String;)V

    return-void
.end method

.method private static canApply()Z
    .locals 1

    .line 500
    sget-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->lutBytes:[B

    if-eqz v0, :cond_0

    sget-boolean v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->assetFailed:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private static countOf(Ljava/lang/String;Ljava/lang/String;)I
    .locals 3

    const/4 v0, 0x0

    if-eqz p0, :cond_2

    .line 357
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_2

    if-eqz p1, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_1

    :cond_0
    move v1, v0

    .line 362
    :goto_0
    invoke-virtual {p0, p1, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;I)I

    move-result v0

    if-ltz v0, :cond_1

    add-int/lit8 v1, v1, 0x1

    .line 364
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    add-int/2addr v0, v2

    goto :goto_0

    :cond_1
    return v1

    :cond_2
    :goto_1
    return v0
.end method

.method private static currentModule()I
    .locals 2

    :try_start_0
    const-string v0, "com.android.camera.module.Y"

    .line 491
    sget-object v1, Lcom/prometheus/camera/natural15pro/NaturalHook;->appLoader:Ljava/lang/ClassLoader;

    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    const-string v1, "a"

    .line 493
    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedHelpers;->getStaticIntField(Ljava/lang/Class;Ljava/lang/String;)I

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return v0

    :catchall_0
    const/4 v0, -0x1

    return v0
.end method

.method private static disabled()Z
    .locals 3

    .line 504
    new-instance v0, Ljava/io/File;

    const-string v1, "/data/data/com.android.camera/files/natural15pro.off"

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    .line 507
    :cond_0
    sget-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->LOG_DISABLED:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "disabled by /data/data/com.android.camera/files/natural15pro.off"

    .line 508
    invoke-static {v0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->log(Ljava/lang/String;)V

    :cond_1
    return v2
.end method

.method private static ensureAsset()V
    .locals 4

    const-string v0, "LUT asset loaded bytes="

    .line 514
    sget-object v1, Lcom/prometheus/camera/natural15pro/NaturalHook;->lutBytes:[B

    if-nez v1, :cond_4

    sget-boolean v1, Lcom/prometheus/camera/natural15pro/NaturalHook;->assetFailed:Z

    if-eqz v1, :cond_0

    goto :goto_2

    .line 517
    :cond_0
    const-class v1, Lcom/prometheus/camera/natural15pro/NaturalHook;

    monitor-enter v1

    .line 518
    :try_start_0
    sget-object v2, Lcom/prometheus/camera/natural15pro/NaturalHook;->lutBytes:[B

    if-nez v2, :cond_3

    sget-boolean v2, Lcom/prometheus/camera/natural15pro/NaturalHook;->assetFailed:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-eqz v2, :cond_1

    goto :goto_1

    :cond_1
    :try_start_1
    const-string v2, "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"

    const/4 v3, 0x0

    .line 522
    invoke-static {v2, v3}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object v2

    .line 524
    array-length v3, v2

    if-eqz v3, :cond_2

    .line 527
    sput-object v2, Lcom/prometheus/camera/natural15pro/NaturalHook;->lutBytes:[B

    .line 528
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    array-length v0, v2

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->log(Ljava/lang/String;)V

    goto :goto_0

    .line 525
    :cond_2
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v2, "empty LUT asset"

    invoke-direct {v0, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :catchall_0
    move-exception v0

    const/4 v2, 0x1

    .line 530
    :try_start_2
    sput-boolean v2, Lcom/prometheus/camera/natural15pro/NaturalHook;->assetFailed:Z

    const-string v2, "LUT asset unavailable; module stays passive"

    .line 531
    invoke-static {v2}, Lcom/prometheus/camera/natural15pro/NaturalHook;->log(Ljava/lang/String;)V

    .line 532
    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    .line 534
    :goto_0
    monitor-exit v1

    return-void

    .line 519
    :cond_3
    :goto_1
    monitor-exit v1

    return-void

    :catchall_1
    move-exception v0

    .line 534
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    throw v0

    :cond_4
    :goto_2
    return-void
.end method

.method private static ensureWrappers()V
    .locals 3

    .line 440
    sget-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->tagHelper:Ljava/lang/Class;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->renderTypeWrapper:Ljava/lang/Object;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->miviRenderWrapper:Ljava/lang/Object;

    if-eqz v0, :cond_0

    return-void

    .line 444
    :cond_0
    const-class v0, Lcom/prometheus/camera/natural15pro/NaturalHook;

    monitor-enter v0

    .line 445
    :try_start_0
    sget-object v1, Lcom/prometheus/camera/natural15pro/NaturalHook;->tagHelper:Ljava/lang/Class;

    if-eqz v1, :cond_1

    sget-object v1, Lcom/prometheus/camera/natural15pro/NaturalHook;->renderTypeWrapper:Ljava/lang/Object;

    if-eqz v1, :cond_1

    sget-object v1, Lcom/prometheus/camera/natural15pro/NaturalHook;->miviRenderWrapper:Ljava/lang/Object;

    if-eqz v1, :cond_1

    .line 447
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    return-void

    :cond_1
    :try_start_1
    const-string v1, "ga.A0"

    .line 450
    sget-object v2, Lcom/prometheus/camera/natural15pro/NaturalHook;->appLoader:Ljava/lang/ClassLoader;

    invoke-static {v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v1

    const-string v2, "c"

    .line 451
    invoke-static {v1, v2}, Lde/robv/android/xposed/XposedHelpers;->getStaticObjectField(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    sput-object v2, Lcom/prometheus/camera/natural15pro/NaturalHook;->renderTypeWrapper:Ljava/lang/Object;

    const-string v2, "d"

    .line 452
    invoke-static {v1, v2}, Lde/robv/android/xposed/XposedHelpers;->getStaticObjectField(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    sput-object v1, Lcom/prometheus/camera/natural15pro/NaturalHook;->miviRenderWrapper:Ljava/lang/Object;

    const-string v1, "ga.E0"

    .line 453
    sget-object v2, Lcom/prometheus/camera/natural15pro/NaturalHook;->appLoader:Ljava/lang/ClassLoader;

    invoke-static {v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v1

    sput-object v1, Lcom/prometheus/camera/natural15pro/NaturalHook;->tagHelper:Ljava/lang/Class;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v1

    :try_start_2
    const-string v2, "MIVI tag wrapper"

    .line 455
    invoke-static {v2, v1}, Lcom/prometheus/camera/natural15pro/NaturalHook;->logFailure(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 457
    :goto_0
    monitor-exit v0

    return-void

    :catchall_1
    move-exception v1

    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    throw v1
.end method

.method public static install(Ljava/lang/ClassLoader;)V
    .locals 9

    if-nez p0, :cond_0

    return-void

    :cond_0
    const-string v0, "entry"

    .line 68
    invoke-static {v0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->log(Ljava/lang/String;)V

    .line 69
    sget-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->INSTALLED:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-nez v0, :cond_1

    return-void

    .line 72
    :cond_1
    sput-object p0, Lcom/prometheus/camera/natural15pro/NaturalHook;->appLoader:Ljava/lang/ClassLoader;

    const/4 v0, 0x2

    const/4 v3, 0x3

    const/4 v4, 0x0

    .line 75
    :try_start_0
    const-class v5, Landroid/hardware/camera2/CaptureRequest$Builder;

    const-string v6, "set"

    new-array v7, v3, [Ljava/lang/Object;

    const-class v8, Landroid/hardware/camera2/CaptureRequest$Key;

    aput-object v8, v7, v1

    const-class v8, Ljava/lang/Object;

    aput-object v8, v7, v2

    new-instance v8, Lcom/prometheus/camera/natural15pro/NaturalHook$BuilderSetHook;

    invoke-direct {v8, v4}, Lcom/prometheus/camera/natural15pro/NaturalHook$BuilderSetHook;-><init>(Lcom/prometheus/camera/natural15pro/NaturalHook$1;)V

    aput-object v8, v7, v0

    invoke-static {v5, v6, v7}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v5

    const-string v6, "builder set hook unavailable"

    .line 82
    invoke-static {v6}, Lcom/prometheus/camera/natural15pro/NaturalHook;->log(Ljava/lang/String;)V

    .line 83
    invoke-static {v5}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    :goto_0
    :try_start_1
    const-string v5, "j9.m0"

    const-string v6, "t0"

    new-array v7, v3, [Ljava/lang/Object;

    .line 87
    const-class v8, Landroid/hardware/camera2/CaptureRequest$Builder;

    aput-object v8, v7, v1

    const-class v8, [B

    aput-object v8, v7, v2

    new-instance v8, Lcom/prometheus/camera/natural15pro/NaturalHook$MiviPayloadHook;

    invoke-direct {v8, v4}, Lcom/prometheus/camera/natural15pro/NaturalHook$MiviPayloadHook;-><init>(Lcom/prometheus/camera/natural15pro/NaturalHook$1;)V

    aput-object v8, v7, v0

    invoke-static {v5, p0, v6, v7}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception v5

    const-string v6, "j9.m0.t0 hook unavailable"

    .line 95
    invoke-static {v6}, Lcom/prometheus/camera/natural15pro/NaturalHook;->log(Ljava/lang/String;)V

    .line 96
    invoke-static {v5}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    :goto_1
    :try_start_2
    const-string v5, "j9.D0"

    const-string v6, "H1"

    new-array v3, v3, [Ljava/lang/Object;

    .line 100
    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v7, v3, v1

    const-class v7, Landroid/hardware/camera2/CaptureRequest$Builder;

    aput-object v7, v3, v2

    new-instance v7, Lcom/prometheus/camera/natural15pro/NaturalHook$H1Hook;

    invoke-direct {v7, v4}, Lcom/prometheus/camera/natural15pro/NaturalHook$H1Hook;-><init>(Lcom/prometheus/camera/natural15pro/NaturalHook$1;)V

    aput-object v7, v3, v0

    invoke-static {v5, p0, v6, v3}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    goto :goto_2

    :catchall_2
    move-exception v0

    const-string v3, "j9.D0.H1 hook unavailable"

    .line 108
    invoke-static {v3}, Lcom/prometheus/camera/natural15pro/NaturalHook;->log(Ljava/lang/String;)V

    .line 109
    invoke-static {v0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    :goto_2
    :try_start_3
    const-string v0, "com.xiaomi.camera.mivi.filter.a"

    const-string v3, "run"

    new-array v2, v2, [Ljava/lang/Object;

    .line 113
    new-instance v5, Lcom/prometheus/camera/natural15pro/NaturalHook$LutPublisherHook;

    invoke-direct {v5, v4}, Lcom/prometheus/camera/natural15pro/NaturalHook$LutPublisherHook;-><init>(Lcom/prometheus/camera/natural15pro/NaturalHook$1;)V

    aput-object v5, v2, v1

    invoke-static {v0, p0, v3, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_3

    goto :goto_3

    :catchall_3
    move-exception p0

    const-string v0, "MIVI LUT publisher hook unavailable"

    .line 119
    invoke-static {v0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->log(Ljava/lang/String;)V

    .line 120
    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    :goto_3
    const-string p0, "installed; photo-module vivid requests only"

    .line 123
    invoke-static {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->log(Ljava/lang/String;)V

    return-void
.end method

.method private static isVivid(Ljava/lang/Object;)Z
    .locals 3

    .line 479
    instance-of v0, p0, Ljava/lang/Number;

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_1

    .line 480
    check-cast p0, Ljava/lang/Number;

    invoke-virtual {p0}, Ljava/lang/Number;->intValue()I

    move-result p0

    if-nez p0, :cond_0

    goto :goto_0

    :cond_0
    move v1, v2

    :goto_0
    return v1

    .line 482
    :cond_1
    instance-of v0, p0, [B

    if-eqz v0, :cond_3

    .line 483
    check-cast p0, [B

    .line 484
    array-length v0, p0

    if-lez v0, :cond_2

    aget-byte p0, p0, v2

    and-int/lit16 p0, p0, 0xff

    if-nez p0, :cond_2

    goto :goto_1

    :cond_2
    move v1, v2

    :goto_1
    return v1

    :cond_3
    return v2
.end method

.method private static isVividBuilder(Landroid/hardware/camera2/CaptureRequest$Builder;)Z
    .locals 3

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return v0

    .line 422
    :cond_0
    sget-object v1, Lcom/prometheus/camera/natural15pro/NaturalHook;->VIVID_BUILDERS:Ljava/util/Map;

    monitor-enter v1

    .line 423
    :try_start_0
    invoke-interface {v1, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Boolean;

    if-eqz v2, :cond_1

    .line 425
    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p0

    monitor-exit v1

    return p0

    .line 427
    :cond_1
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 428
    sget-object v1, Lcom/prometheus/camera/natural15pro/NaturalHook;->styleKey:Landroid/hardware/camera2/CaptureRequest$Key;

    if-nez v1, :cond_2

    return v0

    .line 433
    :cond_2
    :try_start_1
    invoke-virtual {p0, v1}, Landroid/hardware/camera2/CaptureRequest$Builder;->get(Landroid/hardware/camera2/CaptureRequest$Key;)Ljava/lang/Object;

    move-result-object p0

    invoke-static {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->isVivid(Ljava/lang/Object;)Z

    move-result p0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    return p0

    :catchall_0
    return v0

    :catchall_1
    move-exception p0

    .line 427
    :try_start_2
    monitor-exit v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    throw p0
.end method

.method private static log(Ljava/lang/String;)V
    .locals 2

    const-string v0, "PhoenixNatural15Pro"

    .line 574
    invoke-static {v0, p0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 575
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "PhoenixNatural15Pro: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    return-void
.end method

.method private static logFailure(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 3

    .line 565
    sget-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->LOG_FAIL:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 566
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p0, " failed"

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->log(Ljava/lang/String;)V

    if-eqz p1, :cond_0

    .line 568
    invoke-static {p1}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/Throwable;)V

    :cond_0
    return-void
.end method

.method private static lutPathOf([B)Ljava/lang/String;
    .locals 3

    const-string v0, ""

    .line 371
    :try_start_0
    new-instance v1, Ljava/lang/String;

    sget-object v2, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v1, p0, v2}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    const-string p0, "\u0000"

    .line 372
    invoke-virtual {v1, p0, v0}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    .line 373
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string p0, "lutPath"

    invoke-virtual {v1, p0, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p0

    :catchall_0
    return-object v0
.end method

.method private static normalizeScript(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    if-nez p0, :cond_0

    const-string p0, ""

    return-object p0

    :cond_0
    const-string v0, "@+"

    const-string v1, "@"

    .line 343
    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    .line 344
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_1

    return-object v1

    .line 347
    :cond_1
    invoke-virtual {p0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 348
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 350
    :cond_2
    invoke-virtual {p0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    .line 351
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    :cond_3
    return-object p0
.end method

.method private static preview([B)Ljava/lang/String;
    .locals 3

    .line 413
    new-instance v0, Ljava/lang/String;

    sget-object v1, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v0, p0, v1}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    const-string p0, "\u0000"

    const-string v1, ""

    .line 414
    invoke-virtual {v0, p0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    .line 415
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/16 v1, 0x258

    if-gt v0, v1, :cond_0

    goto :goto_0

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v2, 0x0

    invoke-virtual {p0, v2, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p0, "..."

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    :goto_0
    return-object p0
.end method

.method private static publishLut(Ljava/lang/String;)V
    .locals 12

    const-string v0, "writeLutToDir"

    const-string v1, "writeLutToDir path="

    .line 538
    sget-object v2, Lcom/prometheus/camera/natural15pro/NaturalHook;->lutBytes:[B

    if-eqz v2, :cond_3

    if-eqz p0, :cond_3

    .line 539
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_0

    goto :goto_0

    .line 542
    :cond_0
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    .line 543
    sget-object v5, Lcom/prometheus/camera/natural15pro/NaturalHook;->LUT_WRITTEN_AT:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v5}, Ljava/util/concurrent/atomic/AtomicLong;->get()J

    move-result-wide v6

    sub-long v8, v3, v6

    const-wide/16 v10, 0x1388

    cmp-long v8, v8, v10

    if-gez v8, :cond_1

    return-void

    .line 547
    :cond_1
    invoke-virtual {v5, v6, v7, v3, v4}, Ljava/util/concurrent/atomic/AtomicLong;->compareAndSet(JJ)Z

    move-result v3

    if-nez v3, :cond_2

    return-void

    :cond_2
    :try_start_0
    const-string v3, "com.xiaomi.camera.mivi.filter.MIVILutSaver"

    .line 551
    sget-object v4, Lcom/prometheus/camera/natural15pro/NaturalHook;->appLoader:Ljava/lang/ClassLoader;

    invoke-static {v3, v4}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v3

    const/4 v4, 0x3

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object p0, v4, v5

    const-string v6, "lut_cvstyle_natural.png"

    const/4 v7, 0x1

    aput-object v6, v4, v7

    const/4 v6, 0x2

    aput-object v2, v4, v6

    .line 553
    invoke-static {v3, v0, v4}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    .line 555
    sget-object v4, Lcom/prometheus/camera/natural15pro/NaturalHook;->LOG_PUBLISH:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v4, v5, v7}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 556
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v4, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p0, " bytes="

    invoke-virtual {v4, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    array-length p0, v2

    invoke-virtual {v4, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p0, " result="

    invoke-virtual {v4, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p0

    .line 560
    invoke-static {v0, p0}, Lcom/prometheus/camera/natural15pro/NaturalHook;->logFailure(Ljava/lang/String;Ljava/lang/Throwable;)V

    :cond_3
    :goto_0
    return-void
.end method

.method private static readTag(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2

    .line 461
    sget-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->tagHelper:Ljava/lang/Class;

    if-eqz v0, :cond_1

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    const v1, 0xbabe

    .line 466
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    filled-new-array {p0, p1, v1}, [Ljava/lang/Object;

    move-result-object p0

    const-string p1, "j"

    .line 465
    invoke-static {v0, p1, p0}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :cond_1
    :goto_0
    const/4 p0, 0x0

    return-object p0
.end method

.method private static rewritePayload([B)[B
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 295
    new-instance v0, Ljava/lang/String;

    sget-object v1, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-direct {v0, p0, v1}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    const-string p0, "\u0000"

    const-string v1, ""

    .line 296
    invoke-virtual {v0, p0, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p0

    .line 297
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    .line 298
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    const/4 v2, 0x0

    if-eqz v0, :cond_0

    return-object v2

    .line 302
    :cond_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string p0, "lutPath"

    .line 303
    invoke-virtual {v0, p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    .line 304
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result p0

    if-eqz p0, :cond_1

    return-object v2

    :cond_1
    const-string p0, "renderType"

    const/4 v3, 0x0

    .line 307
    invoke-virtual {v0, p0, v3}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result p0

    and-int/lit8 p0, p0, 0x20

    if-eqz p0, :cond_2

    return-object v2

    :cond_2
    const-string p0, "generalFilterId"

    const/4 v4, -0x1

    .line 311
    invoke-virtual {v0, p0, v4}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result p0

    const/4 v4, 0x3

    if-eq p0, v4, :cond_3

    return-object v2

    .line 315
    :cond_3
    new-instance p0, Lorg/json/JSONObject;

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string v0, "filterScript"

    .line 316
    invoke-virtual {p0, v0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v5, "CubeLutEffect;"

    .line 317
    invoke-static {v4, v5}, Lcom/prometheus/camera/natural15pro/NaturalHook;->countOf(Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    const/4 v6, 0x1

    if-le v5, v6, :cond_4

    return-object v2

    :cond_4
    const-string v2, "@CvEffect;[^@]*"

    .line 321
    invoke-virtual {v4, v2, v1}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-nez v5, :cond_5

    .line 323
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v4, "@CubeLutEffect;cube_strength=1.0;lut_type=0;@"

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 325
    :cond_5
    invoke-static {v1}, Lcom/prometheus/camera/natural15pro/NaturalHook;->normalizeScript(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v0, "cvFilterCandyParams"

    .line 326
    invoke-virtual {p0, v0}, Lorg/json/JSONObject;->remove(Ljava/lang/String;)Ljava/lang/Object;

    const-string v0, "cvFilterLutName"

    .line 327
    invoke-virtual {p0, v0}, Lorg/json/JSONObject;->remove(Ljava/lang/String;)Ljava/lang/Object;

    .line 328
    new-instance v0, Lorg/json/JSONArray;

    invoke-direct {v0}, Lorg/json/JSONArray;-><init>()V

    const-string v1, "lut_cvstyle_natural"

    .line 329
    invoke-virtual {v0, v1}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    const-string v1, "lutNames"

    .line 330
    invoke-virtual {p0, v1, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 332
    invoke-virtual {p0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p0

    sget-object v0, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {p0, v0}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object p0

    .line 333
    array-length v0, p0

    add-int/2addr v0, v6

    new-array v0, v0, [B

    .line 334
    array-length v1, p0

    invoke-static {p0, v3, v0, v3, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 335
    array-length p0, p0

    aput-byte v3, v0, p0

    return-object v0
.end method

.method private static setTag(Landroid/hardware/camera2/CaptureRequest$Builder;Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 2

    .line 471
    sget-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->tagHelper:Ljava/lang/Class;

    if-eqz v0, :cond_1

    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    const-string v1, "f"

    .line 475
    filled-new-array {p0, p1, p2}, [Ljava/lang/Object;

    move-result-object p0

    invoke-static {v0, v1, p0}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    :cond_1
    :goto_0
    return-void
.end method

.method private static syntheticPayload()[B
    .locals 5

    .line 380
    sget-object v0, Lcom/prometheus/camera/natural15pro/NaturalHook;->fallbackPayload:[B

    if-eqz v0, :cond_0

    return-object v0

    .line 384
    :cond_0
    const-class v0, Lcom/prometheus/camera/natural15pro/NaturalHook;

    monitor-enter v0

    .line 385
    :try_start_0
    sget-object v1, Lcom/prometheus/camera/natural15pro/NaturalHook;->fallbackPayload:[B

    if-eqz v1, :cond_1

    .line 386
    sget-object v1, Lcom/prometheus/camera/natural15pro/NaturalHook;->fallbackPayload:[B

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    return-object v1

    .line 389
    :cond_1
    :try_start_1
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    const-string v2, "version"

    const-wide v3, 0x400804189374bc6aL    # 3.002

    .line 390
    invoke-virtual {v1, v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;D)Lorg/json/JSONObject;

    const-string v2, "renderType"

    const/4 v3, 0x1

    .line 391
    invoke-virtual {v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v2, "lutPath"

    const-string v4, "/data/vendor/camera/"

    .line 392
    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v2, "generalFilterId"

    const/4 v4, 0x3

    .line 393
    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v2, "filterScript"

    const-string v4, "@CubeLutEffect;cube_strength=1.0;lut_type=0;@"

    .line 394
    invoke-virtual {v1, v2, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 395
    new-instance v2, Lorg/json/JSONArray;

    invoke-direct {v2}, Lorg/json/JSONArray;-><init>()V

    const-string v4, "lut_cvstyle_natural"

    .line 396
    invoke-virtual {v2, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    const-string v4, "lutNames"

    .line 397
    invoke-virtual {v1, v4, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 398
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Ljava/nio/charset/StandardCharsets;->UTF_8:Ljava/nio/charset/Charset;

    .line 399
    invoke-virtual {v1, v2}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v1

    .line 400
    array-length v2, v1

    add-int/2addr v2, v3

    new-array v2, v2, [B

    .line 401
    array-length v3, v1

    const/4 v4, 0x0

    invoke-static {v1, v4, v2, v4, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 402
    array-length v1, v1

    aput-byte v4, v2, v1

    .line 403
    sput-object v2, Lcom/prometheus/camera/natural15pro/NaturalHook;->fallbackPayload:[B
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 404
    :try_start_2
    monitor-exit v0

    return-object v2

    :catchall_0
    move-exception v1

    const-string v2, "synthetic payload"

    .line 406
    invoke-static {v2, v1}, Lcom/prometheus/camera/natural15pro/NaturalHook;->logFailure(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 407
    monitor-exit v0

    const/4 v0, 0x0

    return-object v0

    :catchall_1
    move-exception v1

    .line 409
    monitor-exit v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    throw v1
.end method
