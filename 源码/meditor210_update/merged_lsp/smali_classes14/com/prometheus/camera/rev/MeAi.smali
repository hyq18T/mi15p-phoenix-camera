.class public final Lcom/prometheus/camera/rev/MeAi;
.super Ljava/lang/Object;
.source "MeAi.java"


# static fields
.field private static final AI_ACTIONS:[Ljava/lang/String;

.field private static final AI_BRAND:Ljava/lang/String; = "Xiaomi"

.field private static final AI_DEVICE:Ljava/lang/String; = "madrid"

.field private static final AI_MANUFACTURER:Ljava/lang/String; = "Xiaomi"

.field private static final AI_METHODS:[Ljava/lang/String;

.field private static final AI_MODEL:Ljava/lang/String; = "24069RA21C"

.field private static final AI_PRODUCT:Ljava/lang/String; = "madrid"

.field private static final FIELDS:[Ljava/lang/String;

.field private static final ORIGINAL:[Ljava/lang/String;

.field private static final TAG:Ljava/lang/String; = "PrometheusRev"

.field private static sCaptured:Z


# direct methods
.method static constructor <clinit>()V
    .locals 23

    .line 23
    const-string v0, "BRAND"

    const-string v1, "MANUFACTURER"

    const-string v2, "DEVICE"

    const-string v3, "PRODUCT"

    const-string v4, "MODEL"

    filled-new-array {v2, v3, v4, v0, v1}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/prometheus/camera/rev/MeAi;->FIELDS:[Ljava/lang/String;

    .line 24
    sget-object v0, Lcom/prometheus/camera/rev/MeAi;->FIELDS:[Ljava/lang/String;

    array-length v0, v0

    new-array v0, v0, [Ljava/lang/String;

    sput-object v0, Lcom/prometheus/camera/rev/MeAi;->ORIGINAL:[Ljava/lang/String;

    .line 32
    const-string v11, "method_is_device_support_capabilities"

    const-string v12, "action_support"

    const-string v1, "method_is_device_support_magic_matting"

    const-string v2, "method_is_outpaint_available"

    const-string v3, "method_is_remover_available"

    const-string v4, "method_is_remove_glare_available"

    const-string v5, "method_is_art_still_available"

    const-string v6, "method_is_magic_sky_available"

    const-string v7, "method_is_id_photo_available"

    const-string v8, "method_is_mishow_magic_matting_available"

    const-string v9, "method_is_auto_adjust_available"

    const-string v10, "method_is_magic_matting_available"

    filled-new-array/range {v1 .. v12}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/prometheus/camera/rev/MeAi;->AI_METHODS:[Ljava/lang/String;

    .line 47
    const-string v21, "/photo/enhance-extra]"

    const-string v22, "/photo/beautification]"

    const-string v1, "/photo/auto-beauty]"

    const-string v2, "/photo/face-beauty]"

    const-string v3, "/photo/face-beauty-acne]"

    const-string v4, "/photo/face-beauty-skin]"

    const-string v5, "/photo/face-shape]"

    const-string v6, "/photo/face-shape-extra]"

    const-string v7, "/photo/body-beauty]"

    const-string v8, "/photo/body-beauty-slim]"

    const-string v9, "/photo/body-beauty-extra]"

    const-string v10, "/photo/virtualization-portrait]"

    const-string v11, "/photo/magic-sky]"

    const-string v12, "/photo/reflection-eliminate]"

    const-string v13, "/photo/super-portrait]"

    const-string v14, "/photo/image-quality-restoration]"

    const-string v15, "/photo/ai-cloud-function]"

    const-string v16, "/photo/ai-cloud-function-super-editor]"

    const-string v17, "/photo/hsl]"

    const-string v18, "/photo/enhance]"

    const-string v19, "/photo/de-noise]"

    const-string v20, "/photo/posterize]"

    filled-new-array/range {v1 .. v22}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/prometheus/camera/rev/MeAi;->AI_ACTIONS:[Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 74
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 75
    return-void
.end method

.method public static declared-synchronized applyPermanent()V
    .locals 4

    const-class v0, Lcom/prometheus/camera/rev/MeAi;

    monitor-enter v0

    .line 112
    :try_start_0
    invoke-static {}, Lcom/prometheus/camera/rev/MeAi;->capture()V

    .line 113
    const/4 v1, 0x0

    :goto_0
    sget-object v2, Lcom/prometheus/camera/rev/MeAi;->FIELDS:[Ljava/lang/String;

    array-length v2, v2

    if-ge v1, v2, :cond_4

    .line 114
    sget-object v2, Lcom/prometheus/camera/rev/MeAi;->FIELDS:[Ljava/lang/String;

    aget-object v2, v2, v1

    if-nez v1, :cond_0

    const-string v3, "madrid"

    goto :goto_1

    .line 115
    :cond_0
    const/4 v3, 0x1

    if-ne v1, v3, :cond_1

    const-string v3, "madrid"

    goto :goto_1

    .line 116
    :cond_1
    const/4 v3, 0x2

    if-ne v1, v3, :cond_2

    const-string v3, "24069RA21C"

    goto :goto_1

    .line 117
    :cond_2
    const/4 v3, 0x3

    if-ne v1, v3, :cond_3

    const-string v3, "Xiaomi"

    goto :goto_1

    .line 118
    :cond_3
    const-string v3, "Xiaomi"

    .line 114
    :goto_1
    invoke-static {v2, v3}, Lcom/prometheus/camera/rev/MeAi;->setStatic(Ljava/lang/String;Ljava/lang/String;)V

    .line 113
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 120
    :cond_4
    const-string v1, "PrometheusRev"

    const-string v2, "ai profile permanent: 24069RA21C/madrid"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 121
    monitor-exit v0

    return-void

    .line 111
    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method private static capture()V
    .locals 3

    .line 145
    sget-boolean v0, Lcom/prometheus/camera/rev/MeAi;->sCaptured:Z

    if-eqz v0, :cond_0

    .line 146
    return-void

    .line 148
    :cond_0
    const/4 v0, 0x0

    :goto_0
    sget-object v1, Lcom/prometheus/camera/rev/MeAi;->FIELDS:[Ljava/lang/String;

    array-length v1, v1

    if-ge v0, v1, :cond_1

    .line 149
    sget-object v1, Lcom/prometheus/camera/rev/MeAi;->ORIGINAL:[Ljava/lang/String;

    sget-object v2, Lcom/prometheus/camera/rev/MeAi;->FIELDS:[Ljava/lang/String;

    aget-object v2, v2, v0

    invoke-static {v2}, Lcom/prometheus/camera/rev/MeAi;->readStatic(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v1, v0

    .line 148
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 151
    :cond_1
    const/4 v0, 0x1

    sput-boolean v0, Lcom/prometheus/camera/rev/MeAi;->sCaptured:Z

    .line 152
    return-void
.end method

.method public static fixProviderResult(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2

    .line 129
    instance-of v0, p0, Landroid/os/Bundle;

    if-eqz v0, :cond_3

    instance-of v0, p1, Ljava/lang/String;

    if-nez v0, :cond_0

    goto :goto_0

    .line 132
    :cond_0
    move-object v0, p0

    check-cast v0, Landroid/os/Bundle;

    .line 133
    check-cast p1, Ljava/lang/String;

    .line 134
    const-string v1, "action_support"

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    .line 135
    const/4 p0, 0x0

    invoke-virtual {v0, v1, p0}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result p0

    if-nez p0, :cond_1

    .line 136
    const-string p0, "PrometheusRev"

    const-string p1, "action_support forced true"

    invoke-static {p0, p1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 138
    :cond_1
    const/4 p0, 0x1

    invoke-virtual {v0, v1, p0}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 139
    return-object v0

    .line 141
    :cond_2
    return-object p0

    .line 130
    :cond_3
    :goto_0
    return-object p0
.end method

.method public static isAiAction(Ljava/lang/Object;)Z
    .locals 5

    .line 93
    instance-of v0, p0, Ljava/lang/String;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 94
    return v1

    .line 96
    :cond_0
    check-cast p0, Ljava/lang/String;

    .line 97
    sget-object v0, Lcom/prometheus/camera/rev/MeAi;->AI_ACTIONS:[Ljava/lang/String;

    array-length v2, v0

    move v3, v1

    :goto_0
    if-ge v3, v2, :cond_2

    aget-object v4, v0, v3

    .line 98
    invoke-virtual {p0, v4}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 99
    const/4 p0, 0x1

    return p0

    .line 97
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 102
    :cond_2
    return v1
.end method

.method public static isAiMethod(Ljava/lang/Object;)Z
    .locals 5

    .line 79
    instance-of v0, p0, Ljava/lang/String;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 80
    return v1

    .line 82
    :cond_0
    check-cast p0, Ljava/lang/String;

    .line 83
    sget-object v0, Lcom/prometheus/camera/rev/MeAi;->AI_METHODS:[Ljava/lang/String;

    array-length v2, v0

    move v3, v1

    :goto_0
    if-ge v3, v2, :cond_2

    aget-object v4, v0, v3

    .line 84
    invoke-virtual {v4, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 85
    const/4 p0, 0x1

    return p0

    .line 83
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 88
    :cond_2
    return v1
.end method

.method private static readStatic(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    .line 156
    const/4 v0, 0x0

    :try_start_0
    const-class v1, Landroid/os/Build;

    invoke-virtual {v1, p0}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object p0

    .line 157
    const/4 v1, 0x1

    invoke-virtual {p0, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 158
    invoke-virtual {p0, v0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .line 159
    instance-of v1, p0, Ljava/lang/String;

    if-eqz v1, :cond_0

    check-cast p0, Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object v0, p0

    :cond_0
    return-object v0

    .line 160
    :catchall_0
    move-exception p0

    .line 161
    return-object v0
.end method

.method private static setStatic(Ljava/lang/String;Ljava/lang/String;)V
    .locals 11

    .line 166
    const-string v0, "PrometheusRev"

    if-nez p1, :cond_0

    .line 167
    return-void

    .line 171
    :cond_0
    :try_start_0
    const-class v1, Landroid/os/Build;

    invoke-virtual {v1, p0}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    .line 174
    nop

    .line 176
    const/4 v2, 0x0

    const/4 v3, 0x1

    :try_start_1
    invoke-virtual {v1}, Ljava/lang/reflect/Field;->getModifiers()I

    move-result v4

    invoke-static {v4}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v4

    if-nez v4, :cond_1

    .line 177
    return-void

    .line 179
    :cond_1
    invoke-virtual {v1, v3}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 180
    invoke-virtual {v1, v2, p1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 181
    return-void

    .line 182
    :catchall_0
    move-exception v4

    .line 186
    :try_start_2
    const-string v4, "sun.misc.Unsafe"

    invoke-static {v4}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v4

    .line 187
    const-string v5, "theUnsafe"

    invoke-virtual {v4, v5}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v5

    .line 188
    invoke-virtual {v5, v3}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 189
    invoke-virtual {v5, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    .line 190
    const-string v6, "objectFieldOffset"

    const-class v7, Ljava/lang/reflect/Field;

    filled-new-array {v7}, [Ljava/lang/Class;

    move-result-object v7

    invoke-virtual {v4, v6, v7}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v6

    .line 191
    const-string v7, "putObject"

    const-class v8, Ljava/lang/Object;

    sget-object v9, Ljava/lang/Long;->TYPE:Ljava/lang/Class;

    const-class v10, Ljava/lang/Object;

    filled-new-array {v8, v9, v10}, [Ljava/lang/Class;

    move-result-object v8

    invoke-virtual {v4, v7, v8}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    .line 192
    invoke-virtual {v1, v3}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 193
    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v6, v5, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Number;

    invoke-virtual {v1}, Ljava/lang/Number;->longValue()J

    move-result-wide v6

    .line 194
    invoke-static {v6, v7}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    filled-new-array {v2, v1, p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-virtual {v4, v5, p1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    .line 195
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "static set via unsafe: "

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    .line 198
    goto :goto_0

    .line 196
    :catchall_1
    move-exception p1

    .line 197
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "cannot set static "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v1, ": "

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v0, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 199
    :goto_0
    return-void

    .line 172
    :catchall_2
    move-exception p0

    .line 173
    return-void
.end method
