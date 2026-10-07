.class public final Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$7;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "PhoenixMasterLiveTailBridge.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge;->install(Ljava/lang/ClassLoader;)V
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

    iput-object p1, p0, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge$7;->val$loader:Ljava/lang/ClassLoader;

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 6

    :try_start_0
    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    array-length v1, v0

    const/4 v2, 0x2

    if-lt v1, v2, :done

    const/4 v1, 0x0

    aget-object v1, v0, v1

    const-string v2, "3"

    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :done

    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :done

    check-cast v0, [Ljava/lang/String;

    array-length v1, v0

    const/4 v2, 0x2

    if-ne v1, v2, :done

    const/4 v1, 0x0

    aget-object v2, v0, v1

    const-string v3, "4.2"

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :skip0

    const-string v3, "5.0"

    aput-object v3, v0, v1

    const-string v3, "PHX77"

    const-string v4, "freemov zoom start 4.2 -> 5.0"

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :skip0
    const/4 v1, 0x1

    aget-object v2, v0, v1

    const-string v3, "4.2"

    invoke-virtual {v3, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :done

    const-string v3, "5.0"

    aput-object v3, v0, v1

    const-string v3, "PHX77"

    const-string v4, "freemov zoom end 4.2 -> 5.0"

    invoke-static {v3, v4}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    :done
    nop
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-void

    :catchall_0
    move-exception v0

    return-void
.end method