.class Lcom/prometheus/camera/rev/MediaEditorWatermarkBridge$22;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "MediaEditorWatermarkBridge.java"


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 3

    const-string v2, "after enter"

    invoke-static {v2}, Lcom/prometheus/camera/rev/MeProbe;->note(Ljava/lang/String;)V

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->method:Ljava/lang/reflect/Member;

    check-cast v0, Ljava/lang/reflect/Method;

    invoke-virtual {v0}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v0

    invoke-static {v0}, Lcom/prometheus/camera/rev/MeProbe;->successSingleton(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v1

    if-ne v1, v0, :cond_0

    invoke-virtual {p1, v0}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    const-string v2, "guard forced success (after)"

    invoke-static {v2}, Lcom/prometheus/camera/rev/MeProbe;->note(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 5

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->method:Ljava/lang/reflect/Member;

    check-cast v0, Ljava/lang/reflect/Method;

    invoke-virtual {v0}, Ljava/lang/reflect/Method;->getReturnType()Ljava/lang/Class;

    move-result-object v1

    invoke-static {v1}, Lcom/prometheus/camera/rev/MeProbe;->successSingleton(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v2

    iget-object v3, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v4, 0x1

    aget-object v3, v3, v4

    invoke-static {v3, v2}, Lcom/prometheus/camera/rev/MeProbe;->guard(Ljava/lang/Object;Ljava/lang/Object;)V

    if-eqz v2, :cond_0

    iget-object v3, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v4, 0x0

    aget-object v3, v3, v4

    invoke-static {v3, v2}, Lcom/prometheus/camera/rev/MeProbe;->guard(Ljava/lang/Object;Ljava/lang/Object;)V

    invoke-virtual {p1, v2}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->setResult(Ljava/lang/Object;)V

    const-string v3, "guard forced success (before)"

    invoke-static {v3}, Lcom/prometheus/camera/rev/MeProbe;->note(Ljava/lang/String;)V

    :cond_0
    return-void
.end method
