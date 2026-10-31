.class Lcom/prometheus/camera/rev/EvPanelGuard$1;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "EvPanelGuard.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/prometheus/camera/rev/EvPanelGuard;->hookModeCache(Ljava/lang/ClassLoader;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/prometheus/camera/rev/EvPanelGuard;


# direct methods
.method constructor <init>(Lcom/prometheus/camera/rev/EvPanelGuard;)V
    .locals 0

    .line 466
    iput-object p1, p0, Lcom/prometheus/camera/rev/EvPanelGuard$1;->this$0:Lcom/prometheus/camera/rev/EvPanelGuard;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 2

    .line 470
    :try_start_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v0, v0

    const/4 v1, 0x2

    if-le v0, v1, :cond_0

    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    aget-object p1, p1, v1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    .line 471
    :goto_0
    if-nez p1, :cond_1

    .line 472
    return-void

    .line 474
    :cond_1
    const-string v0, "H3"

    invoke-static {p1, v0}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result p1

    .line 475
    invoke-static {}, Lcom/prometheus/camera/rev/EvPanelGuard;->access$000()I

    .line 481
    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->access$002(I)I

    .line 482
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    invoke-static {v0, v1}, Lcom/prometheus/camera/rev/EvPanelGuard;->access$102(J)J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 485
    goto :goto_1

    .line 483
    :catchall_0
    move-exception p1

    .line 486
    :goto_1
    return-void
.end method
