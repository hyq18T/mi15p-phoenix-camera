.class Lcom/prometheus/camera/rev/CameraV51Bridge$72;
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


# instance fields
.field final synthetic val$loader:Ljava/lang/ClassLoader;


# direct methods
.method constructor <init>(Ljava/lang/ClassLoader;)V
    .locals 0

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    iput-object p1, p0, Lcom/prometheus/camera/rev/CameraV51Bridge$72;->val$loader:Ljava/lang/ClassLoader;

    return-void
.end method

.method private logError(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0, p1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;)V

    return-void
.end method

.method private hookOneEntryList(Ljava/lang/String;)V
    .locals 5

    :try_start_0
    const/4 v0, 0x1

    iget-object v1, p0, Lcom/prometheus/camera/rev/CameraV51Bridge$72;->val$loader:Ljava/lang/ClassLoader;

    invoke-static {p1, v0, v1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    const-string v1, "f"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object p0, v2, v3

    invoke-static {v0, v1, v2}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "PhoenixEV: hooked "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "#f()"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-void

    :catchall_0
    move-exception v4

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "PhoenixEV: hook failed for "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "#f() : "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 8

    :try_start_0
    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v0

    instance-of v1, v0, Ljava/util/List;

    if-nez v1, :cond_0

    return-void

    :cond_0
    check-cast v0, Ljava/util/List;

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    const-string v3, "getModuleId"

    invoke-static {v1, v3, v2}, Lde/robv/android/xposed/XposedHelpers;->callMethod(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    instance-of v3, v2, Ljava/lang/Integer;

    const/16 v4, 0xab

    if-eqz v3, :cond_1

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v4

    :cond_1
    const/16 v2, 0xab

    if-eq v4, v2, :cond_2

    return-void

    :cond_2
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_3
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_4

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    const-string v4, "e"

    invoke-static {v3, v4}, Lde/robv/android/xposed/XposedHelpers;->getIntField(Ljava/lang/Object;Ljava/lang/String;)I

    move-result v3

    const/4 v4, 0x5

    if-ne v3, v4, :cond_3

    const-string v0, "PhoenixEV: portrait bar already has EV (mKey=5), skip"

    invoke-static {v0}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;)V

    return-void

    :cond_4
    const-string v2, "a"

    invoke-static {v1, v2}, Lde/robv/android/xposed/XposedHelpers;->getObjectField(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    instance-of v3, v2, Landroid/content/Context;

    if-nez v3, :cond_5

    return-void

    :cond_5
    const-string v3, "com.android.camera.features.mode.capture.h0"

    iget-object v4, p0, Lcom/prometheus/camera/rev/CameraV51Bridge$72;->val$loader:Ljava/lang/ClassLoader;

    invoke-static {v3, v4}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v3

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    const/4 v5, 0x0

    aput-object v2, v4, v5

    const/16 v5, 0xab

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    const/4 v6, 0x1

    aput-object v5, v4, v6

    const-string v5, "a"

    invoke-static {v3, v5, v4}, Lde/robv/android/xposed/XposedHelpers;->callStaticMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    if-nez v3, :cond_6

    const-string v0, "PhoenixEV: portrait EV entrance factory returned null"

    invoke-static {v0}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;)V

    return-void

    :cond_6
    const/4 v4, 0x0

    invoke-interface {v0, v4, v3}, Ljava/util/List;->add(ILjava/lang/Object;)V

    const-string v0, "PhoenixEV: portrait(0xab) EV entrance inserted (mKey=5)"

    invoke-static {v0}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-void

    :catchall_0
    move-exception v7

    const-string v0, "PhoenixEV: portrait EV entrance hook error: "

    invoke-direct {p0, v0, v7}, Lcom/prometheus/camera/rev/CameraV51Bridge$72;->logError(Ljava/lang/String;Ljava/lang/Throwable;)V

    return-void
.end method

.method public run()V
    .locals 4

    const/4 v0, 0x3

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "com.android.camera.features.mode.portrait.d"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "com.android.camera.features.mode.portrait.l"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "com.android.camera.features.mode.portrait.m"

    aput-object v2, v0, v1

    const/4 v1, 0x0

    array-length v2, v0

    :goto_0
    if-ge v1, v2, :cond_0

    aget-object v3, v0, v1

    invoke-direct {p0, v3}, Lcom/prometheus/camera/rev/CameraV51Bridge$72;->hookOneEntryList(Ljava/lang/String;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    const-string v0, "PhoenixEV: portrait EV entrance hook installed"

    invoke-static {v0}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;)V

    return-void
.end method