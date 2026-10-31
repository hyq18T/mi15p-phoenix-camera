.class public final Lcom/prometheus/camera/rev/MediaEditorAnchors;
.super Ljava/lang/Object;
.source "MediaEditorAnchors.java"


# static fields
.field public static CATALOG:Ljava/lang/String;

.field public static FLOW_OBSERVER:Ljava/lang/String;

.field public static FLOW_OBSERVER2:Ljava/lang/String;

.field public static LOADER:Ljava/lang/ClassLoader;

.field public static MODEL_BASE:Ljava/lang/String;

.field public static MODEL_BIG:Ljava/lang/String;

.field public static MODEL_CATEGORY:Ljava/lang/String;

.field public static MODEL_WRAP:Ljava/lang/String;

.field public static PATH_RESOLVER:Ljava/lang/String;

.field public static WM_ACTION:Ljava/lang/String;

.field public static WM_BITMAP:Ljava/lang/String;

.field public static WM_CATALOG_ITEM:Ljava/lang/String;

.field public static WM_DB:Ljava/lang/String;

.field public static WM_ENTRY:Ljava/lang/String;

.field public static WM_H:Ljava/lang/String;

.field public static WM_LIST:Ljava/lang/String;

.field public static WM_MISC1:Ljava/lang/String;

.field public static WM_MISC2:Ljava/lang/String;

.field public static WM_MISC3:Ljava/lang/String;

.field public static WM_MISC4:Ljava/lang/String;

.field public static WM_RENDERER:Ljava/lang/String;

.field public static WM_SELECT_GUARD:Ljava/lang/String;

.field public static WM_V:Ljava/lang/String;

.field public static WRITER:Ljava/lang/String;

.field public static WRITER_HOST_FIELD:Ljava/lang/String;

.field public static WRITER_LIST_FIELD:Ljava/lang/String;

.field public static WRITER_METHOD:Ljava/lang/String;

.field private static inited:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "Ob.l"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->PATH_RESOLVER:Ljava/lang/String;

    const-string v0, "qd.i"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->CATALOG:Ljava/lang/String;

    const-string v0, "Bd.i$a"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WRITER:Ljava/lang/String;

    const-string v0, "b"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WRITER_LIST_FIELD:Ljava/lang/String;

    const-string v0, "invokeSuspend"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WRITER_METHOD:Ljava/lang/String;

    const-string v0, "e00.d"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->FLOW_OBSERVER:Ljava/lang/String;

    const-string v0, "e00.e"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->FLOW_OBSERVER2:Ljava/lang/String;

    const-string v0, "a"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WRITER_HOST_FIELD:Ljava/lang/String;

    const-string v0, "ud.h"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->MODEL_BIG:Ljava/lang/String;

    const-string v0, "ud.b"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->MODEL_CATEGORY:Ljava/lang/String;

    const-string v0, "ud.e"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->MODEL_WRAP:Ljava/lang/String;

    const-string v0, "ud.a"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->MODEL_BASE:Ljava/lang/String;

    const-string v0, "on.a"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_ACTION:Ljava/lang/String;

    const-string v0, "Qn.a$a"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_CATALOG_ITEM:Ljava/lang/String;

    const-string v0, "mb.a"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_DB:Ljava/lang/String;

    const-string v0, "Bg.a$a"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_MISC1:Ljava/lang/String;

    const-string v0, "Fg.b"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_MISC2:Ljava/lang/String;

    const-string v0, "jb.a"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_MISC3:Ljava/lang/String;

    const-string v0, "kh.d"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_MISC4:Ljava/lang/String;

    const-string v0, "kh.e"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_ENTRY:Ljava/lang/String;

    const-string v0, "com.xiaomi.cam.watermark.c"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_RENDERER:Ljava/lang/String;

    const-string v0, "vg.q"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_LIST:Ljava/lang/String;

    const-string v0, "vg.h"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_H:Ljava/lang/String;

    const-string v0, "vg.v$a"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_V:Ljava/lang/String;

    const-string v0, "S3.b"

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_BITMAP:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static categoryCtor(Ljava/lang/Class;)Ljava/lang/reflect/Constructor;
    .locals 6

    invoke-virtual {p0}, Ljava/lang/Class;->getDeclaredConstructors()[Ljava/lang/reflect/Constructor;

    move-result-object v0

    const/4 v1, 0x0

    aget-object v1, v0, v1

    const/4 v2, 0x1

    :goto_0
    array-length v3, v0

    if-ge v2, v3, :cond_1

    aget-object v3, v0, v2

    invoke-virtual {v3}, Ljava/lang/reflect/Constructor;->getParameterCount()I

    move-result v4

    invoke-virtual {v1}, Ljava/lang/reflect/Constructor;->getParameterCount()I

    move-result v5

    if-le v4, v5, :cond_0

    move-object v1, v3

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    return-object v1
.end method

.method private static exists(Ljava/lang/String;Ljava/lang/ClassLoader;)Z
    .locals 2

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    :try_start_0
    invoke-static {p0, v0, p1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v0, 0x1

    :catch_0
    :cond_0
    return v0
.end method

.method public static init(Ljava/lang/ClassLoader;)V
    .locals 3

    const-string v2, "PrometheusRev: anchors enter"

    invoke-static {v2}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;)V

    sget-boolean v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->inited:Z

    if-nez v0, :cond_11

    const/4 v0, 0x1

    sput-boolean v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->inited:Z

    sput-object p0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->LOADER:Ljava/lang/ClassLoader;

    const-string v0, "av.n"

    invoke-static {v0, p0}, Lcom/prometheus/camera/rev/MediaEditorAnchors;->exists(Ljava/lang/String;Ljava/lang/ClassLoader;)Z

    move-result v1

    if-eqz v1, :cond_0

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->PATH_RESOLVER:Ljava/lang/String;

    :cond_0
    const-string v0, "wz.j"

    invoke-static {v0, p0}, Lcom/prometheus/camera/rev/MediaEditorAnchors;->exists(Ljava/lang/String;Ljava/lang/ClassLoader;)Z

    move-result v1

    if-eqz v1, :cond_1

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->CATALOG:Ljava/lang/String;

    :cond_1
    const-string v0, "h00.j$a"

    invoke-static {v0, p0}, Lcom/prometheus/camera/rev/MediaEditorAnchors;->exists(Ljava/lang/String;Ljava/lang/ClassLoader;)Z

    move-result v1

    if-eqz v1, :cond_2

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WRITER:Ljava/lang/String;

    const-string v2, "f"

    sput-object v2, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WRITER_LIST_FIELD:Ljava/lang/String;

    const-string v2, "y"

    sput-object v2, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WRITER_METHOD:Ljava/lang/String;

    const-string v2, "e"

    sput-object v2, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WRITER_HOST_FIELD:Ljava/lang/String;

    :cond_2
    const-string v0, "a00.j"

    invoke-static {v0, p0}, Lcom/prometheus/camera/rev/MediaEditorAnchors;->exists(Ljava/lang/String;Ljava/lang/ClassLoader;)Z

    move-result v1

    if-eqz v1, :cond_3

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->MODEL_BIG:Ljava/lang/String;

    :cond_3
    const-string v0, "a00.c"

    invoke-static {v0, p0}, Lcom/prometheus/camera/rev/MediaEditorAnchors;->exists(Ljava/lang/String;Ljava/lang/ClassLoader;)Z

    move-result v1

    if-eqz v1, :cond_4

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->MODEL_CATEGORY:Ljava/lang/String;

    :cond_4
    const-string v0, "a00.f"

    invoke-static {v0, p0}, Lcom/prometheus/camera/rev/MediaEditorAnchors;->exists(Ljava/lang/String;Ljava/lang/ClassLoader;)Z

    move-result v1

    if-eqz v1, :cond_5

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->MODEL_WRAP:Ljava/lang/String;

    :cond_5
    const-string v0, "a00.a"

    invoke-static {v0, p0}, Lcom/prometheus/camera/rev/MediaEditorAnchors;->exists(Ljava/lang/String;Ljava/lang/ClassLoader;)Z

    move-result v1

    if-eqz v1, :cond_6

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->MODEL_BASE:Ljava/lang/String;

    :cond_6
    const-string v0, "p80.g"

    invoke-static {v0, p0}, Lcom/prometheus/camera/rev/MediaEditorAnchors;->exists(Ljava/lang/String;Ljava/lang/ClassLoader;)Z

    move-result v1

    if-eqz v1, :cond_7

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_ENTRY:Ljava/lang/String;

    :cond_7
    const-string v0, "p80.f"

    invoke-static {v0, p0}, Lcom/prometheus/camera/rev/MediaEditorAnchors;->exists(Ljava/lang/String;Ljava/lang/ClassLoader;)Z

    move-result v1

    if-eqz v1, :cond_8

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_MISC4:Ljava/lang/String;

    :cond_8
    const-string v0, "com.xiaomi.cam.watermark.b"

    invoke-static {v0, p0}, Lcom/prometheus/camera/rev/MediaEditorAnchors;->exists(Ljava/lang/String;Ljava/lang/ClassLoader;)Z

    move-result v1

    if-eqz v1, :cond_9

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_RENDERER:Ljava/lang/String;

    :cond_9
    const-string v0, "x60.y0"

    invoke-static {v0, p0}, Lcom/prometheus/camera/rev/MediaEditorAnchors;->exists(Ljava/lang/String;Ljava/lang/ClassLoader;)Z

    move-result v1

    if-eqz v1, :cond_a

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_LIST:Ljava/lang/String;

    :cond_a
    const-string v0, "x60.n"

    invoke-static {v0, p0}, Lcom/prometheus/camera/rev/MediaEditorAnchors;->exists(Ljava/lang/String;Ljava/lang/ClassLoader;)Z

    move-result v1

    if-eqz v1, :cond_b

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_H:Ljava/lang/String;

    :cond_b
    const-string v0, "x60.j1$a"

    invoke-static {v0, p0}, Lcom/prometheus/camera/rev/MediaEditorAnchors;->exists(Ljava/lang/String;Ljava/lang/ClassLoader;)Z

    move-result v1

    if-eqz v1, :cond_c

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_V:Ljava/lang/String;

    :cond_c
    const-string v0, "qc.b"

    invoke-static {v0, p0}, Lcom/prometheus/camera/rev/MediaEditorAnchors;->exists(Ljava/lang/String;Ljava/lang/ClassLoader;)Z

    move-result v1

    if-eqz v1, :cond_d

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_BITMAP:Ljava/lang/String;

    :cond_d
    const-string v0, "j70.d"

    invoke-static {v0, p0}, Lcom/prometheus/camera/rev/MediaEditorAnchors;->exists(Ljava/lang/String;Ljava/lang/ClassLoader;)Z

    move-result v1

    if-eqz v1, :cond_e

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_MISC2:Ljava/lang/String;

    :cond_e
    const-string v0, "yn0.a$a"

    invoke-static {v0, p0}, Lcom/prometheus/camera/rev/MediaEditorAnchors;->exists(Ljava/lang/String;Ljava/lang/ClassLoader;)Z

    move-result v1

    if-eqz v1, :cond_f

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_CATALOG_ITEM:Ljava/lang/String;

    :cond_f
    const-string v0, "x60.f1"

    invoke-static {v0, p0}, Lcom/prometheus/camera/rev/MediaEditorAnchors;->exists(Ljava/lang/String;Ljava/lang/ClassLoader;)Z

    move-result v1

    if-eqz v1, :cond_10

    sput-object v0, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_SELECT_GUARD:Ljava/lang/String;

    :cond_10
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "PrometheusRev: anchors path="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v1, Lcom/prometheus/camera/rev/MediaEditorAnchors;->PATH_RESOLVER:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " catalog="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Lcom/prometheus/camera/rev/MediaEditorAnchors;->CATALOG:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " category="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Lcom/prometheus/camera/rev/MediaEditorAnchors;->MODEL_CATEGORY:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " writer="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WRITER:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, " wm="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_ENTRY:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_LIST:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_V:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Lcom/prometheus/camera/rev/MediaEditorAnchors;->WM_RENDERER:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/prometheus/camera/rev/FeatureEntryPoint;->logExternal(Ljava/lang/String;)V

    :cond_11
    return-void
.end method

.method public static newCategory(Ljava/lang/reflect/Constructor;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    invoke-virtual {p0}, Ljava/lang/reflect/Constructor;->getParameterTypes()[Ljava/lang/Class;

    move-result-object v0

    const/4 v1, 0x0

    aget-object v0, v0, v1

    const-class v1, Ljava/util/List;

    if-ne v0, v1, :cond_0

    const/4 v0, 0x5

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v1, 0x4

    aget-object v2, p1, v1

    const/4 v1, 0x0

    aput-object v2, v0, v1

    aget-object v2, p1, v1

    const/4 v1, 0x1

    aput-object v2, v0, v1

    aget-object v2, p1, v1

    const/4 v1, 0x2

    aput-object v2, v0, v1

    const/4 v1, 0x3

    aget-object v2, p1, v1

    const/4 v1, 0x3

    aput-object v2, v0, v1

    const/4 v1, 0x2

    aget-object v2, p1, v1

    const/4 v1, 0x4

    aput-object v2, v0, v1

    invoke-virtual {p0, v0}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0

    :cond_0
    invoke-virtual {p0, p1}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static newWrap(Ljava/lang/reflect/Constructor;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 7
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    invoke-virtual {p0}, Ljava/lang/reflect/Constructor;->getParameterCount()I

    move-result v0

    array-length v1, p1

    if-ne v0, v1, :cond_1

    new-array v2, v0, [Ljava/lang/Object;

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_0

    aget-object v4, p1, v3

    aput-object v4, v2, v3

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Ljava/lang/reflect/Constructor;->getParameterTypes()[Ljava/lang/Class;

    move-result-object v3

    add-int/lit8 v4, v0, -0x1

    aget-object v3, v3, v4

    const/4 v5, 0x0

    new-array v5, v5, [Ljava/lang/Class;

    invoke-virtual {v3, v5}, Ljava/lang/Class;->getDeclaredConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v3

    const/4 v6, 0x0

    new-array v6, v6, [Ljava/lang/Object;

    invoke-virtual {v3, v6}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    aput-object v3, v2, v4

    invoke-virtual {p0, v2}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0

    :cond_1
    invoke-virtual {p0, p1}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public static wrapCtor(Ljava/lang/Class;)Ljava/lang/reflect/Constructor;
    .locals 1

    invoke-static {p0}, Lcom/prometheus/camera/rev/MediaEditorAnchors;->categoryCtor(Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v0

    return-object v0
.end method
