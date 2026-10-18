.class public final Lcom/prometheus/camera/m3/M3Parameters;
.super Ljava/lang/Object;
.source "M3Parameters.java"


# instance fields
.field private final data:Ljava/nio/ByteBuffer;

.field private final shadingData:I

.field private final zoomTables:[I


# direct methods
.method public constructor <init>([B)V
    .locals 18

    .line 18
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    invoke-direct/range {p0 .. p0}, Ljava/lang/Object;-><init>()V

    .line 19
    invoke-static/range {p1 .. p1}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v2

    sget-object v3, Ljava/nio/ByteOrder;->LITTLE_ENDIAN:Ljava/nio/ByteOrder;

    invoke-virtual {v2, v3}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v2

    invoke-virtual {v2}, Ljava/nio/ByteBuffer;->asReadOnlyBuffer()Ljava/nio/ByteBuffer;

    move-result-object v2

    sget-object v3, Ljava/nio/ByteOrder;->LITTLE_ENDIAN:Ljava/nio/ByteOrder;

    .line 20
    invoke-virtual {v2, v3}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    move-result-object v2

    iput-object v2, v0, Lcom/prometheus/camera/m3/M3Parameters;->data:Ljava/nio/ByteBuffer;

    .line 21
    const/4 v2, 0x0

    invoke-direct {v0, v2}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v3

    .line 22
    mul-int/lit8 v4, v3, 0x2

    add-int/lit8 v4, v4, 0x2

    .line 23
    invoke-direct {v0, v4}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v5

    add-int/lit8 v6, v4, 0x2

    invoke-direct {v0, v6}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v6

    add-int/lit8 v7, v4, 0x4

    invoke-direct {v0, v7}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v7

    .line 24
    add-int/lit8 v8, v4, 0x6

    invoke-direct {v0, v8}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v8

    add-int/lit8 v4, v4, 0x8

    .line 25
    mul-int/lit8 v9, v8, 0x2

    add-int/2addr v9, v4

    add-int/lit16 v9, v9, 0x340

    .line 26
    const/16 v10, 0x11

    const/4 v11, 0x1

    if-lez v8, :cond_0

    if-ne v7, v10, :cond_0

    add-int/lit8 v7, v9, 0x8

    array-length v12, v1

    if-gt v7, v12, :cond_0

    move v7, v11

    goto :goto_0

    :cond_0
    move v7, v2

    :goto_0
    invoke-static {v7}, Lcom/prometheus/camera/m3/M3Parameters;->require(Z)V

    .line 27
    invoke-direct {v0, v9}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v7

    if-nez v7, :cond_1

    add-int/lit8 v7, v9, 0x2

    invoke-direct {v0, v7}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v7

    if-nez v7, :cond_1

    add-int/lit8 v7, v9, 0x4

    .line 28
    invoke-direct {v0, v7}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v7

    if-ne v7, v11, :cond_1

    add-int/lit8 v9, v9, 0x6

    invoke-direct {v0, v9}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v7

    if-ne v7, v11, :cond_1

    move v7, v11

    goto :goto_1

    :cond_1
    move v7, v2

    .line 27
    :goto_1
    invoke-static {v7}, Lcom/prometheus/camera/m3/M3Parameters;->require(Z)V

    .line 29
    nop

    .line 30
    move v7, v2

    move v9, v7

    :goto_2
    if-ge v7, v3, :cond_3

    .line 31
    mul-int/lit8 v12, v7, 0x2

    add-int/lit8 v12, v12, 0x2

    invoke-direct {v0, v12}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v12

    add-int/lit8 v13, v5, 0x40

    .line 32
    const/16 v14, 0x4e

    if-ne v12, v14, :cond_2

    invoke-direct {v0, v13}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v14

    if-ne v14, v11, :cond_2

    add-int/lit8 v14, v13, 0x6

    invoke-direct {v0, v14}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v14

    if-ne v14, v11, :cond_2

    move v14, v11

    goto :goto_3

    :cond_2
    move v14, v2

    :goto_3
    invoke-static {v14}, Lcom/prometheus/camera/m3/M3Parameters;->require(Z)V

    .line 33
    add-int/lit8 v13, v13, 0xc

    invoke-direct {v0, v13}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v13

    add-int/2addr v13, v11

    invoke-static {v9, v13}, Ljava/lang/Math;->max(II)I

    move-result v9

    .line 34
    add-int/2addr v5, v12

    .line 30
    add-int/lit8 v7, v7, 0x1

    goto :goto_2

    .line 36
    :cond_3
    new-array v3, v8, [I

    iput-object v3, v0, Lcom/prometheus/camera/m3/M3Parameters;->zoomTables:[I

    .line 37
    nop

    .line 38
    nop

    .line 39
    const/4 v3, 0x0

    move v7, v2

    move v12, v7

    :goto_4
    if-ge v7, v8, :cond_8

    .line 40
    iget-object v13, v0, Lcom/prometheus/camera/m3/M3Parameters;->zoomTables:[I

    aput v5, v13, v7

    .line 41
    mul-int/lit8 v13, v7, 0x2

    add-int/2addr v13, v4

    invoke-direct {v0, v13}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v13

    add-int/lit8 v14, v5, 0x4

    invoke-direct {v0, v14}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v14

    .line 42
    iget-object v15, v0, Lcom/prometheus/camera/m3/M3Parameters;->data:Ljava/nio/ByteBuffer;

    invoke-virtual {v15, v5}, Ljava/nio/ByteBuffer;->getFloat(I)F

    move-result v15

    .line 43
    cmpl-float v3, v15, v3

    if-lez v3, :cond_4

    if-lez v14, :cond_4

    mul-int/lit8 v3, v14, 0xc

    add-int/lit8 v3, v3, 0x6

    if-ne v13, v3, :cond_4

    move v3, v11

    goto :goto_5

    :cond_4
    move v3, v2

    :goto_5
    invoke-static {v3}, Lcom/prometheus/camera/m3/M3Parameters;->require(Z)V

    .line 44
    nop

    .line 45
    nop

    .line 46
    move v3, v2

    :goto_6
    if-ge v3, v14, :cond_7

    .line 47
    add-int/lit8 v16, v5, 0x6

    mul-int/lit8 v17, v3, 0xc

    add-int v10, v16, v17

    invoke-direct {v0, v10}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v11

    move/from16 v17, v4

    add-int/lit8 v4, v10, 0x2

    invoke-direct {v0, v4}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v4

    .line 48
    if-gt v11, v4, :cond_6

    if-eqz v3, :cond_5

    if-le v11, v2, :cond_6

    :cond_5
    add-int/lit8 v2, v10, 0x4

    .line 49
    invoke-direct {v0, v2}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v2

    const/4 v11, 0x1

    if-ne v2, v11, :cond_6

    add-int/lit8 v2, v10, 0x6

    invoke-direct {v0, v2}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v2

    if-ne v2, v11, :cond_6

    add-int/lit8 v2, v10, 0x8

    invoke-direct {v0, v2}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v2

    const/16 v11, 0x2710

    if-ne v2, v11, :cond_6

    const/4 v11, 0x1

    goto :goto_7

    :cond_6
    const/4 v11, 0x0

    .line 48
    :goto_7
    invoke-static {v11}, Lcom/prometheus/camera/m3/M3Parameters;->require(Z)V

    .line 50
    nop

    .line 51
    add-int/lit8 v10, v10, 0xa

    invoke-direct {v0, v10}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v2

    const/4 v10, 0x1

    add-int/2addr v2, v10

    invoke-static {v12, v2}, Ljava/lang/Math;->max(II)I

    move-result v12

    .line 46
    add-int/lit8 v3, v3, 0x1

    move v2, v4

    move v11, v10

    move/from16 v4, v17

    const/16 v10, 0x11

    goto :goto_6

    .line 53
    :cond_7
    move/from16 v17, v4

    move v10, v11

    add-int/2addr v5, v13

    .line 39
    add-int/lit8 v7, v7, 0x1

    move v3, v15

    const/4 v2, 0x0

    const/16 v10, 0x11

    goto/16 :goto_4

    .line 55
    :cond_8
    move v10, v11

    const/16 v2, 0x11

    mul-int/2addr v9, v2

    mul-int/2addr v9, v2

    mul-int/2addr v9, v2

    mul-int/lit8 v9, v9, 0x3

    add-int/2addr v9, v6

    iput v9, v0, Lcom/prometheus/camera/m3/M3Parameters;->shadingData:I

    .line 56
    if-gt v5, v6, :cond_9

    iget v0, v0, Lcom/prometheus/camera/m3/M3Parameters;->shadingData:I

    mul-int/lit8 v12, v12, 0x20

    add-int/2addr v0, v12

    array-length v1, v1

    if-ne v0, v1, :cond_9

    move v2, v10

    goto :goto_8

    :cond_9
    const/4 v2, 0x0

    :goto_8
    invoke-static {v2}, Lcom/prometheus/camera/m3/M3Parameters;->require(Z)V

    .line 57
    return-void
.end method

.method private static require(Z)V
    .locals 1

    .line 15
    if-eqz p0, :cond_0

    .line 16
    return-void

    .line 15
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "Invalid M3 parameter asset"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private u16(I)I
    .locals 1

    .line 13
    iget-object v0, p0, Lcom/prometheus/camera/m3/M3Parameters;->data:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, p1}, Ljava/nio/ByteBuffer;->getShort(I)S

    move-result p1

    const v0, 0xffff

    and-int/2addr p1, v0

    return p1
.end method


# virtual methods
.method public configuration(IIIF)Ljava/lang/String;
    .locals 10

    .line 81
    invoke-virtual {p0, p3, p4}, Lcom/prometheus/camera/m3/M3Parameters;->shading(IF)[F

    move-result-object p3

    .line 82
    sget-object p4, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    .line 86
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const/4 p1, 0x0

    aget p1, p3, p1

    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v2

    const/4 p1, 0x1

    aget p1, p3, p1

    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v3

    const/4 p1, 0x2

    aget p1, p3, p1

    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v4

    const/4 p1, 0x3

    aget p1, p3, p1

    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v5

    const/4 p1, 0x4

    aget p1, p3, p1

    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v6

    const/4 p1, 0x5

    aget p1, p3, p1

    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v7

    const/4 p1, 0x6

    aget p1, p3, p1

    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v8

    const/4 p1, 0x7

    aget p1, p3, p1

    invoke-static {p1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v9

    filled-new-array/range {v0 .. v9}, [Ljava/lang/Object;

    move-result-object p1

    .line 82
    const-string p2, "CvStyleEffect;Width=%d;Height=%d;SmoothStartValue=%.9g;SmoothEndValue=%.9g;SmoothCoordScale=%.9g;SmoothValueScale=%.9g;LightDarkPreserveK=%.9g;LightDarkPreserveB=%.9g;LightDarkPreserveV=%.9g;LightDarkPreserveT=%.9g;"

    invoke-static {p4, p2, p1}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public shading(IF)[F
    .locals 7

    .line 60
    const/4 v0, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-ltz p1, :cond_0

    const v3, 0xffff

    if-gt p1, v3, :cond_0

    invoke-static {p2}, Ljava/lang/Float;->isFinite(F)Z

    move-result v3

    if-eqz v3, :cond_0

    cmpl-float v3, p2, v0

    if-lez v3, :cond_0

    move v3, v2

    goto :goto_0

    :cond_0
    move v3, v1

    :goto_0
    invoke-static {v3}, Lcom/prometheus/camera/m3/M3Parameters;->require(Z)V

    .line 61
    iget-object v3, p0, Lcom/prometheus/camera/m3/M3Parameters;->zoomTables:[I

    aget v3, v3, v1

    .line 62
    nop

    :goto_1
    iget-object v4, p0, Lcom/prometheus/camera/m3/M3Parameters;->zoomTables:[I

    array-length v4, v4

    if-ge v2, v4, :cond_1

    iget-object v4, p0, Lcom/prometheus/camera/m3/M3Parameters;->data:Ljava/nio/ByteBuffer;

    iget-object v5, p0, Lcom/prometheus/camera/m3/M3Parameters;->zoomTables:[I

    aget v5, v5, v2

    invoke-virtual {v4, v5}, Ljava/nio/ByteBuffer;->getFloat(I)F

    move-result v4

    cmpl-float v4, p2, v4

    if-ltz v4, :cond_1

    .line 63
    iget-object v3, p0, Lcom/prometheus/camera/m3/M3Parameters;->zoomTables:[I

    aget v3, v3, v2

    .line 62
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 64
    :cond_1
    add-int/lit8 p2, v3, 0x4

    invoke-direct {p0, p2}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result p2

    add-int/lit8 v3, v3, 0x6

    move v2, v1

    .line 65
    :goto_2
    add-int/lit8 v4, v2, 0x1

    if-ge v4, p2, :cond_2

    mul-int/lit8 v5, v2, 0xc

    add-int/2addr v5, v3

    add-int/lit8 v5, v5, 0x2

    invoke-direct {p0, v5}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v5

    if-le p1, v5, :cond_2

    move v2, v4

    goto :goto_2

    .line 66
    :cond_2
    mul-int/lit8 p2, v2, 0xc

    add-int/2addr v3, p2

    .line 67
    nop

    .line 68
    if-lez v2, :cond_3

    invoke-direct {p0, v3}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result p2

    if-ge p1, p2, :cond_3

    .line 69
    add-int/lit8 p2, v3, -0xc

    .line 70
    add-int/lit8 v0, p2, 0x2

    invoke-direct {p0, v0}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v0

    invoke-direct {p0, v3}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v2

    .line 71
    sub-int/2addr p1, v0

    int-to-float p1, p1

    sub-int/2addr v2, v0

    int-to-float v0, v2

    div-float v0, p1, v0

    goto :goto_3

    .line 73
    :cond_3
    move p2, v3

    :goto_3
    iget p1, p0, Lcom/prometheus/camera/m3/M3Parameters;->shadingData:I

    add-int/lit8 p2, p2, 0xa

    invoke-direct {p0, p2}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result p2

    mul-int/lit8 p2, p2, 0x20

    add-int/2addr p1, p2

    iget p2, p0, Lcom/prometheus/camera/m3/M3Parameters;->shadingData:I

    add-int/lit8 v3, v3, 0xa

    invoke-direct {p0, v3}, Lcom/prometheus/camera/m3/M3Parameters;->u16(I)I

    move-result v2

    mul-int/lit8 v2, v2, 0x20

    add-int/2addr p2, v2

    .line 74
    const/16 v2, 0x8

    new-array v3, v2, [F

    .line 75
    nop

    :goto_4
    if-ge v1, v2, :cond_4

    .line 76
    iget-object v4, p0, Lcom/prometheus/camera/m3/M3Parameters;->data:Ljava/nio/ByteBuffer;

    mul-int/lit8 v5, v1, 0x4

    add-int v6, p1, v5

    invoke-virtual {v4, v6}, Ljava/nio/ByteBuffer;->getFloat(I)F

    move-result v4

    const/high16 v6, 0x3f800000    # 1.0f

    sub-float/2addr v6, v0

    mul-float/2addr v4, v6

    iget-object v6, p0, Lcom/prometheus/camera/m3/M3Parameters;->data:Ljava/nio/ByteBuffer;

    add-int/2addr v5, p2

    invoke-virtual {v6, v5}, Ljava/nio/ByteBuffer;->getFloat(I)F

    move-result v5

    mul-float/2addr v5, v0

    add-float/2addr v4, v5

    aput v4, v3, v1

    .line 75
    add-int/lit8 v1, v1, 0x1

    goto :goto_4

    .line 77
    :cond_4
    return-object v3
.end method
