.class public final Lcom/prometheus/camera/rev/PresetLutInstaller;
.super Ljava/lang/Object;
.source "PresetLutInstaller.java"


# static fields
.field private static final DST_DIR:Ljava/lang/String; = "prometheus/preset_luts"

.field private static final MODULE_PKG:Ljava/lang/String; = "com.prometheus.camera.rev"

.field private static final SRC_DIR:Ljava/lang/String; = "prometheus/lut-presets"

.field private static final TAG:Ljava/lang/String; = "PrometheusRev"

.field private static sDone:Z


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 28
    return-void
.end method

.method public static declared-synchronized install(Landroid/content/Context;)V
    .locals 14

    const-class v0, Lcom/prometheus/camera/rev/PresetLutInstaller;

    monitor-enter v0

    .line 31
    :try_start_0
    sget-boolean v1, Lcom/prometheus/camera/rev/PresetLutInstaller;->sDone:Z

    if-nez v1, :cond_a

    if-nez p0, :cond_0

    goto/16 :goto_a

    .line 34
    :cond_0
    const/4 v1, 0x1

    sput-boolean v1, Lcom/prometheus/camera/rev/PresetLutInstaller;->sDone:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_8

    .line 36
    :try_start_1
    new-instance v1, Ljava/io/File;

    invoke-virtual {p0}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v2

    const-string v3, "prometheus/preset_luts"

    invoke-direct {v1, v2, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 37
    invoke-virtual {v1}, Ljava/io/File;->isDirectory()Z

    move-result v2

    if-nez v2, :cond_1

    invoke-virtual {v1}, Ljava/io/File;->mkdirs()Z

    move-result v2

    if-nez v2, :cond_1

    .line 38
    const-string p0, "PrometheusRev"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "preset luts: cannot create "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {p0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_7

    .line 39
    monitor-exit v0

    return-void

    .line 41
    :cond_1
    :try_start_2
    const-string v2, "com.prometheus.camera.rev"

    const/4 v3, 0x0

    invoke-virtual {p0, v2, v3}, Landroid/content/Context;->createPackageContext(Ljava/lang/String;I)Landroid/content/Context;

    move-result-object p0

    .line 42
    invoke-virtual {p0}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object p0

    .line 43
    const-string v2, "prometheus/lut-presets"

    invoke-virtual {p0, v2}, Landroid/content/res/AssetManager;->list(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    .line 44
    if-eqz v2, :cond_9

    array-length v4, v2

    if-nez v4, :cond_2

    goto/16 :goto_8

    .line 48
    :cond_2
    const/16 v4, 0x2000

    new-array v4, v4, [B

    .line 49
    nop

    .line 50
    array-length v5, v2

    move v6, v3

    move v7, v6

    :goto_0
    if-ge v6, v5, :cond_8

    aget-object v8, v2, v6

    .line 51
    new-instance v9, Ljava/io/File;

    invoke-direct {v9, v1, v8}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 52
    invoke-virtual {v9}, Ljava/io/File;->isFile()Z

    move-result v10

    if-eqz v10, :cond_3

    invoke-virtual {v9}, Ljava/io/File;->length()J

    move-result-wide v10
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_7

    const-wide/16 v12, 0x0

    cmp-long v10, v10, v12

    if-lez v10, :cond_3

    .line 53
    goto :goto_3

    .line 55
    :cond_3
    nop

    .line 56
    nop

    .line 58
    const/4 v10, 0x0

    :try_start_3
    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "prometheus/lut-presets/"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {p0, v8}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v8
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_4

    .line 59
    :try_start_4
    new-instance v11, Ljava/io/FileOutputStream;

    invoke-direct {v11, v9}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_3

    .line 61
    :goto_1
    :try_start_5
    invoke-virtual {v8, v4}, Ljava/io/InputStream;->read([B)I

    move-result v9

    if-lez v9, :cond_4

    .line 62
    invoke-virtual {v11, v4, v3, v9}, Ljava/io/FileOutputStream;->write([BII)V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_2

    goto :goto_1

    .line 64
    :cond_4
    add-int/lit8 v7, v7, 0x1

    .line 66
    if-eqz v8, :cond_5

    .line 67
    :try_start_6
    invoke-virtual {v8}, Ljava/io/InputStream;->close()V
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_0

    goto :goto_2

    :catchall_0
    move-exception v8

    .line 69
    :cond_5
    :goto_2
    nop

    .line 70
    :try_start_7
    invoke-virtual {v11}, Ljava/io/FileOutputStream;->close()V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    goto :goto_3

    :catchall_1
    move-exception v8

    .line 50
    :goto_3
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 66
    :catchall_2
    move-exception p0

    goto :goto_4

    :catchall_3
    move-exception p0

    move-object v11, v10

    :goto_4
    move-object v10, v8

    goto :goto_5

    :catchall_4
    move-exception p0

    move-object v11, v10

    :goto_5
    if-eqz v10, :cond_6

    .line 67
    :try_start_8
    invoke-virtual {v10}, Ljava/io/InputStream;->close()V
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_5

    goto :goto_6

    :catchall_5
    move-exception v1

    .line 69
    :cond_6
    :goto_6
    if-eqz v11, :cond_7

    .line 70
    :try_start_9
    invoke-virtual {v11}, Ljava/io/FileOutputStream;->close()V
    :try_end_9
    .catchall {:try_start_9 .. :try_end_9} :catchall_6

    goto :goto_7

    :catchall_6
    move-exception v1

    .line 72
    :cond_7
    :goto_7
    :try_start_a
    throw p0

    .line 74
    :cond_8
    const-string p0, "PrometheusRev"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "preset luts: total="

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    array-length v2, v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " copied="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {p0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 77
    goto :goto_9

    .line 45
    :cond_9
    :goto_8
    const-string p0, "PrometheusRev"

    const-string v1, "preset luts: empty asset list"

    invoke-static {p0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_7

    .line 46
    monitor-exit v0

    return-void

    .line 75
    :catchall_7
    move-exception p0

    .line 76
    :try_start_b
    const-string v1, "PrometheusRev"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "preset luts: failed "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_8

    .line 78
    :goto_9
    monitor-exit v0

    return-void

    .line 32
    :cond_a
    :goto_a
    monitor-exit v0

    return-void

    .line 30
    :catchall_8
    move-exception p0

    monitor-exit v0

    throw p0
.end method
