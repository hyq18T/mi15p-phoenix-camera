.class Lcom/prometheus/camera/rev/GalleryV24043Bridge$9;
.super Lde/robv/android/xposed/XC_MethodHook;
.source "GalleryV24043Bridge.java"


# instance fields
.field private final tag:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Lde/robv/android/xposed/XC_MethodHook;-><init>()V

    iput-object p1, p0, Lcom/prometheus/camera/rev/GalleryV24043Bridge$9;->tag:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method protected beforeHookedMethod(Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;)V
    .locals 2

    iget-object v0, p1, Lde/robv/android/xposed/XC_MethodHook$MethodHookParam;->args:[Ljava/lang/Object;

    const/4 v1, 0x0

    aget-object v0, v0, v1

    iget-object v1, p0, Lcom/prometheus/camera/rev/GalleryV24043Bridge$9;->tag:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/prometheus/camera/rev/MeProbe;->list(Ljava/lang/Object;Ljava/lang/String;)V

    return-void
.end method
