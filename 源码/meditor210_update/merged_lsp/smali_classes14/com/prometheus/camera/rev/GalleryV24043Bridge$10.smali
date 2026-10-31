.class Lcom/prometheus/camera/rev/GalleryV24043Bridge$10;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "GalleryV24043Bridge.java"


# instance fields
.field private final tag:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    iput-object p1, p0, Lcom/prometheus/camera/rev/GalleryV24043Bridge$10;->tag:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method protected afterHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 3

    invoke-virtual {p1}, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->getResult()Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/prometheus/camera/rev/MeProbe;->append(Ljava/lang/Object;)V

    iget-object v1, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->thisObject:Ljava/lang/Object;

    invoke-static {v1, v0}, Lcom/prometheus/camera/rev/MeProbe;->publish(Ljava/lang/Object;Ljava/lang/Object;)V

    iget-object v1, p0, Lcom/prometheus/camera/rev/GalleryV24043Bridge$10;->tag:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/prometheus/camera/rev/MeProbe;->any(Ljava/lang/Object;Ljava/lang/String;)V

    return-void
.end method
