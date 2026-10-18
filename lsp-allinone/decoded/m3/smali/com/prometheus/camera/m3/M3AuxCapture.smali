.class final Lcom/prometheus/camera/m3/M3AuxCapture;
.super Ljava/lang/Object;
.source "M3AuxCapture.java"


# instance fields
.field final height:I

.field final jpeg:[B

.field final orientation:I

.field final sensorTimestamp:J

.field private final staging:Ljava/io/File;

.field final width:I


# direct methods
.method private constructor <init>(Ljava/io/File;[BIIIJ)V
    .locals 0

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 24
    iput-object p1, p0, Lcom/prometheus/camera/m3/M3AuxCapture;->staging:Ljava/io/File;

    iput-object p2, p0, Lcom/prometheus/camera/m3/M3AuxCapture;->jpeg:[B

    iput p3, p0, Lcom/prometheus/camera/m3/M3AuxCapture;->width:I

    iput p4, p0, Lcom/prometheus/camera/m3/M3AuxCapture;->height:I

    .line 25
    iput p5, p0, Lcom/prometheus/camera/m3/M3AuxCapture;->orientation:I

    iput-wide p6, p0, Lcom/prometheus/camera/m3/M3AuxCapture;->sensorTimestamp:J

    .line 26
    return-void
.end method

.method static read(Ljava/lang/String;)Lcom/prometheus/camera/m3/M3AuxCapture;
    .locals 18
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 29
    move-object/from16 v1, p0

    if-eqz v1, :cond_a

    const-string v0, "[A-Za-z0-9_.-]+\\.jpg"

    invoke-virtual {v1, v0}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_a

    .line 31
    new-instance v0, Ljava/io/File;

    invoke-static {}, Landroid/app/AndroidAppHelper;->currentApplication()Landroid/app/Application;

    move-result-object v2

    invoke-virtual {v2}, Landroid/app/Application;->getFilesDir()Ljava/io/File;

    move-result-object v2

    const-string v3, "phoenix_m3_aux"

    invoke-direct {v0, v2, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 32
    new-instance v2, Ljava/io/File;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ".aux"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v0, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 33
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    const-wide/16 v5, 0xfa0

    add-long/2addr v3, v5

    .line 34
    :goto_0
    invoke-virtual {v2}, Ljava/io/File;->isFile()Z

    move-result v0

    if-nez v0, :cond_0

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v5

    cmp-long v0, v5, v3

    if-gez v0, :cond_0

    const-wide/16 v5, 0x19

    invoke-static {v5, v6}, Ljava/lang/Thread;->sleep(J)V

    goto :goto_0

    .line 35
    :cond_0
    invoke-virtual {v2}, Ljava/io/File;->isFile()Z

    move-result v0

    if-eqz v0, :cond_9

    .line 36
    :try_start_0
    new-instance v3, Ljava/io/FileInputStream;

    invoke-direct {v3, v2}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 37
    const/16 v0, 0xa8

    :try_start_1
    new-array v0, v0, [B

    .line 38
    invoke-static {v3, v0}, Lcom/prometheus/camera/m3/M3AuxCapture;->readFully(Ljava/io/FileInputStream;[B)V

    .line 39
    invoke-static {v0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    sget-object v4, Ljava/nio/ByteOrder;->LITTLE_ENDIAN:Ljava/nio/ByteOrder;

    invoke-virtual {v0, v4}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 40
    const/16 v4, 0x8

    new-array v4, v4, [B

    invoke-virtual {v0, v4}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 41
    const-string v5, "PXM3AUX1"

    new-instance v6, Ljava/lang/String;

    sget-object v7, Ljava/nio/charset/StandardCharsets;->US_ASCII:Ljava/nio/charset/Charset;

    invoke-direct {v6, v4, v7}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_7

    .line 43
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v11

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v12

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v7

    .line 44
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v13

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->getLong()J

    move-result-wide v14

    .line 45
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v4

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v5

    .line 46
    const/16 v6, 0x80

    new-array v8, v6, [B

    invoke-virtual {v0, v8}, Ljava/nio/ByteBuffer;->get([B)Ljava/nio/ByteBuffer;

    .line 47
    const/4 v0, 0x0

    move v9, v0

    :goto_1
    if-ge v9, v6, :cond_1

    aget-byte v10, v8, v9

    if-eqz v10, :cond_1

    add-int/lit8 v9, v9, 0x1

    goto :goto_1

    .line 48
    :cond_1
    new-instance v6, Ljava/lang/String;

    sget-object v10, Ljava/nio/charset/StandardCharsets;->US_ASCII:Ljava/nio/charset/Charset;

    invoke-direct {v6, v8, v0, v9, v10}, Ljava/lang/String;-><init>([BIILjava/nio/charset/Charset;)V

    .line 49
    invoke-virtual {v1, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_6

    .line 50
    if-lez v11, :cond_5

    if-lez v12, :cond_5

    and-int/lit8 v6, v11, 0x1

    if-nez v6, :cond_5

    and-int/lit8 v6, v12, 0x1

    if-nez v6, :cond_5

    if-lt v4, v11, :cond_5

    const/16 v4, 0x11

    if-ne v7, v4, :cond_5

    if-ltz v13, :cond_5

    const/16 v4, 0x10e

    if-gt v13, v4, :cond_5

    rem-int/lit8 v4, v13, 0x5a
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_3

    if-nez v4, :cond_5

    int-to-long v8, v11

    int-to-long v0, v12

    mul-long/2addr v8, v0

    const-wide/16 v0, 0x3

    mul-long/2addr v8, v0

    const-wide/16 v0, 0x2

    :try_start_2
    div-long/2addr v8, v0

    int-to-long v0, v5

    cmp-long v6, v8, v0

    if-nez v6, :cond_4

    .line 52
    invoke-virtual {v2}, Ljava/io/File;->length()J

    move-result-wide v8

    const-wide/16 v16, 0xa8

    add-long v0, v0, v16

    cmp-long v0, v8, v0

    if-nez v0, :cond_3

    .line 54
    new-array v6, v5, [B

    invoke-static {v3, v6}, Lcom/prometheus/camera/m3/M3AuxCapture;->readFully(Ljava/io/FileInputStream;[B)V

    .line 55
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    div-int/lit8 v5, v5, 0x4

    invoke-direct {v0, v5}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 56
    new-instance v1, Landroid/graphics/YuvImage;

    const/4 v10, 0x0

    move-object v5, v1

    move v8, v11

    move v9, v12

    invoke-direct/range {v5 .. v10}, Landroid/graphics/YuvImage;-><init>([BIII[I)V

    new-instance v5, Landroid/graphics/Rect;

    const/4 v4, 0x0

    invoke-direct {v5, v4, v4, v11, v12}, Landroid/graphics/Rect;-><init>(IIII)V

    const/16 v4, 0x5a

    invoke-virtual {v1, v5, v4, v0}, Landroid/graphics/YuvImage;->compressToJpeg(Landroid/graphics/Rect;ILjava/io/OutputStream;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 58
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "aux matched image="

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-object/from16 v10, p0

    :try_start_3
    invoke-virtual {v1, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, " sensor="

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v14, v15}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, " size="

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v11}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, "x"

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, " orientation="

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, " jpeg="

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 59
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->size()I

    move-result v4

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 58
    invoke-static {v1}, Lcom/prometheus/camera/m3/M3Runtime;->log(Ljava/lang/String;)V

    .line 60
    new-instance v1, Lcom/prometheus/camera/m3/M3AuxCapture;

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v6
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-object v4, v1

    move-object v5, v2

    move v7, v11

    move v8, v12

    move v9, v13

    move-object v12, v10

    move-wide v10, v14

    :try_start_4
    invoke-direct/range {v4 .. v11}, Lcom/prometheus/camera/m3/M3AuxCapture;-><init>(Ljava/io/File;[BIIIJ)V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 61
    :try_start_5
    invoke-virtual {v3}, Ljava/io/FileInputStream;->close()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_0

    .line 60
    return-object v1

    .line 36
    :catchall_0
    move-exception v0

    move-object v12, v10

    goto :goto_3

    .line 57
    :cond_2
    move-object/from16 v12, p0

    :try_start_6
    new-instance v0, Ljava/io/IOException;

    const-string v1, "M3 aux JPEG encoding failed"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 52
    :cond_3
    move-object/from16 v12, p0

    goto :goto_2

    .line 50
    :cond_4
    move-object/from16 v12, p0

    goto :goto_2

    .line 36
    :catchall_1
    move-exception v0

    move-object/from16 v12, p0

    goto :goto_3

    .line 50
    :cond_5
    move-object v12, v1

    .line 53
    :goto_2
    new-instance v0, Ljava/io/IOException;

    const-string v1, "Invalid M3 aux geometry"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 49
    :cond_6
    move-object v12, v1

    new-instance v0, Ljava/io/IOException;

    const-string v1, "M3 aux capture identity differs"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 42
    :cond_7
    move-object v12, v1

    new-instance v0, Ljava/io/IOException;

    const-string v1, "Invalid M3 aux header"

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    .line 36
    :catchall_2
    move-exception v0

    goto :goto_3

    :catchall_3
    move-exception v0

    move-object v12, v1

    :goto_3
    move-object v1, v0

    :try_start_7
    invoke-virtual {v3}, Ljava/io/FileInputStream;->close()V
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_4

    goto :goto_4

    :catchall_4
    move-exception v0

    move-object v3, v0

    :try_start_8
    invoke-virtual {v1, v3}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_4
    throw v1
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_0

    .line 61
    :catch_0
    move-exception v0

    goto :goto_5

    :catch_1
    move-exception v0

    move-object v12, v1

    .line 62
    :goto_5
    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    move-result v1

    if-nez v1, :cond_8

    new-instance v1, Ljava/io/IOException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "M3 aux cleanup failed: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Ljava/lang/Exception;->addSuppressed(Ljava/lang/Throwable;)V

    .line 63
    :cond_8
    throw v0

    .line 35
    :cond_9
    move-object v12, v1

    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Clean M3 image not delivered: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 29
    :cond_a
    move-object v12, v1

    .line 30
    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Invalid capture image name: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static readFully(Ljava/io/FileInputStream;[B)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 72
    const/4 v0, 0x0

    :goto_0
    array-length v1, p1

    if-ge v0, v1, :cond_1

    .line 73
    array-length v1, p1

    sub-int/2addr v1, v0

    invoke-virtual {p0, p1, v0, v1}, Ljava/io/FileInputStream;->read([BII)I

    move-result v1

    .line 74
    if-ltz v1, :cond_0

    .line 75
    add-int/2addr v0, v1

    .line 76
    goto :goto_0

    .line 74
    :cond_0
    new-instance p0, Ljava/io/IOException;

    const-string p1, "Truncated M3 aux image"

    invoke-direct {p0, p1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 77
    :cond_1
    return-void
.end method


# virtual methods
.method consumed()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 68
    iget-object v0, p0, Lcom/prometheus/camera/m3/M3AuxCapture;->staging:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 69
    return-void

    .line 68
    :cond_0
    new-instance v0, Ljava/io/IOException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "M3 aux cleanup failed: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/prometheus/camera/m3/M3AuxCapture;->staging:Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
