.class public final Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge;
.super Ljava/lang/Object;
.source "PhoenixMasterLiveTailBridge.java"


# static fields
.field private static final INSTALLED:Ljava/util/concurrent/atomic/AtomicBoolean;

.field public static volatile needMicros:J

.field public static volatile zoomStamp:J

.field public static volatile mlMode:I

.field public static volatile mlStamp:J


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v0}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>()V

    sput-object v0, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge;->INSTALLED:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static install(Ljava/lang/ClassLoader;)V
    .locals 8

    sget-object v0, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge;->INSTALLED:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->getAndSet(Z)Z

    move-result v0

    if-nez v0, :installed

    const/4 v7, 0x0

    :try_start_0
    const-string v0, "PHX77 install begin"

    invoke-static {v0}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;)V

    const-string v0, "com.android.camera.features.mode.masterlive.MasterLiveModule"

    invoke-static {v0, v7, p0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    const-string v1, "startAutoZoom"

    const/4 v2, 0x5

    new-array v2, v2, [Ljava/lang/Class;

    sget-object v3, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    aput-object v3, v2, v7

    const/4 v3, 0x1

    sget-object v4, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    aput-object v4, v2, v3

    const/4 v3, 0x2

    sget-object v4, Ljava/lang/Float;->TYPE:Ljava/lang/Class;

    aput-object v4, v2, v3

    const/4 v3, 0x3

    sget-object v4, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v4, v2, v3

    const/4 v3, 0x4

    sget-object v4, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v4, v2, v3

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    new-instance v1, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$1;

    invoke-direct {v1, p0}, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$1;-><init>(Ljava/lang/ClassLoader;)V

    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    const-string v0, "PHX77 hooked startAutoZoom"

    invoke-static {v0}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;)V

    const-string v0, "ym.k"

    invoke-static {v0, v7, p0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    const/16 v1, 0x9

    new-array v1, v1, [Ljava/lang/Class;

    sget-object v2, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v2, v1, v7

    const/4 v2, 0x1

    sget-object v3, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v3, v1, v2

    const/4 v2, 0x2

    sget-object v3, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v3, v1, v2

    const/4 v2, 0x3

    sget-object v3, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v3, v1, v2

    const/4 v2, 0x4

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v3, v1, v2

    const/4 v2, 0x5

    const-string v3, "android.media.MediaFormat"

    invoke-static {v3, v7, p0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x6

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v3, v1, v2

    const/4 v2, 0x7

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v3, v1, v2

    const/16 v2, 0x8

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v3, v1, v2

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getDeclaredConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v0

    new-instance v1, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$2;

    invoke-direct {v1, p0}, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$2;-><init>(Ljava/lang/ClassLoader;)V

    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    const-string v0, "PHX77 hooked ym.k ctor"

    invoke-static {v0}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;)V

    const-string v0, "ym.f"

    invoke-static {v0, v7, p0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    invoke-static {v0, p0}, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge;->hookSnapshotMethod(Ljava/lang/Class;Ljava/lang/ClassLoader;)V

    const-string v0, "ym.b"

    invoke-static {v0, v7, p0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    invoke-static {v0, p0}, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge;->hookSnapshotMethod(Ljava/lang/Class;Ljava/lang/ClassLoader;)V

    const-string v0, "ym.e"

    invoke-static {v0, v7, p0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    const/16 v1, 0x9

    new-array v1, v1, [Ljava/lang/Class;

    const/4 v2, 0x0

    const-string v3, "android.media.MediaFormat"

    invoke-static {v3, v7, p0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x1

    const-string v3, "android.opengl.EGLContext"

    invoke-static {v3, v7, p0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x2

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v3, v1, v2

    const/4 v2, 0x3

    sget-object v3, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v3, v1, v2

    const/4 v2, 0x4

    sget-object v3, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v3, v1, v2

    const/4 v2, 0x5

    const-string v3, "java.util.concurrent.LinkedBlockingQueue"

    invoke-static {v3, v7, p0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x6

    const-string v3, "zm.c$b"

    invoke-static {v3, v7, p0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x7

    const-string v3, "java.util.concurrent.ArrayBlockingQueue"

    invoke-static {v3, v7, p0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v3

    aput-object v3, v1, v2

    const/16 v2, 0x8

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v3, v1, v2

    invoke-virtual {v0, v1}, Ljava/lang/Class;->getDeclaredConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v0

    new-instance v1, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$5;

    invoke-direct {v1, p0}, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$5;-><init>(Ljava/lang/ClassLoader;)V

    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    const-string v0, "PHX77 hooked ym.e ctor"

    invoke-static {v0}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;)V
        const/4 v7, 0x0

    const-string v0, "xm.c"

    invoke-static {v0, v7, p0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    const-string v1, "d"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Class;

    const/4 v3, 0x0

    const-string v4, "xm.b"

    invoke-static {v4, v7, p0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    new-instance v1, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$6;

    invoke-direct {v1, p0}, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$6;-><init>(Ljava/lang/ClassLoader;)V

    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    const-string v0, "PHX77 hooked xm.c.d"

    invoke-static {v0}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;)V
    const-string v0, "v2.d0"

    invoke-static {v0, v7, p0}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    const-string v1, "m"

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Class;

    const/4 v3, 0x0

    const-class v4, Ljava/lang/String;

    aput-object v4, v2, v3

    const/4 v3, 0x1

    const-class v4, Ljava/lang/String;

    aput-object v4, v2, v3

    invoke-virtual {v0, v1, v2}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    new-instance v1, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$7;

    invoke-direct {v1, p0}, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$7;-><init>(Ljava/lang/ClassLoader;)V

    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    const-string v0, "PHX77 hooked v2.d0.m"

    invoke-static {v0}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;)V
const-string v0, "PHX77 all hooks installed"

    invoke-static {v0}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-void

    :installed
    const-string v0, "PHX77 install already done"

    invoke-static {v0}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;)V

    return-void

    :catchall_0
    move-exception v0

    const-string v1, "PHX77 "

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {v1, v0}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method private static hookSnapshotMethod(Ljava/lang/Class;Ljava/lang/ClassLoader;)V
    .locals 5

    :try_start_0
    const-string v0, "v"

    const/4 v1, 0x5

    new-array v1, v1, [Ljava/lang/Class;

    const/4 v2, 0x0

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v3, v1, v2

    const/4 v2, 0x1

    sget-object v3, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    aput-object v3, v1, v2

    const/4 v2, 0x2

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v3, v1, v2

    const/4 v2, 0x3

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v3, v1, v2

    const/4 v2, 0x4

    sget-object v3, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v3, v1, v2

    invoke-virtual {p0, v0, v1}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    new-instance v1, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$3;

    invoke-direct {v1, p1}, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$3;-><init>(Ljava/lang/ClassLoader;)V

    invoke-static {v0, v1}, Lde/robv/android/xposed/XposedBridge;->hookMethod(Ljava/lang/reflect/Member;Lde/robv/android/xposed/XC_MethodHook;)Lde/robv/android/xposed/XC_MethodHook$Unhook;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-void

    :catchall_0
    move-exception v0

    const-string v1, "PHX77 "

    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {v1, v0}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method
