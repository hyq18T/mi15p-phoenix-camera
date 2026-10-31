.class Lcom/prometheus/camera/rev/GalleryV24043Bridge$11;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "GalleryV24043Bridge.java"


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 1

    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/prometheus/camera/rev/MeProbe;->append(Ljava/lang/Object;)V

    return-void
.end method
