.class Lcom/prometheus/camera/rev/EvPanelGuard$7;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "EvPanelGuard.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/prometheus/camera/rev/EvPanelGuard;->hookDeviceFlag(Ljava/lang/ClassLoader;)V
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

    .line 798
    iput-object p1, p0, Lcom/prometheus/camera/rev/EvPanelGuard$7;->this$0:Lcom/prometheus/camera/rev/EvPanelGuard;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 2

    .line 802
    :try_start_0
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object p1

    .line 803
    instance-of v0, p1, Ljava/lang/Boolean;

    if-eqz v0, :cond_0

    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    .line 804
    :goto_0
    invoke-static {}, Lcom/prometheus/camera/rev/EvPanelGuard;->access$900()Z

    move-result v0

    if-eq p1, v0, :cond_2

    .line 805
    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->access$902(Z)Z

    .line 806
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "[\u8bbe\u5907\u5f00\u5173] Je/c#Z1() = "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 807
    if-eqz p1, :cond_1

    const-string p1, "  \uff08\u6b63\u5e38\uff09"

    goto :goto_1

    .line 808
    :cond_1
    const-string p1, "  \u21d2 \u4eba\u50cf/\u591c\u666f/\u8d85\u6e05 EV \u4f1a\u88ab\u5224\u4e0d\u652f\u6301\uff0c\u672c\u6a21\u5757\u5df2\u515c\u5e95"

    :goto_1
    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 806
    invoke-static {p1}, Lcom/prometheus/camera/rev/EvPanelGuard;->access$300(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 819
    :cond_2
    goto :goto_2

    .line 817
    :catchall_0
    move-exception p1

    .line 820
    :goto_2
    return-void
.end method
