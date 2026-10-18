package com.prometheus.camera.natural15pro;

import android.hardware.camera2.CaptureRequest;
import android.os.SystemClock;
import android.util.Log;

import org.json.JSONArray;
import org.json.JSONObject;

import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.Map;
import java.util.WeakHashMap;
import java.util.concurrent.atomic.AtomicBoolean;

import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;

public final class NaturalHook {
    private static final String LOG_TAG = "PhoenixNatural15Pro";
    private static final String STYLE_TAG =
            "com.xiaomi.sessionparams.stylizationType";
    private static final String RENDER_TYPE_TAG =
            "com.xiaomi.mivi2.renderType";
    private static final String LUT_NAME = "lut_cvstyle_natural";
    private static final String LUT_PATH = "/data/vendor/camera/";
    private static final String DISABLE_FLAG =
            "/data/data/com.android.camera/files/natural15pro.off";
    private static final String PURE_LUT_SCRIPT =
            "@CubeLutEffect;cube_strength=1.0;lut_type=0;@";
    private static final int PHOTO_MODULE = 0xa3;
    private static final int RENDER_TYPE_FILTER = 1;

    private static final Map<CaptureRequest.Builder, Boolean> VIVID_BUILDERS =
            Collections.synchronizedMap(
                    new WeakHashMap<CaptureRequest.Builder, Boolean>());
    private static final AtomicBoolean INSTALLED = new AtomicBoolean(false);
    private static final AtomicBoolean LOG_STYLE = new AtomicBoolean(false);
    private static final AtomicBoolean LOG_REWRITE = new AtomicBoolean(false);
    private static final AtomicBoolean LOG_PUBLISH = new AtomicBoolean(false);
    private static final AtomicBoolean LOG_PAYLOAD = new AtomicBoolean(false);
    private static final AtomicBoolean LOG_FALLBACK = new AtomicBoolean(false);
    private static final AtomicBoolean LOG_DISABLED = new AtomicBoolean(false);
    private static final java.util.concurrent.atomic.AtomicInteger PAYLOAD_HITS =
            new java.util.concurrent.atomic.AtomicInteger(0);
    private static final AtomicBoolean LOG_FAIL = new AtomicBoolean(false);
    private static final java.util.concurrent.atomic.AtomicLong LUT_WRITTEN_AT =
            new java.util.concurrent.atomic.AtomicLong(0L);
    private static final ThreadLocal<Boolean> INTERNAL = new ThreadLocal<Boolean>();

    private static volatile ClassLoader appLoader;
    private static volatile CaptureRequest.Key<?> styleKey;
    private static volatile Object renderTypeWrapper;
    private static volatile Object miviRenderWrapper;
    private static volatile Class<?> tagHelper;
    private static volatile byte[] lutBytes;
    private static volatile byte[] fallbackPayload;
    private static volatile boolean assetFailed;

    private NaturalHook() {
    }

    public static void install(ClassLoader loader) {
        if (loader == null) {
            return;
        }
        log("entry");
        if (!INSTALLED.compareAndSet(false, true)) {
            return;
        }
        appLoader = loader;

        try {
            XposedHelpers.findAndHookMethod(
                    CaptureRequest.Builder.class,
                    "set",
                    CaptureRequest.Key.class,
                    Object.class,
                    new BuilderSetHook());
        } catch (Throwable t) {
            log("builder set hook unavailable");
            XposedBridge.log(t);
        }

        try {
            XposedHelpers.findAndHookMethod(
                    "j9.m0",
                    loader,
                    "t0",
                    CaptureRequest.Builder.class,
                    byte[].class,
                    new MiviPayloadHook());
        } catch (Throwable t) {
            log("j9.m0.t0 hook unavailable");
            XposedBridge.log(t);
        }

        try {
            XposedHelpers.findAndHookMethod(
                    "j9.D0",
                    loader,
                    "H1",
                    int.class,
                    CaptureRequest.Builder.class,
                    new H1Hook());
        } catch (Throwable t) {
            log("j9.D0.H1 hook unavailable");
            XposedBridge.log(t);
        }

        try {
            XposedHelpers.findAndHookMethod(
                    "com.xiaomi.camera.mivi.filter.a",
                    loader,
                    "run",
                    new LutPublisherHook());
        } catch (Throwable t) {
            log("MIVI LUT publisher hook unavailable");
            XposedBridge.log(t);
        }

        log("installed; photo-module vivid requests only");
    }

    private static final class BuilderSetHook extends XC_MethodHook {
        @Override
        protected void beforeHookedMethod(MethodHookParam param) {
            if (Boolean.TRUE.equals(INTERNAL.get())) {
                return;
            }
            try {
                if (!(param.args[0] instanceof CaptureRequest.Key)) {
                    return;
                }
                CaptureRequest.Key<?> key = (CaptureRequest.Key<?>) param.args[0];
                CaptureRequest.Builder builder =
                        (CaptureRequest.Builder) param.thisObject;
                String name = key.getName();

                if (STYLE_TAG.equals(name)) {
                    boolean vivid = isVivid(param.args[1]);
                    VIVID_BUILDERS.put(builder, Boolean.valueOf(vivid));
                    styleKey = (CaptureRequest.Key<?>) key;
                    if (vivid && LOG_STYLE.compareAndSet(false, true)) {
                        log("vivid builder marked");
                    }
                    ensureAsset();
                    return;
                }

                if (RENDER_TYPE_TAG.equals(name)) {
                    ensureWrappers();
                }
            } catch (Throwable t) {
                logFailure("builder set", t);
            }
        }
    }

    private static final class MiviPayloadHook extends XC_MethodHook {
        @Override
        protected void beforeHookedMethod(MethodHookParam param) {
            try {
                if (!(param.args[0] instanceof CaptureRequest.Builder)) {
                    return;
                }
                CaptureRequest.Builder builder =
                        (CaptureRequest.Builder) param.args[0];
                if (!(param.args[1] instanceof byte[])) {
                    return;
                }

                boolean vivid = isVividBuilder(builder);
                int module = currentModule();
                int hits = PAYLOAD_HITS.incrementAndGet();
                if (hits <= 20) {
                    log("t0 hit #" + hits + " module=" + module + " vivid="
                            + vivid + " len=" + ((byte[]) param.args[1]).length);
                }
                if (LOG_PAYLOAD.compareAndSet(false, true)) {
                    log("payload module=" + module + " vivid=" + vivid
                            + " payload=" + preview((byte[]) param.args[1]));
                }
                if (!vivid || module != PHOTO_MODULE) {
                    return;
                }
                if (disabled()) {
                    return;
                }

                ensureAsset();
                if (!canApply()) {
                    return;
                }
                byte[] rewritten = rewritePayload((byte[]) param.args[1]);
                if (rewritten == null) {
                    return;
                }
                param.args[1] = rewritten;
                publishLut(lutPathOf((byte[]) param.args[1]));
                if (LOG_REWRITE.compareAndSet(false, true)) {
                    log("MIVI payload rewritten to " + LUT_NAME);
                }
            } catch (Throwable t) {
                logFailure("MIVI payload", t);
            }
        }
    }

    private static final class H1Hook extends XC_MethodHook {
        @Override
        protected void afterHookedMethod(MethodHookParam param) {
            try {
                if (!(param.args[1] instanceof CaptureRequest.Builder)) {
                    return;
                }
                CaptureRequest.Builder builder =
                        (CaptureRequest.Builder) param.args[1];
                if (currentModule() != PHOTO_MODULE) {
                    return;
                }
                if (!isVividBuilder(builder)) {
                    return;
                }
                if (disabled()) {
                    return;
                }
                ensureAsset();
                if (!canApply()) {
                    return;
                }
                ensureWrappers();
                if (miviRenderWrapper == null || renderTypeWrapper == null) {
                    return;
                }
                if (readTag(builder, miviRenderWrapper) != null) {
                    return;
                }
                byte[] payload = syntheticPayload();
                if (payload == null) {
                    return;
                }
                publishLut(LUT_PATH);
                setTag(builder, miviRenderWrapper, payload);
                setTag(builder, renderTypeWrapper,
                        Integer.valueOf(RENDER_TYPE_FILTER));
                if (LOG_FALLBACK.compareAndSet(false, true)) {
                    log("vivid fallback injected");
                }
            } catch (Throwable t) {
                logFailure("vivid fallback", t);
            }
        }
    }

    private static final class LutPublisherHook extends XC_MethodHook {
        @Override
        protected void beforeHookedMethod(MethodHookParam param) {
            try {
                Object self = param.thisObject;
                Object tokenValue = XposedHelpers.getObjectField(self, "b");
                if (!(tokenValue instanceof String)
                        || !LUT_NAME.equals(tokenValue)) {
                    return;
                }

                ensureAsset();
                byte[] bytes = lutBytes;
                if (bytes == null) {
                    logFailure("LUT asset missing; publisher skipped", null);
                    param.setResult(null);
                    return;
                }

                String dir = (String) XposedHelpers.getObjectField(self, "c");
                String name = (String) XposedHelpers.getObjectField(self, "d");
                Class<?> saver = XposedHelpers.findClass(
                        "com.xiaomi.camera.mivi.filter.MIVILutSaver", appLoader);
                Object result = XposedHelpers.callStaticMethod(
                        saver, "writeLutToDir", dir, name, bytes);
                param.setResult(null);
                if (LOG_PUBLISH.compareAndSet(false, true)) {
                    log("published " + LUT_NAME + " bytes=" + bytes.length
                            + " result=" + result);
                }
            } catch (Throwable t) {
                logFailure("LUT publish", t);
                param.setResult(null);
            }
        }
    }

    private static byte[] rewritePayload(byte[] payload) throws Exception {
        String raw = new String(payload, StandardCharsets.UTF_8)
                .replace("\u0000", "")
                .trim();
        if (raw.isEmpty()) {
            return null;
        }

        JSONObject source = new JSONObject(raw);
        String lutPath = source.optString("lutPath", "");
        if (lutPath.isEmpty()) {
            return null;
        }
        int renderType = source.optInt("renderType", 0);
        if ((renderType & 0x20) != 0) {
            return null;
        }
        if (source.optInt("generalFilterId", -1) != 3) {
            return null;
        }

        JSONObject target = new JSONObject(source.toString());
        String script = target.optString("filterScript", "");
        int cubeCount = countOf(script, "CubeLutEffect;");
        if (cubeCount > 1) {
            return null;
        }
        script = script.replaceAll("@CvEffect;[^@]*", "");
        if (cubeCount == 0) {
            script = PURE_LUT_SCRIPT + script;
        }
        target.put("filterScript", normalizeScript(script));
        target.remove("cvFilterCandyParams");
        target.remove("cvFilterLutName");
        JSONArray lutNames = new JSONArray();
        lutNames.put(LUT_NAME);
        target.put("lutNames", lutNames);

        byte[] text = target.toString().getBytes(StandardCharsets.UTF_8);
        byte[] withTerminator = new byte[text.length + 1];
        System.arraycopy(text, 0, withTerminator, 0, text.length);
        withTerminator[text.length] = 0;
        return withTerminator;
    }

    private static String normalizeScript(String script) {
        if (script == null) {
            return "";
        }
        String value = script.replaceAll("@+", "@").trim();
        if (value.isEmpty()) {
            return "@";
        }
        if (!value.startsWith("@")) {
            value = "@" + value;
        }
        if (!value.endsWith("@")) {
            value = value + "@";
        }
        return value;
    }

    private static int countOf(String text, String needle) {
        if (text == null || text.isEmpty() || needle == null || needle.isEmpty()) {
            return 0;
        }
        int count = 0;
        int index = 0;
        while ((index = text.indexOf(needle, index)) >= 0) {
            count++;
            index += needle.length();
        }
        return count;
    }

    private static String lutPathOf(byte[] payload) {
        try {
            String raw = new String(payload, StandardCharsets.UTF_8)
                    .replace("\u0000", "").trim();
            return new JSONObject(raw).optString("lutPath", "");
        } catch (Throwable ignored) {
            return "";
        }
    }

    private static byte[] syntheticPayload() {
        byte[] cached = fallbackPayload;
        if (cached != null) {
            return cached;
        }
        synchronized (NaturalHook.class) {
            if (fallbackPayload != null) {
                return fallbackPayload;
            }
            try {
                JSONObject payload = new JSONObject();
                payload.put("version", 3.002);
                payload.put("renderType", RENDER_TYPE_FILTER);
                payload.put("lutPath", LUT_PATH);
                payload.put("generalFilterId", 3);
                payload.put("filterScript", PURE_LUT_SCRIPT);
                JSONArray names = new JSONArray();
                names.put(LUT_NAME);
                payload.put("lutNames", names);
                byte[] text = payload.toString()
                        .getBytes(StandardCharsets.UTF_8);
                byte[] withTerminator = new byte[text.length + 1];
                System.arraycopy(text, 0, withTerminator, 0, text.length);
                withTerminator[text.length] = 0;
                fallbackPayload = withTerminator;
                return withTerminator;
            } catch (Throwable t) {
                logFailure("synthetic payload", t);
                return null;
            }
        }
    }

    private static String preview(byte[] payload) {
        String raw = new String(payload, StandardCharsets.UTF_8)
                .replace("\u0000", "").trim();
        return raw.length() <= 600 ? raw : raw.substring(0, 600) + "...";
    }

    private static boolean isVividBuilder(CaptureRequest.Builder builder) {
        if (builder == null) {
            return false;
        }
        synchronized (VIVID_BUILDERS) {
            Boolean marked = VIVID_BUILDERS.get(builder);
            if (marked != null) {
                return marked.booleanValue();
            }
        }
        CaptureRequest.Key<?> key = styleKey;
        if (key == null) {
            return false;
        }
        try {
            return isVivid(builder.get((CaptureRequest.Key) key));
        } catch (Throwable ignored) {
            return false;
        }
    }

    private static void ensureWrappers() {
        if (tagHelper != null && renderTypeWrapper != null
                && miviRenderWrapper != null) {
            return;
        }
        synchronized (NaturalHook.class) {
            if (tagHelper != null && renderTypeWrapper != null
                    && miviRenderWrapper != null) {
                return;
            }
            try {
                Class<?> keys = XposedHelpers.findClass("ga.A0", appLoader);
                renderTypeWrapper = XposedHelpers.getStaticObjectField(keys, "c");
                miviRenderWrapper = XposedHelpers.getStaticObjectField(keys, "d");
                tagHelper = XposedHelpers.findClass("ga.E0", appLoader);
            } catch (Throwable t) {
                logFailure("MIVI tag wrapper", t);
            }
        }
    }

    private static Object readTag(CaptureRequest.Builder builder, Object wrapper) {
        Class<?> helper = tagHelper;
        if (helper == null || wrapper == null) {
            return null;
        }
        return XposedHelpers.callStaticMethod(
                helper, "j", builder, wrapper, Integer.valueOf(0xbabe));
    }

    private static void setTag(CaptureRequest.Builder builder, Object wrapper,
            Object value) {
        Class<?> helper = tagHelper;
        if (helper == null || wrapper == null) {
            return;
        }
        XposedHelpers.callStaticMethod(helper, "f", builder, wrapper, value);
    }

    private static boolean isVivid(Object value) {
        if (value instanceof Number) {
            return ((Number) value).intValue() == 0;
        }
        if (value instanceof byte[]) {
            byte[] bytes = (byte[]) value;
            return bytes.length > 0 && (bytes[0] & 0xff) == 0;
        }
        return false;
    }

    private static int currentModule() {
        try {
            Class<?> module = XposedHelpers.findClass(
                    "com.android.camera.module.Y", appLoader);
            return XposedHelpers.getStaticIntField(module, "a");
        } catch (Throwable ignored) {
            return -1;
        }
    }

    private static boolean canApply() {
        return lutBytes != null && !assetFailed;
    }

    private static boolean disabled() {
        if (!new java.io.File(DISABLE_FLAG).exists()) {
            return false;
        }
        if (LOG_DISABLED.compareAndSet(false, true)) {
            log("disabled by " + DISABLE_FLAG);
        }
        return true;
    }

    private static void ensureAsset() {
        if (lutBytes != null || assetFailed) {
            return;
        }
        synchronized (NaturalHook.class) {
            if (lutBytes != null || assetFailed) {
                return;
            }
            try {
                byte[] loaded = android.util.Base64.decode(
                        LutData.PNG_BASE64, android.util.Base64.DEFAULT);
                if (loaded.length == 0) {
                    throw new IllegalStateException("empty LUT asset");
                }
                lutBytes = loaded;
                log("LUT asset loaded bytes=" + loaded.length);
            } catch (Throwable t) {
                assetFailed = true;
                log("LUT asset unavailable; module stays passive");
                XposedBridge.log(t);
            }
        }
    }

    private static void publishLut(String lutPath) {
        byte[] bytes = lutBytes;
        if (bytes == null || lutPath == null || lutPath.isEmpty()) {
            return;
        }
        long now = SystemClock.elapsedRealtime();
        long last = LUT_WRITTEN_AT.get();
        if (now - last < 5000L) {
            return;
        }
        if (!LUT_WRITTEN_AT.compareAndSet(last, now)) {
            return;
        }
        try {
            Class<?> saver = XposedHelpers.findClass(
                    "com.xiaomi.camera.mivi.filter.MIVILutSaver", appLoader);
            Object result = XposedHelpers.callStaticMethod(
                    saver, "writeLutToDir", lutPath, LUT_NAME + ".png", bytes);
            if (LOG_PUBLISH.compareAndSet(false, true)) {
                log("writeLutToDir path=" + lutPath + " bytes=" + bytes.length
                        + " result=" + result);
            }
        } catch (Throwable t) {
            logFailure("writeLutToDir", t);
        }
    }

    private static void logFailure(String stage, Throwable throwable) {
        if (LOG_FAIL.compareAndSet(false, true)) {
            log(stage + " failed");
            if (throwable != null) {
                XposedBridge.log(throwable);
            }
        }
    }

    private static void log(String message) {
        Log.i(LOG_TAG, message);
        XposedBridge.log(LOG_TAG + ": " + message);
    }
}
