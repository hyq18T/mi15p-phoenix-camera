package com.prometheus.camera.natural15pro;

import de.robv.android.xposed.IXposedHookLoadPackage;
import de.robv.android.xposed.callbacks.XC_LoadPackage;

public final class NaturalEntry implements IXposedHookLoadPackage {
    @Override
    public void handleLoadPackage(XC_LoadPackage.LoadPackageParam lpparam) throws Throwable {
        if (lpparam == null || !"com.android.camera".equals(lpparam.packageName)) {
            return;
        }
        NaturalHook.install(lpparam.classLoader);
    }
}
