.class public Lcom/prometheus/camera/rev/EvPanelGuard;
.super Ljava/lang/Object;
.source "EvPanelGuard.java"

# interfaces
.implements Lde/robv/android/xposed/IXposedHookLoadPackage;


# static fields
.field private static final ALSO_GUARD_BACKSTACK:Z = false

.field private static final BLOCK_BACK_KEY:Z = false

.field private static final BLOCK_ONLY_SYNTHETIC:Z = true

.field private static final BLOCK_TAP_OUTSIDE:Z = false

.field private static final BLOCK_WINDOW_MS:J = 0x0L

.field private static final DRY_RUN:Z = false

.field private static final ENTRANCE_FACTORY:Ljava/lang/String; = "com.android.camera.features.mode.capture.h0"

.field private static final EV_ENTRANCE_KEY:I = 0x5

.field private static final EV_FIX_MODES:[I

.field private static final FORCE_DEVICE_EV_FLAG:Z = false

.field private static final FORCE_EV_ITEMS:Z = true

.field private static final FORCE_IS_SUPPORT_MODE:Z = true

.field private static final FORCE_PORTRAIT_EV_TIP:Z = true

.field private static final GUARD_ENABLED:Z = true

.field private static final GUARD_MODES:[I

.field private static final KEEP_DUAL_CAMERA:Z = false

.field private static final KEEP_POPUP_TIPS:Z = false

.field private static final PORTRAIT_MODULE:I = 0xab

.field private static final PORTRAIT_UI_CLASSES:[Ljava/lang/String;

.field private static final PROBE_BACKSTACK:Z = false

.field private static final PROBE_DEVICE_FLAG:Z = true

.field private static final PROBE_MODE_CACHE:Z = false

.field private static final STATE_TTL_MS:J = 0x927c0L

.field private static final TAG:Ljava/lang/String; = "IshtarEvGuard"

.field private static final TARGET_PKG:Ljava/lang/String; = "com.android.camera"

.field private static final VERSION:Ljava/lang/String; = "1.3"

.field private static volatile evClassLoader:Ljava/lang/ClassLoader;

.field private static volatile evFixCount:I

.field private static volatile lastZ1:Z

.field private static volatile modeCache:I

.field private static volatile modeCacheAt:J

.field private static volatile panelMode:I

.field private static volatile panelOpen:Z

.field private static volatile panelOpenAt:J

.field private static volatile panelRef:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference<",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field private static volatile suppressCount:I


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .line 136
    const/16 v0, 0xad

    const/16 v1, 0xaf

    const/16 v2, 0xab

    filled-new-array {v0, v1, v2}, [I

    move-result-object v3

    sput-object v3, Lcom/prometheus/camera/rev/EvPanelGuard;->GUARD_MODES:[I

    .line 268
    filled-new-array {v0, v1, v2}, [I

    move-result-object v0

    sput-object v0, Lcom/prometheus/camera/rev/EvPanelGuard;->EV_FIX_MODES:[I

    .line 348
    const-string v0, "com.android.camera.features.mode.portrait.l"

    const-string v1, "com.android.camera.features.mode.portrait.m"

    const-string v2, "com.android.camera.features.mode.portrait.d"

    filled-new-array {v2, v0, v1}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/prometheus/camera/rev/EvPanelGuard;->PORTRAIT_UI_CLASSES:[Ljava/lang/String;

    .line 359
    const/4 v0, 0x0

    sput-boolean v0, Lcom/prometheus/camera/rev/EvPanelGuard;->panelOpen:Z

    .line 360
    const/4 v1, -0x1

    sput v1, Lcom/prometheus/camera/rev/EvPanelGuard;->panelMode:I

    .line 361
    const-wide/16 v2, 0x0

    sput-wide v2, Lcom/prometheus/camera/rev/EvPanelGuard;->panelOpenAt:J

    .line 362
    const/4 v4, 0x0

    sput-object v4, Lcom/prometheus/camera/rev/EvPanelGuard;->panelRef:Ljava/lang/ref/WeakReference;

    .line 363
    sput v0, Lcom/prometheus/camera/rev/EvPanelGuard;->suppressCount:I

    .line 366
    sput v1, Lcom/prometheus/camera/rev/EvPanelGuard;->modeCache:I

    .line 367
    sput-wide v2, Lcom/prometheus/camera/rev/EvPanelGuard;->modeCacheAt:J

    .line 370
    sput v0, Lcom/prometheus/camera/rev/EvPanelGuard;->evFixCount:I

    .line 372
    const/4 v0, 0x1

    sput-boolean v0, Lcom/prometheus/camera/rev/EvPanelGuard;->lastZ1:Z

    .line 374
    sput-object v4, Lcom/prometheus/camera/rev/EvPanelGuard;->evClassLoader:Ljava/lang/ClassLoader;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 94
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()I
    .locals 1

    .line 94
    sget v0, Lcom/prometheus/camera/rev/EvPanelGuard;->modeCache:I

    return v0
.end method

.method static synthetic access$002(I)I
    .locals 0

    .line 94
    sput p0, Lcom/prometheus/camera/rev/EvPanelGuard;->modeCache:I

    return p0
.end method

.method static synthetic access$1000(Lcom/prometheus/camera/rev/EvPanelGuard;Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 0

    .line 94
    invoke-direct {p0, p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->onPortraitEntranceBuilt(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V

    return-void
.end method

.method static synthetic access$102(J)J
    .locals 0

    .line 94
    sput-wide p0, Lcom/prometheus/camera/rev/EvPanelGuard;->modeCacheAt:J

    return-wide p0
.end method

.method static synthetic access$1100(Lcom/prometheus/camera/rev/EvPanelGuard;Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 0

    .line 94
    invoke-direct {p0, p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->onDispatchKeyEvent(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V

    return-void
.end method

.method static synthetic access$1200(Lcom/prometheus/camera/rev/EvPanelGuard;Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 0

    .line 94
    invoke-direct {p0, p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->onBackStackDispatch(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V

    return-void
.end method

.method static synthetic access$200(Lcom/prometheus/camera/rev/EvPanelGuard;Ljava/lang/Object;)V
    .locals 0

    .line 94
    invoke-direct {p0, p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->onPanelOpen(Ljava/lang/Object;)V

    return-void
.end method

.method static synthetic access$300(Ljava/lang/String;)V
    .locals 0

    .line 94
    invoke-static {p0}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$400(Lcom/prometheus/camera/rev/EvPanelGuard;)V
    .locals 0

    .line 94
    invoke-direct {p0}, Lcom/prometheus/camera/rev/EvPanelGuard;->onPanelClose()V

    return-void
.end method

.method static synthetic access$500(Lcom/prometheus/camera/rev/EvPanelGuard;Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 0

    .line 94
    invoke-direct {p0, p1, p2}, Lcom/prometheus/camera/rev/EvPanelGuard;->onConfigFragmentData(Ljava/lang/Object;Ljava/lang/Object;)V

    return-void
.end method

.method static synthetic access$600(I)Z
    .locals 0

    .line 94
    invoke-static {p0}, Lcom/prometheus/camera/rev/EvPanelGuard;->evFixModeMatch(I)Z

    move-result p0

    return p0
.end method

.method static synthetic access$700()Ljava/lang/ClassLoader;
    .locals 1

    .line 94
    sget-object v0, Lcom/prometheus/camera/rev/EvPanelGuard;->evClassLoader:Ljava/lang/ClassLoader;

    return-object v0
.end method

.method static synthetic access$800(Lcom/prometheus/camera/rev/EvPanelGuard;Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 0

    .line 94
    invoke-direct {p0, p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->onEvItemsBuilt(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V

    return-void
.end method

.method static synthetic access$900()Z
    .locals 1

    .line 94
    sget-boolean v0, Lcom/prometheus/camera/rev/EvPanelGuard;->lastZ1:Z

    return v0
.end method

.method static synthetic access$902(Z)Z
    .locals 0

    .line 94
    sput-boolean p0, Lcom/prometheus/camera/rev/EvPanelGuard;->lastZ1:Z

    return p0
.end method

.method private static evFixModeMatch(I)Z
    .locals 5

    .line 966
    sget-object v0, Lcom/prometheus/camera/rev/EvPanelGuard;->EV_FIX_MODES:[I

    array-length v1, v0

    const/4 v2, 0x0

    move v3, v2

    :goto_0
    if-ge v3, v1, :cond_1

    aget v4, v0, v3

    .line 967
    if-ne v4, p0, :cond_0

    .line 968
    const/4 p0, 0x1

    return p0

    .line 966
    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 971
    :cond_1
    return v2
.end method

.method private static evModesToStr()Ljava/lang/String;
    .locals 6

    .line 975
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 976
    sget-object v1, Lcom/prometheus/camera/rev/EvPanelGuard;->EV_FIX_MODES:[I

    array-length v2, v1

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_1

    aget v4, v1, v3

    .line 977
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v5

    if-lez v5, :cond_0

    .line 978
    const/16 v5, 0x2c

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 980
    :cond_0
    const-string v5, "0x"

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-static {v4}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 976
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 982
    :cond_1
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private hookBackStack(Ljava/lang/ClassLoader;)V
    .locals 0

    .line 1142
    return-void
.end method

.method private hookConfigFragmentData(Ljava/lang/ClassLoader;)V
    .locals 0

    .line 543
    const-string p1, "\u6392\u9664\u8868\u672a\u6539\u52a8\uff08KEEP_DUAL_CAMERA=false \u4e14 KEEP_POPUP_TIPS=false\uff09"

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 544
    return-void
.end method

.method private hookDeviceFlag(Ljava/lang/ClassLoader;)V
    .locals 3

    .line 798
    :try_start_0
    const-string v0, "Je.c"

    const-string v1, "Z1"

    new-instance v2, Lcom/prometheus/camera/rev/EvPanelGuard$7;

    invoke-direct {v2, p0}, Lcom/prometheus/camera/rev/EvPanelGuard$7;-><init>(Lcom/prometheus/camera/rev/EvPanelGuard;)V

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p1, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 822
    const-string p1, "\u5df2\u6302\u8f7d\uff1aJe.c#Z1\uff08\u53ea\u8bfb\u53d6\u8bc1\u8bbe\u5907\u80fd\u529b\u5f00\u5173\uff09"

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 828
    goto :goto_0

    .line 826
    :catchall_0
    move-exception p1

    .line 827
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "!! \u6302\u8f7d\u5931\u8d25\uff08Je.c#Z1\uff09\uff1a"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 829
    :goto_0
    return-void
.end method

.method private hookDispatchKeyEvent(Ljava/lang/ClassLoader;)V
    .locals 4

    .line 1061
    :try_start_0
    const-string v0, "com.android.camera.Camera"

    const-string v1, "dispatchKeyEvent"

    const-class v2, Landroid/view/KeyEvent;

    new-instance v3, Lcom/prometheus/camera/rev/EvPanelGuard$9;

    invoke-direct {v3, p0}, Lcom/prometheus/camera/rev/EvPanelGuard$9;-><init>(Lcom/prometheus/camera/rev/EvPanelGuard;)V

    filled-new-array {v2, v3}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p1, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 1072
    const-string p1, "\u5df2\u6302\u8f7d\uff1aCamera#dispatchKeyEvent\uff08\u4e3b\u9632\u7ebf\uff09"

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1075
    goto :goto_0

    .line 1073
    :catchall_0
    move-exception p1

    .line 1074
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "!! \u6302\u8f7d\u5931\u8d25\uff08Camera#dispatchKeyEvent\uff09\uff1a"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 1076
    :goto_0
    return-void
.end method

.method private hookEvComponent(Ljava/lang/ClassLoader;)V
    .locals 6

    .line 643
    const-string v0, "r2.D0"

    :try_start_0
    const-string v1, "isSupportMode"

    sget-object v2, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    new-instance v3, Lcom/prometheus/camera/rev/EvPanelGuard$5;

    invoke-direct {v3, p0}, Lcom/prometheus/camera/rev/EvPanelGuard$5;-><init>(Lcom/prometheus/camera/rev/EvPanelGuard;)V

    filled-new-array {v2, v3}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p1, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 685
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u5df2\u6302\u8f7d\uff1ar2.D0#isSupportMode\uff08\u5bf9 "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {}, Lcom/prometheus/camera/rev/EvPanelGuard;->evModesToStr()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " \u5f3a\u5236 true\uff09"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 688
    goto :goto_0

    .line 686
    :catchall_0
    move-exception v1

    .line 687
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "!! \u6302\u8f7d\u5931\u8d25\uff08r2.D0#isSupportMode\uff09\uff1a"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 694
    :goto_0
    :try_start_1
    const-string v1, "v"

    sget-object v2, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const-string v4, "j9.e"

    new-instance v5, Lcom/prometheus/camera/rev/EvPanelGuard$6;

    invoke-direct {v5, p0}, Lcom/prometheus/camera/rev/EvPanelGuard$6;-><init>(Lcom/prometheus/camera/rev/EvPanelGuard;)V

    filled-new-array {v2, v3, v4, v5}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p1, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 706
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "\u5df2\u6302\u8f7d\uff1ar2.D0#v\uff08\u7a7a\u8868\u5219\u91cd\u5efa\uff0c\u6a21\u5f0f "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {}, Lcom/prometheus/camera/rev/EvPanelGuard;->evModesToStr()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "\uff09"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 709
    goto :goto_1

    .line 707
    :catchall_1
    move-exception p1

    .line 708
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "!! \u6302\u8f7d\u5931\u8d25\uff08r2.D0#v\uff09\uff1a"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 711
    :goto_1
    return-void
.end method

.method private hookModeCache(Ljava/lang/ClassLoader;)V
    .locals 6

    .line 464
    :try_start_0
    const-string v0, "j9.m0"

    const-string v1, "k1"

    const-string v2, "android.hardware.camera2.CaptureRequest$Builder"

    const-string v3, "j9.e"

    const-string v4, "j9.i0"

    new-instance v5, Lcom/prometheus/camera/rev/EvPanelGuard$1;

    invoke-direct {v5, p0}, Lcom/prometheus/camera/rev/EvPanelGuard$1;-><init>(Lcom/prometheus/camera/rev/EvPanelGuard;)V

    filled-new-array {v2, v3, v4, v5}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p1, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 488
    const-string p1, "\u5df2\u6302\u8f7d\uff1aj9.m0#k1\uff08\u5f53\u524d\u6a21\u5f0f\u7f13\u5b58 j9.i0.H3\uff09"

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 491
    goto :goto_0

    .line 489
    :catchall_0
    move-exception p1

    .line 490
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "!! \u6302\u8f7d\u5931\u8d25\uff08j9.m0#k1\uff09\uff1a"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 492
    :goto_0
    return-void
.end method

.method private hookPanelState(Ljava/lang/ClassLoader;)V
    .locals 5

    .line 499
    const-string v0, "P4.t"

    :try_start_0
    const-string v1, "onViewCreated"

    const-class v2, Landroid/view/View;

    const-class v3, Landroid/os/Bundle;

    new-instance v4, Lcom/prometheus/camera/rev/EvPanelGuard$2;

    invoke-direct {v4, p0}, Lcom/prometheus/camera/rev/EvPanelGuard$2;-><init>(Lcom/prometheus/camera/rev/EvPanelGuard;)V

    filled-new-array {v2, v3, v4}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p1, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 511
    const-string v1, "\u5df2\u6302\u8f7d\uff1aP4.t#onViewCreated\uff08\u9762\u677f\u6253\u5f00\uff09"

    invoke-static {v1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 514
    goto :goto_0

    .line 512
    :catchall_0
    move-exception v1

    .line 513
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "!! \u6302\u8f7d\u5931\u8d25\uff08P4.t#onViewCreated\uff09\uff1a"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 517
    :goto_0
    :try_start_1
    const-string v1, "onDetach"

    new-instance v2, Lcom/prometheus/camera/rev/EvPanelGuard$3;

    invoke-direct {v2, p0}, Lcom/prometheus/camera/rev/EvPanelGuard$3;-><init>(Lcom/prometheus/camera/rev/EvPanelGuard;)V

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v0, p1, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 527
    const-string p1, "\u5df2\u6302\u8f7d\uff1aP4.t#onDetach\uff08\u9762\u677f\u5173\u95ed\uff09"

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 530
    goto :goto_1

    .line 528
    :catchall_1
    move-exception p1

    .line 529
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "!! \u6302\u8f7d\u5931\u8d25\uff08P4.t#onDetach\uff09\uff1a"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 531
    :goto_1
    return-void
.end method

.method private hookPortraitEvEntrance(Ljava/lang/ClassLoader;)V
    .locals 7

    .line 850
    sget-object v0, Lcom/prometheus/camera/rev/EvPanelGuard;->PORTRAIT_UI_CLASSES:[Ljava/lang/String;

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_0

    aget-object v3, v0, v2

    .line 852
    :try_start_0
    const-string v4, "f"

    new-instance v5, Lcom/prometheus/camera/rev/EvPanelGuard$8;

    invoke-direct {v5, p0}, Lcom/prometheus/camera/rev/EvPanelGuard$8;-><init>(Lcom/prometheus/camera/rev/EvPanelGuard;)V

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v3, p1, v4, v5}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 862
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "\u5df2\u6302\u8f7d\uff1a"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "#f()\uff08\u4eba\u50cf EV \u9762\u677f\u5165\u53e3\u8865\u5168\uff09"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 865
    goto :goto_1

    .line 863
    :catchall_0
    move-exception v4

    .line 864
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "\u00b7 \u8df3\u8fc7 "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v5, "#f()\uff1a"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 850
    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 867
    :cond_0
    return-void
.end method

.method private static isSynthetic(Landroid/view/KeyEvent;)Z
    .locals 6

    .line 1251
    invoke-virtual {p0}, Landroid/view/KeyEvent;->getDeviceId()I

    move-result v0

    const/4 v1, 0x1

    if-gez v0, :cond_0

    .line 1252
    return v1

    .line 1254
    :cond_0
    invoke-virtual {p0}, Landroid/view/KeyEvent;->getEventTime()J

    move-result-wide v2

    const-wide v4, 0xe8d4a51000L

    cmp-long p0, v2, v4

    if-lez p0, :cond_1

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method private static liveModuleIndex(Ljava/lang/Object;)I
    .locals 3

    .line 1227
    if-eqz p0, :cond_1

    .line 1229
    :try_start_0
    const-string v0, "Kq"

    const/4 v1, 0x0

    new-array v2, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v2}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .line 1230
    if-eqz p0, :cond_0

    .line 1231
    const-string v0, "o"

    invoke-static {p0, v0}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    .line 1232
    if-eqz p0, :cond_0

    .line 1233
    const-string v0, "getModuleIndex"

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {p0, v0, v1}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .line 1234
    instance-of v0, p0, Ljava/lang/Integer;

    if-eqz v0, :cond_0

    move-object v0, p0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    if-ltz v0, :cond_0

    .line 1235
    check-cast p0, Ljava/lang/Integer;

    invoke-virtual {p0}, Ljava/lang/Integer;->intValue()I

    move-result p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return p0

    .line 1241
    :cond_0
    goto :goto_0

    .line 1239
    :catchall_0
    move-exception p0

    .line 1243
    :cond_1
    :goto_0
    sget p0, Lcom/prometheus/camera/rev/EvPanelGuard;->modeCache:I

    return p0
.end method

.method private static log(Ljava/lang/String;)V
    .locals 2

    .line 1282
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "IshtarEvGuard: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lde/robv/android/xposed/XposedBridge;->log(Ljava/lang/String;)V

    .line 1283
    return-void
.end method

.method private static modeMatch(II)Z
    .locals 6

    .line 1259
    sget-object v0, Lcom/prometheus/camera/rev/EvPanelGuard;->GUARD_MODES:[I

    array-length v1, v0

    const/4 v2, 0x0

    move v3, v2

    :goto_0
    if-ge v3, v1, :cond_3

    aget v4, v0, v3

    .line 1260
    const/4 v5, 0x1

    if-nez v4, :cond_0

    .line 1261
    return v5

    .line 1263
    :cond_0
    if-eq v4, p0, :cond_2

    if-ne v4, p1, :cond_1

    goto :goto_1

    .line 1259
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 1264
    :cond_2
    :goto_1
    return v5

    .line 1267
    :cond_3
    return v2
.end method

.method private static modesToStr()Ljava/lang/String;
    .locals 6

    .line 1271
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 1272
    sget-object v1, Lcom/prometheus/camera/rev/EvPanelGuard;->GUARD_MODES:[I

    array-length v2, v1

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_1

    aget v4, v1, v3

    .line 1273
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v5

    if-lez v5, :cond_0

    .line 1274
    const/16 v5, 0x2c

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 1276
    :cond_0
    const-string v5, "0x"

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-static {v4}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1272
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 1278
    :cond_1
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->length()I

    move-result v1

    if-nez v1, :cond_2

    const-string v0, "none"

    goto :goto_1

    :cond_2
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_1
    return-object v0
.end method

.method private onBackStackDispatch(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 1

    .line 1162
    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v0, 0x0

    aget-object p1, p1, v0

    .line 1163
    instance-of v0, p1, Ljava/lang/Integer;

    if-nez v0, :cond_0

    .line 1164
    return-void

    .line 1166
    :cond_0
    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    .line 1173
    nop

    .line 1175
    return-void
.end method

.method private onConfigFragmentData(Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 4

    .line 567
    if-nez p2, :cond_0

    .line 568
    return-void

    .line 572
    :cond_0
    :try_start_0
    const-string v0, "a"

    invoke-static {p2, v0}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p2
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 576
    nop

    .line 577
    instance-of v0, p2, Ljava/util/Map;

    if-nez v0, :cond_1

    .line 578
    return-void

    .line 580
    :cond_1
    check-cast p2, Ljava/util/Map;

    .line 582
    nop

    .line 584
    :try_start_1
    const-string v0, "mCurrentMode"

    invoke-static {p1, v0}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 587
    goto :goto_0

    .line 585
    :catchall_0
    move-exception p1

    const/4 p1, -0x1

    .line 588
    :goto_0
    if-gez p1, :cond_2

    .line 589
    sget p1, Lcom/prometheus/camera/rev/EvPanelGuard;->modeCache:I

    .line 591
    :cond_2
    invoke-static {p1, p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->modeMatch(II)Z

    move-result v0

    if-nez v0, :cond_3

    .line 592
    return-void

    .line 595
    :cond_3
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 596
    invoke-interface {p2}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    const/16 v3, 0x2c

    if-eqz v2, :cond_4

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    .line 597
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 598
    goto :goto_1

    .line 600
    :cond_4
    nop

    .line 610
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 611
    invoke-interface {p2}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object p2

    invoke-interface {p2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p2

    :goto_2
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_5

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    .line 612
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 613
    goto :goto_2

    .line 614
    :cond_5
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "[\u6392\u9664\u8868] mode=0x"

    invoke-virtual {p2, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-static {p1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, "  ["

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, "] -> ["

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, "]"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    .line 616
    const-string p2, "  \u21d2 \u65e0\u53d8\u5316"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 614
    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 617
    return-void

    .line 573
    :catchall_1
    move-exception p1

    .line 574
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, "!! \u53d6 Z1/b.a \u5931\u8d25: "

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 575
    return-void
.end method

.method private onDispatchKeyEvent(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 1

    .line 1079
    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v0, 0x0

    aget-object p1, p1, v0

    .line 1080
    instance-of v0, p1, Landroid/view/KeyEvent;

    if-nez v0, :cond_0

    .line 1081
    return-void

    .line 1083
    :cond_0
    check-cast p1, Landroid/view/KeyEvent;

    .line 1085
    return-void
.end method

.method private onEvItemsBuilt(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 7

    .line 722
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    const/4 v1, 0x0

    if-lez v0, :cond_0

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x0

    aget-object v0, v0, v2

    goto :goto_0

    :cond_0
    move-object v0, v1

    .line 723
    :goto_0
    instance-of v2, v0, Ljava/lang/Integer;

    if-nez v2, :cond_1

    .line 724
    return-void

    .line 726
    :cond_1
    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    .line 727
    invoke-static {v0}, Lcom/prometheus/camera/rev/EvPanelGuard;->evFixModeMatch(I)Z

    move-result v2

    if-nez v2, :cond_2

    .line 728
    return-void

    .line 731
    :cond_2
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v2

    .line 732
    instance-of v3, v2, Ljava/util/List;

    const/4 v4, -0x1

    if-eqz v3, :cond_3

    check-cast v2, Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    goto :goto_1

    :cond_3
    move v2, v4

    .line 733
    :goto_1
    const-string v3, "[EV\u6863\u4f4d] mode=0x"

    if-lez v2, :cond_4

    .line 734
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {v0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "  \u6863\u4f4d\u6570="

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "  \u21d2 \u6b63\u5e38\uff0c\u672a\u5e72\u9884"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 735
    return-void

    .line 739
    :cond_4
    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v2, v2

    const/4 v5, 0x2

    if-le v2, v5, :cond_5

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object v1, v1, v5

    .line 740
    :cond_5
    if-nez v1, :cond_6

    .line 742
    :try_start_0
    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const-string v5, "mCapabilities"

    invoke-static {v2, v5}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 745
    goto :goto_2

    .line 743
    :catchall_0
    move-exception v2

    .line 747
    :cond_6
    :goto_2
    if-nez v1, :cond_7

    .line 748
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {v0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "  \u6863\u4f4d\u4e3a\u7a7a\uff0c\u4e14\u62ff\u4e0d\u5230 mCapabilities \u21d2 \u65e0\u6cd5\u91cd\u5efa\uff08\u7b49\u4e0b\u4e00\u6b21 v()\uff09"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 750
    return-void

    .line 761
    :cond_7
    :try_start_1
    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const-string v5, "s"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v2, v5, v1}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    .line 765
    nop

    .line 766
    instance-of v2, v1, Ljava/util/List;

    if-eqz v2, :cond_8

    move-object v2, v1

    check-cast v2, Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v4

    .line 767
    :cond_8
    if-gtz v4, :cond_9

    .line 768
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {v0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "  \u91cd\u5efa\u540e\u4ecd\u4e3a\u7a7a\uff08"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "\uff09\u21d2 capabilities \u672a\u5c31\u7eea\u6216 AE \u8865\u507f\u8303\u56f4\u4e3a\u7a7a\uff0c\u975e\u672c\u6a21\u5757\u53ef\u89e3"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 770
    return-void

    .line 774
    :cond_9
    :try_start_2
    iget-object v2, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const-string v5, "mItems"

    move-object v6, v1

    check-cast v6, Ljava/util/List;

    .line 775
    invoke-static {v6}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v6

    .line 774
    invoke-static {v2, v5, v6}, Lde/robv/android/xposed/XposedHelpers;->setObjectField(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/Object;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 779
    nop

    .line 780
    invoke-virtual {p1, v1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    .line 781
    sget p1, Lcom/prometheus/camera/rev/EvPanelGuard;->evFixCount:I

    add-int/lit8 p1, p1, 0x1

    sput p1, Lcom/prometheus/camera/rev/EvPanelGuard;->evFixCount:I

    .line 782
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {v0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "  \u6863\u4f4d\u4e3a\u7a7a \u21d2 \u5df2\u91cd\u5efa "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, " \u6863\uff08\u7d2f\u8ba1\u4fee\u590d "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    sget v0, Lcom/prometheus/camera/rev/EvPanelGuard;->evFixCount:I

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, " \u6b21\uff09"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 784
    return-void

    .line 776
    :catchall_1
    move-exception p1

    .line 777
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[EV\u6863\u4f4d] \u5199\u56de mItems \u5931\u8d25: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 778
    return-void

    .line 762
    :catchall_2
    move-exception p1

    .line 763
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-static {v0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "  \u91cd\u5efa\u5931\u8d25\uff08s() \u629b\u5f02\u5e38\uff09: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 764
    return-void
.end method

.method private onPanelClose()V
    .locals 5

    .line 1006
    sget-boolean v0, Lcom/prometheus/camera/rev/EvPanelGuard;->panelOpen:Z

    if-nez v0, :cond_0

    .line 1007
    return-void

    .line 1009
    :cond_0
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    sget-wide v2, Lcom/prometheus/camera/rev/EvPanelGuard;->panelOpenAt:J

    sub-long/2addr v0, v2

    .line 1010
    const/4 v2, 0x0

    sput-boolean v2, Lcom/prometheus/camera/rev/EvPanelGuard;->panelOpen:Z

    .line 1011
    const/4 v3, 0x0

    sput-object v3, Lcom/prometheus/camera/rev/EvPanelGuard;->panelRef:Ljava/lang/ref/WeakReference;

    .line 1012
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "[\u9762\u677f\u5173\u95ed] \u5b58\u6d3b "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "ms"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "\uff08\u8fd4\u56de\u952e\u62e6\u622a\u5df2\u653e\u5f00\uff0c\u672a\u62e6\u4efb\u4f55\u4e8b\u4ef6\uff09"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 1015
    sput v2, Lcom/prometheus/camera/rev/EvPanelGuard;->suppressCount:I

    .line 1016
    return-void
.end method

.method private onPanelOpen(Ljava/lang/Object;)V
    .locals 3

    .line 986
    nop

    .line 988
    :try_start_0
    const-string v0, "mCurrentMode"

    invoke-static {p1, v0}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 991
    goto :goto_0

    .line 989
    :catchall_0
    move-exception v0

    const/4 v0, -0x1

    .line 992
    :goto_0
    if-gez v0, :cond_0

    .line 993
    sget v0, Lcom/prometheus/camera/rev/EvPanelGuard;->modeCache:I

    .line 995
    :cond_0
    sput v0, Lcom/prometheus/camera/rev/EvPanelGuard;->panelMode:I

    .line 996
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v1

    sput-wide v1, Lcom/prometheus/camera/rev/EvPanelGuard;->panelOpenAt:J

    .line 997
    new-instance v1, Ljava/lang/ref/WeakReference;

    invoke-direct {v1, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    sput-object v1, Lcom/prometheus/camera/rev/EvPanelGuard;->panelRef:Ljava/lang/ref/WeakReference;

    .line 998
    const/4 p1, 0x0

    sput p1, Lcom/prometheus/camera/rev/EvPanelGuard;->suppressCount:I

    .line 999
    const/4 p1, 0x1

    sput-boolean p1, Lcom/prometheus/camera/rev/EvPanelGuard;->panelOpen:Z

    .line 1000
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[\u9762\u677f\u6253\u5f00] mode=0x"

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-static {v0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, "("

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, ")  \u7f13\u5b58mode=0x"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    sget v0, Lcom/prometheus/camera/rev/EvPanelGuard;->modeCache:I

    .line 1001
    invoke-static {v0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "  \uff08\u8fd4\u56de\u952e\u62e6\u622a\u5df2\u653e\u5f00\uff0c\u4ec5\u8bb0\u5f55\uff09"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 1000
    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 1003
    return-void
.end method

.method private onPortraitEntranceBuilt(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 7

    .line 885
    const-string v0, "a"

    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v1

    .line 886
    instance-of v2, v1, Ljava/util/List;

    if-nez v2, :cond_0

    .line 887
    return-void

    .line 889
    :cond_0
    check-cast v1, Ljava/util/List;

    .line 892
    nop

    .line 894
    const/4 v2, 0x0

    const/4 v3, -0x1

    :try_start_0
    iget-object v4, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const-string v5, "getModuleId"

    new-array v6, v2, [Ljava/lang/Object;

    invoke-static {v4, v5, v6}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    .line 895
    instance-of v5, v4, Ljava/lang/Integer;

    if-eqz v5, :cond_1

    .line 896
    check-cast v4, Ljava/lang/Integer;

    invoke-virtual {v4}, Ljava/lang/Integer;->intValue()I

    move-result v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 900
    :cond_1
    goto :goto_0

    .line 898
    :catchall_0
    move-exception v4

    .line 901
    :goto_0
    if-gez v3, :cond_2

    .line 902
    sget v3, Lcom/prometheus/camera/rev/EvPanelGuard;->modeCache:I

    .line 904
    :cond_2
    const/16 v4, 0xab

    if-eq v3, v4, :cond_3

    .line 905
    return-void

    .line 909
    :cond_3
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_5

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    .line 911
    :try_start_1
    const-string v6, "e"

    invoke-static {v5, v6}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v5

    const/4 v6, 0x5

    if-ne v5, v6, :cond_4

    .line 912
    const-string v5, "[\u4eba\u50cfEV] mode=0xab \u5e95\u90e8\u6761\u5df2\u542b EV \u5165\u53e3\uff08mKey=5\uff09\uff0c\u672a\u91cd\u590d\u6dfb\u52a0"

    invoke-static {v5}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 914
    return-void

    .line 918
    :cond_4
    goto :goto_2

    .line 916
    :catchall_1
    move-exception v5

    .line 919
    :goto_2
    goto :goto_1

    .line 930
    :cond_5
    :try_start_2
    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    invoke-static {p1, v0}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_4

    .line 934
    nop

    .line 935
    instance-of v3, p1, Landroid/content/Context;

    if-nez v3, :cond_7

    .line 936
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[\u4eba\u50cfEV] Ly3/c.a \u4e0d\u662f Context\uff08"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 937
    if-nez p1, :cond_6

    const-string p1, "null"

    goto :goto_3

    :cond_6
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p1

    :goto_3
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v0, "\uff09\u21d2 \u653e\u5f03"

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 936
    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 938
    return-void

    .line 943
    :cond_7
    :try_start_3
    const-string v3, "com.android.camera.features.mode.capture.h0"

    sget-object v5, Lcom/prometheus/camera/rev/EvPanelGuard;->evClassLoader:Ljava/lang/ClassLoader;

    invoke-static {v3, v5}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v3

    .line 944
    nop

    .line 945
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    filled-new-array {p1, v4}, [Ljava/lang/Object;

    move-result-object p1

    .line 944
    invoke-static {v3, v0, p1}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_3

    .line 949
    nop

    .line 950
    if-nez p1, :cond_8

    .line 951
    const-string p1, "[\u4eba\u50cfEV] \u5de5\u5382\u8fd4\u56de null\uff08Lu2/Q#O() \u526f\u5c4f\u6a21\u5f0f \u6216 Je/c#V() \u4e3a\u5047\uff09\u21d2 \u672a\u6dfb\u52a0"

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 952
    return-void

    .line 956
    :cond_8
    :try_start_4
    invoke-interface {v1, v2, p1}, Ljava/util/List;->add(ILjava/lang/Object;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 960
    nop

    .line 961
    const-string p1, "[\u4eba\u50cfEV] mode=0xab \u21d2 \u5df2\u8865\u4e0a EV \u9762\u677f\u5165\u53e3\uff08mKey=5\uff09\uff0c\u5e95\u90e8\u6761\u73b0\u5728\u6709 EV \u6309\u94ae"

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 963
    return-void

    .line 957
    :catchall_2
    move-exception p1

    .line 958
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[\u4eba\u50cfEV] \u63d2\u5165\u5165\u53e3\u9879\u5931\u8d25\uff08\u8868\u53ef\u80fd\u662f\u4e0d\u53ef\u53d8 List\uff09: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 959
    return-void

    .line 946
    :catchall_3
    move-exception p1

    .line 947
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[\u4eba\u50cfEV] \u8c03 com.android.camera.features.mode.capture.h0#a(context, 0xab) \u5931\u8d25: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 948
    return-void

    .line 931
    :catchall_4
    move-exception p1

    .line 932
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[\u4eba\u50cfEV] \u53d6 Context\uff08Ly3/c.a\uff09\u5931\u8d25: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 933
    return-void
.end method

.method private static panelStillOpen()Z
    .locals 8

    .line 1024
    sget-boolean v0, Lcom/prometheus/camera/rev/EvPanelGuard;->panelOpen:Z

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 1025
    return v1

    .line 1027
    :cond_0
    sget-object v0, Lcom/prometheus/camera/rev/EvPanelGuard;->panelRef:Ljava/lang/ref/WeakReference;

    .line 1028
    const/4 v2, 0x0

    if-nez v0, :cond_1

    move-object v0, v2

    goto :goto_0

    :cond_1
    invoke-virtual {v0}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    .line 1029
    :goto_0
    const/4 v3, 0x1

    if-eqz v0, :cond_4

    .line 1031
    :try_start_0
    const-string v4, "isAdded"

    new-array v5, v1, [Ljava/lang/Object;

    invoke-static {v0, v4, v5}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 1032
    instance-of v4, v0, Ljava/lang/Boolean;

    if-eqz v4, :cond_3

    .line 1033
    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-nez v0, :cond_2

    .line 1034
    sput-boolean v1, Lcom/prometheus/camera/rev/EvPanelGuard;->panelOpen:Z

    .line 1035
    sput-object v2, Lcom/prometheus/camera/rev/EvPanelGuard;->panelRef:Ljava/lang/ref/WeakReference;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1036
    return v1

    .line 1038
    :cond_2
    return v3

    .line 1042
    :cond_3
    goto :goto_1

    .line 1040
    :catchall_0
    move-exception v0

    .line 1044
    :cond_4
    :goto_1
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v4

    sget-wide v6, Lcom/prometheus/camera/rev/EvPanelGuard;->panelOpenAt:J

    sub-long/2addr v4, v6

    const-wide/32 v6, 0x927c0

    cmp-long v0, v4, v6

    if-lez v0, :cond_5

    .line 1045
    sput-boolean v1, Lcom/prometheus/camera/rev/EvPanelGuard;->panelOpen:Z

    .line 1046
    sput-object v2, Lcom/prometheus/camera/rev/EvPanelGuard;->panelRef:Ljava/lang/ref/WeakReference;

    .line 1047
    return v1

    .line 1049
    :cond_5
    return v3
.end method


# virtual methods
.method public handleLoadPackage(Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .line 380
    if-eqz p1, :cond_1

    iget-object v0, p1, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->packageName:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p1, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->packageName:Ljava/lang/String;

    .line 381
    const-string v1, "com.android.camera"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    goto/16 :goto_6

    .line 385
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "v1.3 \u5df2\u6302\u8f7d \u260513U(ishtar) EV \u80fd\u529b\u8865\u4e01\uff08\u591c\u666f/\u8d85\u6e05/\u4eba\u50cf\uff09  GUARD_ENABLED=true  DRY_RUN=false  \u8fd4\u56de\u952e\u62e6\u622a=false  GUARD_MODES="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 389
    invoke-static {}, Lcom/prometheus/camera/rev/EvPanelGuard;->modesToStr()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "  BLOCK_ONLY_SYNTHETIC="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "  \u7a97\u53e3="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "\u9762\u677f\u5168\u7a0b"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 385
    invoke-static {v0}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 392
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "v1.3 \u2605\u4e3b\u4fee\uff1aEV \u6863\u4f4d\u8868 FORCE_EV_ITEMS=true  EV_FIX_MODES="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 393
    invoke-static {}, Lcom/prometheus/camera/rev/EvPanelGuard;->evModesToStr()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "  FORCE_IS_SUPPORT_MODE="

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "  KEEP_DUAL_CAMERA="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 392
    invoke-static {v0}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 396
    const-string v0, "v1.3 \u2605\u4eba\u50cf EV\uff1aFORCE_DEVICE_EV_FLAG=false  FORCE_PORTRAIT_EV_TIP=true  BLOCK_BACK_KEY=false\uff08false=\u8fd4\u56de\u624b\u52bf\u6b63\u5e38\uff09"

    invoke-static {v0}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 405
    iget-object p1, p1, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    .line 406
    sput-object p1, Lcom/prometheus/camera/rev/EvPanelGuard;->evClassLoader:Ljava/lang/ClassLoader;

    .line 408
    :try_start_0
    invoke-direct {p0, p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->hookModeCache(Ljava/lang/ClassLoader;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 411
    goto :goto_0

    .line 409
    :catchall_0
    move-exception v0

    .line 410
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "!! \u6302\u8f7d\u5f02\u5e38\uff08\u6a21\u5f0f\u7f13\u5b58 j9.m0#k1\uff09\uff1a"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 413
    :goto_0
    :try_start_1
    invoke-direct {p0, p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->hookPanelState(Ljava/lang/ClassLoader;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 416
    goto :goto_1

    .line 414
    :catchall_1
    move-exception v0

    .line 415
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "!! \u6302\u8f7d\u5f02\u5e38\uff08\u9762\u677f\u72b6\u6001 P4.t\uff09\uff1a"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 418
    :goto_1
    :try_start_2
    invoke-direct {p0, p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->hookConfigFragmentData(Ljava/lang/ClassLoader;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    .line 421
    goto :goto_2

    .line 419
    :catchall_2
    move-exception v0

    .line 420
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "!! \u6302\u8f7d\u5f02\u5e38\uff08\u6392\u9664\u8868 P4.t#configFragmentData\uff09\uff1a"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 434
    :goto_2
    const-string v0, "\u2605\u8fd4\u56de\u952e/\u8fd4\u56de\u624b\u52bf\u62e6\u622a\u5df2\u653e\u5f00\uff08BLOCK_BACK_KEY=false\uff09 \u21d2 \u4e0d\u6302\u8f7d Camera#dispatchKeyEvent / q6.b#q\uff0c\u8c03\u5b8c EV \u53ef\u6b63\u5e38\u624b\u52bf\u8fd4\u56de\u62cd\u6444\u754c\u9762"

    invoke-static {v0}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 439
    :try_start_3
    invoke-direct {p0, p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->hookEvComponent(Ljava/lang/ClassLoader;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_3

    .line 442
    goto :goto_3

    .line 440
    :catchall_3
    move-exception v0

    .line 441
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "!! \u6302\u8f7d\u5f02\u5e38\uff08EV \u6863\u4f4d\u8868 r2.D0\uff09\uff1a"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 444
    :goto_3
    :try_start_4
    invoke-direct {p0, p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->hookDeviceFlag(Ljava/lang/ClassLoader;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_4

    .line 447
    goto :goto_4

    .line 445
    :catchall_4
    move-exception v0

    .line 446
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "!! \u6302\u8f7d\u5f02\u5e38\uff08\u8bbe\u5907\u80fd\u529b\u5f00\u5173 Je.c#Z1\uff09\uff1a"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 449
    :goto_4
    :try_start_5
    invoke-direct {p0, p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->hookPortraitEvEntrance(Ljava/lang/ClassLoader;)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_5

    .line 452
    goto :goto_5

    .line 450
    :catchall_5
    move-exception p1

    .line 451
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "!! \u6302\u8f7d\u5f02\u5e38\uff08\u4eba\u50cf EV \u9762\u677f\u5165\u53e3\uff09\uff1a"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->log(Ljava/lang/String;)V

    .line 453
    :goto_5
    return-void

    .line 382
    :cond_1
    :goto_6
    return-void
.end method
