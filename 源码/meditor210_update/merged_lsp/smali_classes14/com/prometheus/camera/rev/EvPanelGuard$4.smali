.class Lcom/prometheus/camera/rev/EvPanelGuard$4;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "EvPanelGuard.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/prometheus/camera/rev/EvPanelGuard;->hookConfigFragmentData(Ljava/lang/ClassLoader;)V
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

    .line 548
    iput-object p1, p0, Lcom/prometheus/camera/rev/EvPanelGuard$4;->this$0:Lcom/prometheus/camera/rev/EvPanelGuard;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 3

    .line 552
    :try_start_0
    iget-object v0, p0, Lcom/prometheus/camera/rev/EvPanelGuard$4;->this$0:Lcom/prometheus/camera/rev/EvPanelGuard;

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v2, 0x0

    aget-object p1, p1, v2

    invoke-static {v0, v1, p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->access$500(Lcom/prometheus/camera/rev/EvPanelGuard;Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 555
    goto :goto_0

    .line 553
    :catchall_0
    move-exception p1

    .line 554
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "\u6392\u9664\u8868\u5904\u7406\u5f02\u5e38: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->access$300(Ljava/lang/String;)V

    .line 556
    :goto_0
    return-void
.end method
