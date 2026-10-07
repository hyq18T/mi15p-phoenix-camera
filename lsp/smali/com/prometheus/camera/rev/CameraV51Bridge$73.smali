.class Lcom/prometheus/camera/rev/CameraV51Bridge$73;
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

    iput-object p1, p0, Lcom/prometheus/camera/rev/CameraV51Bridge$73;->val$loader:Ljava/lang/ClassLoader;

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v0

    instance-of v1, v0, Ljava/lang/Boolean;

    if-eqz v1, :cond_0

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-nez v0, :cond_1

    return-void

    :cond_1
    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-virtual {p1, v0}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    sget v0, Lcom/prometheus/camera/rev/CameraV51Bridge$73;->sLogCount:I

    const/16 v1, 0x14

    if-lt v0, v1, :cond_2

    return-void

    :cond_2
    add-int/lit8 v1, v0, 0x1

    sput v1, Lcom/prometheus/camera/rev/CameraV51Bridge$73;->sLogCount:I

    const-string v0, "PhoenixLiveEIS: isSupportLivePhotoEIS forced false (corner-crop fix)"

    invoke-static {v0}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;)V

    return-void
.end method
.method public run()V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    const-string v0, "j9.f"

    const/4 v1, 0x1

    iget-object v2, p0, Lcom/prometheus/camera/rev/CameraV51Bridge$73;->val$loader:Ljava/lang/ClassLoader;

    invoke-static {v0, v1, v2}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    const-string v3, "j9.e"

    invoke-static {v3, v1, v2}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v2

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v1, 0x0

    aput-object v2, v3, v1

    const/4 v1, 0x1

    aput-object p0, v3, v1

    const-string v1, "Z2"

    invoke-static {v0, v1, v3}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    const-string v0, "PhoenixLiveEIS: hooked j9.f.isSupportLivePhotoEIS(j9.e)Z"

    invoke-static {v0}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;)V

    return-void
.end method