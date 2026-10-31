.class public final Lcom/prometheus/camera/m3/M3EntryPoint;
.super Ljava/lang/Object;
.source "M3EntryPoint.java"

# interfaces
.implements Lde/robv/android/xposed/IXposedHookLoadPackage;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static installM3QuickFocalConfig(Ljava/lang/ClassLoader;)V
    .locals 2

    .line 68
    const-string v0, "\ucf6b\ucf67\ucf65\ucf26\ucf65\ucf61\ucf26\ucf6c\ucf6d\ucf7e\ucf61\ucf6b\ucf6d\ucf26\ucf46\ucf6d\ucf72\ucf60\ucf69"

    invoke-static {v0, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    .line 70
    const-string v1, "\u48d1\u48dd\u48df\u489c\u48df\u48db\u489c\u48d6\u48d7\u48c4\u48db\u48d1\u48d7\u489c\u48f3\u48c7\u48c0\u48dd\u48c0\u48d3"

    invoke-static {v1, p0}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object p0

    .line 72
    new-instance v1, Lcom/prometheus/camera/m3/M3EntryPoint$6;

    invoke-direct {v1, v0}, Lcom/prometheus/camera/m3/M3EntryPoint$6;-><init>(Ljava/lang/Class;)V

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "B1"

    invoke-static {p0, v1, v0}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 87
    const-string p0, "M3 quick focal config installed: 23/28/35"

    invoke-static {p0}, Lcom/prometheus/camera/m3/M3Runtime;->log(Ljava/lang/String;)V

    .line 88
    return-void
.end method

.method private static installMediaEditorLegendGate(Ljava/lang/ClassLoader;)V
    .locals 0

    invoke-static {p0}, Lcom/prometheus/camera/meditor210/MEditor210Runtime;->installLegend(Ljava/lang/ClassLoader;)V

    return-void
.end method


# virtual methods
.method public handleLoadPackage(Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .line 16
    iget-object v0, p1, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->packageName:Ljava/lang/String;

    const-string v1, "com.miui.mediaeditor"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 17
    iget-object v0, p1, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->processName:Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p1, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->processName:Ljava/lang/String;

    .line 18
    const-string v1, "com.miui.mediaeditor:photo_editor"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 19
    :cond_0
    iget-object p1, p1, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    invoke-static {p1}, Lcom/prometheus/camera/m3/M3EntryPoint;->installMediaEditorLegendGate(Ljava/lang/ClassLoader;)V

    .line 20
    return-void

    .line 22
    :cond_1
    iget-object v0, p1, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->packageName:Ljava/lang/String;

    const-string v1, "com.android.camera"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, p1, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->processName:Ljava/lang/String;

    .line 23
    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_2

    goto :goto_0

    .line 24
    :cond_2
    iget-object p1, p1, Lde/robv/android/xposed/callbacks/XC_LoadPackage$LoadPackageParam;->classLoader:Ljava/lang/ClassLoader;

    .line 25
    invoke-static {p1}, Lcom/prometheus/camera/m3/M3EntryPoint;->installM3QuickFocalConfig(Ljava/lang/ClassLoader;)V

    .line 26
    new-instance v0, Lcom/prometheus/camera/m3/M3EntryPoint$1;

    invoke-direct {v0, p0}, Lcom/prometheus/camera/m3/M3EntryPoint$1;-><init>(Lcom/prometheus/camera/m3/M3EntryPoint;)V

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "Je.c"

    const-string v2, "W0"

    invoke-static {v1, p1, v2, v0}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 29
    new-instance v0, Lcom/prometheus/camera/m3/M3EntryPoint$2;

    invoke-direct {v0, p0, p1}, Lcom/prometheus/camera/m3/M3EntryPoint$2;-><init>(Lcom/prometheus/camera/m3/M3EntryPoint;Ljava/lang/ClassLoader;)V

    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "T3.a"

    const-string v2, "u5"

    invoke-static {v1, p1, v2, v0}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 38
    const-string v0, "r2.A"

    invoke-static {v0, p1}, Lde/robv/android/xposed/XposedHelpers;->findClass(Ljava/lang/String;Ljava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    .line 39
    const-class v1, Ljava/lang/Object;

    new-instance v2, Lcom/prometheus/camera/m3/M3EntryPoint$3;

    invoke-direct {v2, p0}, Lcom/prometheus/camera/m3/M3EntryPoint$3;-><init>(Lcom/prometheus/camera/m3/M3EntryPoint;)V

    filled-new-array {v1, v2}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "R"

    invoke-static {v0, v2, v1}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 47
    sget-object v1, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    new-instance v2, Lcom/prometheus/camera/m3/M3EntryPoint$4;

    invoke-direct {v2, p0}, Lcom/prometheus/camera/m3/M3EntryPoint$4;-><init>(Lcom/prometheus/camera/m3/M3EntryPoint;)V

    filled-new-array {v1, v2}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "getDefaultValue"

    invoke-static {v0, v2, v1}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/Class;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 50
    sget-object v1, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    new-instance v2, Lcom/prometheus/camera/m3/M3EntryPoint$5;

    invoke-direct {v2, p0, v0}, Lcom/prometheus/camera/m3/M3EntryPoint$5;-><init>(Lcom/prometheus/camera/m3/M3EntryPoint;Ljava/lang/Class;)V

    filled-new-array {v1, v2}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "com.android.camera.data.data.c"

    const-string v2, "getComponentValue"

    invoke-static {v1, p1, v2, v0}, Lde/robv/android/xposed/XposedHelpers;->findAndHookMethod(Ljava/lang/String;Ljava/lang/ClassLoader;Ljava/lang/String;[Ljava/lang/Object;)Lde/robv/android/xposed/XC_MethodHook$Unhook;

    .line 56
    const-string p1, "PhoenixM3"

    const-string v0, "independent M3 entry hooks installed"

    invoke-static {p1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 57
    return-void

    .line 23
    :cond_3
    :goto_0
    return-void
.end method
