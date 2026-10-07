.class public final Lcom/prometheus/camera/rev/CameraV51Bridge$77;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "CameraV51Bridge.java"

# interfaces
.implements Lcom/prometheus/camera/rev/CameraV51Bridge$InstallStep;

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

    iput-object p1, p0, Lcom/prometheus/camera/rev/CameraV51Bridge$77;->val$loader:Ljava/lang/ClassLoader;

    return-void
.end method

# virtual methods
.method public run()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    iget-object v0, p0, Lcom/prometheus/camera/rev/CameraV51Bridge$77;->val$loader:Ljava/lang/ClassLoader;

    invoke-static {v0}, Lcom/prometheus/camera/rev/PhoenixMasterLiveTailBridge;->install(Ljava/lang/ClassLoader;)V

    return-void
.end method