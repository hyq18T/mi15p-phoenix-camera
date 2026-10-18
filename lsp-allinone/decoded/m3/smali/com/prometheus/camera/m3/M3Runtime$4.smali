.class Lcom/prometheus/camera/m3/M3Runtime$4;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "M3Runtime.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/prometheus/camera/m3/M3Runtime;->handleLoadPackage(Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/prometheus/camera/m3/M3Runtime;


# direct methods
.method constructor <init>(Lcom/prometheus/camera/m3/M3Runtime;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            null
        }
    .end annotation

    .line 87
    iput-object p1, p0, Lcom/prometheus/camera/m3/M3Runtime$4;->this$0:Lcom/prometheus/camera/m3/M3Runtime;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 4

    .line 89
    invoke-static {}, Lcom/prometheus/camera/m3/M3Runtime;->access$200()Lcom/prometheus/camera/m3/M3Runtime$Exposure;

    move-result-object v0

    .line 90
    invoke-static {}, Lcom/prometheus/camera/m3/M3Runtime;->access$100()I

    move-result v1

    const/16 v2, 0x100

    if-ne v1, v2, :cond_3

    if-eqz v0, :cond_3

    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->hasThrowable()Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    .line 91
    :cond_0
    iget-object p1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    .line 92
    const-string v1, "Z"

    invoke-static {p1, v1}, Lde/robv/android/xposed/XposedHelpers;->getBooleanField(Ljava/lang/Object;Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    return-void

    .line 93
    :cond_1
    const-string v1, "phoenix.m3.preview"

    invoke-static {p1, v1}, Lde/robv/android/xposed/XposedHelpers;->getAdditionalInstanceField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/prometheus/camera/m3/M3Runtime$Preview;

    .line 94
    if-nez v2, :cond_2

    .line 95
    new-instance v2, Lcom/prometheus/camera/m3/M3Runtime$Preview;

    const/4 v3, 0x0

    invoke-direct {v2, v3}, Lcom/prometheus/camera/m3/M3Runtime$Preview;-><init>(Lcom/prometheus/camera/m3/M3Runtime$1;)V

    .line 96
    invoke-static {p1, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->setAdditionalInstanceField(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    .line 98
    :cond_2
    invoke-virtual {v2, p1, v0}, Lcom/prometheus/camera/m3/M3Runtime$Preview;->render(Ljava/lang/Object;Lcom/prometheus/camera/m3/M3Runtime$Exposure;)V

    .line 99
    return-void

    .line 90
    :cond_3
    :goto_0
    return-void
.end method
