package com.prometheus.camera.meditor210;

import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedHelpers;

/** 2.10.43.0.8 的实际模型和路径接口；只在相册编辑器进程中调用。 */
public final class MEditor210Runtime {
    private static final String TAG = "PhoenixMEditor210";
    private static final AtomicBoolean FILTERS = new AtomicBoolean();
    private static final AtomicBoolean WATERMARKS = new AtomicBoolean();
    private static final AtomicBoolean LEGEND = new AtomicBoolean();
    private static final AtomicBoolean LOG_CATALOG = new AtomicBoolean();
    private static final AtomicBoolean LOG_PROVIDER = new AtomicBoolean();
    private static volatile ClassLoader hostLoader;
    private static final Map<Integer, File> lutPaths = new LinkedHashMap<>();

    private MEditor210Runtime() {}

    private static Object field(Object object, String name) throws Exception {
        Class<?> type = object.getClass();
        while (type != null) {
            try {
                Field value = type.getDeclaredField(name);
                value.setAccessible(true);
                return value.get(object);
            } catch (NoSuchFieldException missing) { type = type.getSuperclass(); }
        }
        throw new NoSuchFieldException(name);
    }

    private static Context context() throws Exception {
        Class<?> activityThread = Class.forName("android.app.ActivityThread");
        Method current = activityThread.getDeclaredMethod("currentApplication");
        return (Context) current.invoke(null);
    }

    public static boolean installFilters(final ClassLoader loader, final Object registry) {
        try {
            Class<?> catalog = Class.forName("wz.j", false, loader);
            if (!ArrayList.class.isAssignableFrom(catalog.getDeclaredMethod("a").getReturnType()))
                return false;
            Class.forName("a00.h", false, loader).getDeclaredConstructor(
                String.class, int.class, int.class, int.class, int.class, String.class, int.class);
            Class.forName("a00.c", false, loader).getDeclaredConstructor(
                List.class, String.class, String.class, String.class, int.class);
            hostLoader = loader;
            if (!FILTERS.compareAndSet(false, true)) return true;
            XposedHelpers.findAndHookMethod(catalog, "a", new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam param) {
                    if (!(param.getResult() instanceof List)) return;
                    try { augment((List<?>) param.getResult(), registry); }
                    catch (Throwable error) { Log.e(TAG, "catalog update failed", error); }
                }
            });
            // 有云端目录缓存时 h00.l 只保留与云目录匹配的原生分类，新增分类会被
            // 丢弃。因此在最终列表形成后补入分类，并同步 ViewModel 的 wrapper 列表。
            Class<?> writer = Class.forName("h00.l", false, loader);
            writer.getDeclaredMethod("y", Object.class);
            XposedHelpers.findAndHookMethod(writer, "y", Object.class, new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam param) {
                    if (!(param.getResult() instanceof List)) return;
                    try {
                        List<Object> added = augment((List<?>) param.getResult(), registry);
                        if (added.isEmpty()) return;
                        Object viewModel = field(param.thisObject, "h");
                        @SuppressWarnings("unchecked")
                        Map<String, Object> state = (Map<String, Object>) field(viewModel, "e");
                        ArrayList<Object> wrapped = new ArrayList<>();
                        Object previous = state.get("filter_list");
                        if (previous instanceof List) wrapped.addAll((List<?>) previous);
                        Class<?> base = Class.forName("a00.a", false, loader);
                        Class<?> style = Class.forName("a00.g", false, loader);
                        Constructor<?> wrapper = Class.forName("a00.f", false, loader).getDeclaredConstructor(
                            base, int.class, int.class, boolean.class, boolean.class, boolean.class, style);
                        Method defaults = base.getDeclaredMethod("d");
                        for (Object model : added)
                            wrapped.add(wrapper.newInstance(model, 100, 0x11, false, false, false, defaults.invoke(model)));
                        state.put("filter_list", wrapped);
                        Log.i(TAG, "final editor catalog updated filters=" + added.size() + "; styleParams wrappers synchronized");
                    } catch (Throwable error) { Log.e(TAG, "final filter catalog update failed", error); }
                }
            });
            Class<?> paths = Class.forName("av.n", false, loader);
            paths.getDeclaredMethod("b", int.class);
            XposedHelpers.findAndHookMethod(paths, "b", int.class, new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam param) {
                    File file;
                    synchronized (lutPaths) { file = lutPaths.get((Integer) param.args[0]); }
                    if (file != null && file.isFile()) param.setResult(file.getAbsolutePath());
                }
            });
            Log.i(TAG, "filter catalog and LUT paths installed: wz.j/a00.h/a00.c/av.n");
            return true;
        } catch (Throwable error) {
            FILTERS.set(false);
            Log.e(TAG, "filter API check failed", error);
            return false;
        }
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    private static List<Object> augment(List catalog, Object registry) throws Exception {
        String categoryKey = "phoenix_meditor210_custom";
        for (Object category : catalog) {
            if (categoryKey.equals(field(category, "d"))) return Collections.emptyList();
        }
        Context host = context();
        if (host == null) throw new IllegalStateException("editor context is unavailable");
        Context module = host.createPackageContext("com.prometheus.camera.rev", Context.CONTEXT_IGNORE_SECURITY);
        File presetRoot = new File(host.getFilesDir(), "prometheus/preset_luts");
        if (!presetRoot.isDirectory() && !presetRoot.mkdirs()) throw new IllegalStateException("LUT directory creation failed");
        Constructor<?> lutConstructor = Class.forName("a00.h", false, hostLoader).getDeclaredConstructor(
            String.class, int.class, int.class, int.class, int.class, String.class, int.class);
        ArrayList<Object> filters = new ArrayList<>();
        int type = (Integer) field(registry, "mediaEditorCategoryType");
        for (Object preset : (List<?>) field(registry, "mediaEditorPresets")) {
            String filename = (String) field(preset, "file");
            if (filename.contains("/") || filename.contains("\\") || filename.contains(".."))
                throw new IllegalArgumentException("invalid preset filename");
            File target = new File(presetRoot, filename);
            if (!target.isFile() || target.length() == 0) {
                File pending = new File(presetRoot, filename + ".pending");
                try (InputStream stream = module.getAssets().open("prometheus/lut-presets/" + filename);
                     FileOutputStream output = new FileOutputStream(pending)) {
                    byte[] buffer = new byte[16384];
                    int read;
                    while ((read = stream.read(buffer)) != -1) output.write(buffer, 0, read);
                }
                if (!pending.renameTo(target)) throw new IllegalStateException("LUT atomic write failed");
            }
            int id = (Integer) field(preset, "id");
            filters.add(lutConstructor.newInstance(field(preset, "label"), id, 0x7f08042f, 0, type,
                target.getAbsolutePath(), 100));
            synchronized (lutPaths) { lutPaths.put(id, target); }
        }
        int first = (Integer) field(registry, "mediaEditorFirstUserImportId");
        int last = (Integer) field(registry, "mediaEditorLastUserImportId");
        String pattern = (String) field(registry, "mediaEditorUserImportFilePattern");
        String labelPattern = (String) field(registry, "mediaEditorUserImportLabelPattern");
        File userRoot = new File((String) field(registry, "mediaEditorUserImportRoot"));
        for (int id = first; id <= last; id++) {
            String slot = Integer.toString(id - first + 1);
            File file = new File(userRoot, pattern.replace("{slot}", slot));
            if (!file.isFile() || file.length() == 0) continue;
            filters.add(lutConstructor.newInstance(labelPattern.replace("{slot}", slot), id, 0x7f08042f, 0, type,
                file.getAbsolutePath(), 100));
            synchronized (lutPaths) { lutPaths.put(id, file); }
        }
        Constructor<?> category = Class.forName("a00.c", false, hostLoader).getDeclaredConstructor(
            List.class, String.class, String.class, String.class, int.class);
        catalog.add(category.newInstance(filters, field(registry, "mediaEditorCategoryLabel"), categoryKey, "", type));
        // 原生 a00.a 构造器生成 a00.g 调色盘参数，h00.l 使用新版 a00.f 构造器封装，
        // 因此不再创建旧版缺失 styleParams 的 wrapper。
        if (LOG_CATALOG.compareAndSet(false, true))
            Log.i(TAG, "catalog augmented filters=" + filters.size() + "; native styleParams and palette retained");
        return filters;
    }

    public static Object providerResult(Object result, Object method) {
        if (!(method instanceof String)) return result;
        String name = (String) method;
        boolean eligible = name.equals("method_is_xm_legend_available");
        try {
            Class<?> ai = Class.forName("com.prometheus.camera.rev.MeAi");
            eligible |= Boolean.TRUE.equals(ai.getDeclaredMethod("isAiMethod", Object.class).invoke(null, name));
        } catch (ReflectiveOperationException error) { Log.e(TAG, "AI method classification failed", error); }
        if (!eligible) return result;
        Bundle response = result instanceof Bundle ? new Bundle((Bundle) result) : new Bundle();
        if (name.equals("action_support")) response.putBoolean("action_support", true);
        else {
            response.putBoolean("key_common_is_available", true);
            response.putBoolean("key_common_is_support", true);
        }
        if (LOG_PROVIDER.compareAndSet(false, true)) Log.i(TAG, "AI capability response updated: " + name);
        return response;
    }

    public static void installLegend(ClassLoader loader) {
        if (!LEGEND.compareAndSet(false, true)) return;
        try {
            Class<?> provider = Class.forName("com.miui.mediaeditor.provider.MediaEditorProviderForGallery", false, loader);
            XposedHelpers.findAndHookMethod(provider, "call", String.class, String.class, Bundle.class, new XC_MethodHook() {
                @Override protected void afterHookedMethod(MethodHookParam param) {
                    if ("method_is_xm_legend_available".equals(param.args[0]))
                        param.setResult(providerResult(param.getResult(), param.args[0]));
                }
            });
            Log.i(TAG, "M3 editor capability gate installed via 2.10 provider");
        } catch (Throwable error) { LEGEND.set(false); Log.e(TAG, "M3 editor gate unavailable", error); }
    }

    public static boolean installWatermarks(ClassLoader loader) {
        try {
            Class<?> selectors = Class.forName("x60.f1", false, loader);
            Class<?> bitmap = Class.forName("qc.b", false, loader);
            Class<?> meta = Class.forName("p80.g", false, loader);
            selectors.getDeclaredMethod("e", bitmap, meta);
            selectors.getDeclaredMethod("f", bitmap, meta);
            if (!WATERMARKS.compareAndSet(false, true)) return true;
            for (String name : new String[]{"e", "f"})
                XposedHelpers.findAndHookMethod(selectors, name, bitmap, meta, new XC_MethodHook() {
                    @Override protected void afterHookedMethod(MethodHookParam param) { param.setResult(Boolean.TRUE); }
                });
            // 官方新版自己处理文件目录和 renderer；保持原生渲染链，避免套用旧版
            // jb.a/wy.b 的不存在方法。模块预置的水印文件和用户签名原样保留。
            Log.i(TAG, "native watermark eligibility installed: x60.f1; original renderer retained");
            return true;
        } catch (Throwable error) { WATERMARKS.set(false); Log.e(TAG, "watermark API check failed", error); return false; }
    }
}
