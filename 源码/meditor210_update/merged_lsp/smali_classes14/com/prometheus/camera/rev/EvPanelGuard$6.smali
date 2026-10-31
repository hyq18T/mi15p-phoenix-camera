.class Lcom/prometheus/camera/rev/EvPanelGuard$6;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "EvPanelGuard.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/prometheus/camera/rev/EvPanelGuard;->hookEvComponent(Ljava/lang/ClassLoader;)V
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

    .line 696
    iput-object p1, p0, Lcom/prometheus/camera/rev/EvPanelGuard$6;->this$0:Lcom/prometheus/camera/rev/EvPanelGuard;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 2

    .line 700
    :try_start_0
    iget-object v0, p0, Lcom/prometheus/camera/rev/EvPanelGuard$6;->this$0:Lcom/prometheus/camera/rev/EvPanelGuard;

    invoke-static {v0, p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->access$800(Lcom/prometheus/camera/rev/EvPanelGuard;Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 703
    goto :goto_0

    .line 701
    :catchall_0
    move-exception p1

    .line 702
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "EV \u6863\u4f4d\u8868\u5904\u7406\u5f02\u5e38: "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->access$300(Ljava/lang/String;)V

    .line 704
    :goto_0
    return-void
.end method
