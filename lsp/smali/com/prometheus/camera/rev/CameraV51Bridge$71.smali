.class Lcom/prometheus/camera/rev/CameraV51Bridge$71;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "CameraV51Bridge.java"

# interfaces
.implements Lcom/prometheus/camera/rev/CameraV51Bridge$InstallStep;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/prometheus/camera/rev/CameraV51Bridge;->install(Ljava/lang/ClassLoader;Lcom/prometheus/camera/rev/ContentRegistry;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# static fields
.field private static final LOG_LIMIT:I = 0x14

.field private static sLogCount:I


# instance fields
.field final synthetic val$loader:Ljava/lang/ClassLoader;


# direct methods
.method constructor <init>(Ljava/lang/ClassLoader;)V
    .locals 0

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    iput-object p1, p0, Lcom/prometheus/camera/rev/CameraV51Bridge$71;->val$loader:Ljava/lang/ClassLoader;

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const/16 v1, 0xaf

    if-eq v0, v1, :cond_0

    const/16 v1, 0xad

    if-eq v0, v1, :cond_0

    # Phoenix-15Pro: 人像(0xab) 的 EV 面板同样被 DEVCFG 门禁挡住，扩展白名单
    const/16 v1, 0xab

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v1

    instance-of v2, v1, Ljava/lang/Boolean;

    if-eqz v2, :cond_1

    check-cast v1, Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    goto :goto_0

    :cond_1
    const/4 v1, 0x0

    :goto_0
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "PhoenixEV: isSupportMode("

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, ") original="

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    if-nez v1, :cond_2

    const-string v3, " -> forced true"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v3, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-virtual {p1, v3}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    :cond_2
    sget v3, Lcom/prometheus/camera/rev/CameraV51Bridge$71;->sLogCount:I

    const/16 v4, 0x14

    if-lt v3, v4, :cond_3

    return-void

    :cond_3
    add-int/lit8 v4, v3, 0x1

    sput v4, Lcom/prometheus/camera/rev/CameraV51Bridge$71;->sLogCount:I

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;)V

    return-void
.end method

.method public run()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    const-string v0, "r2.D0"

    const/4 v1, 0x1

    iget-object v2, p0, Lcom/prometheus/camera/rev/CameraV51Bridge$71;->val$loader:Ljava/lang/ClassLoader;

    invoke-static {v0, v1, v2}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    sget-object v3, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v3, v1, v2

    const/4 v2, 0x1

    aput-object p0, v1, v2

    const-string v2, "isSupportMode"

    invoke-static {v0, v2, v1}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    const-string v0, "PhoenixEV: hooked r2.D0.isSupportMode(I)Z"

    invoke-static {v0}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;)V

    return-void
.end method