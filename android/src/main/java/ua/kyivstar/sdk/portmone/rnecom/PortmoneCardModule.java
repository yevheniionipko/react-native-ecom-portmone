package ua.kyivstar.sdk.portmone.rnecom;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.BaseActivityEventListener;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import com.facebook.react.bridge.WritableMap;
import com.facebook.react.uimanager.IllegalViewOperationException;
import com.portmone.ecomsdk.PortmoneSDK;
import com.portmone.ecomsdk.data.Bill;
import com.portmone.ecomsdk.data.CardPaymentParams;
import com.portmone.ecomsdk.data.SaveCardParams;
import com.portmone.ecomsdk.data.style.AppStyle;
import com.portmone.ecomsdk.ui.card.CardPaymentActivity;
import com.portmone.ecomsdk.ui.savecard.PreauthCardActivity;
import com.portmone.ecomsdk.util.Constant$BillCurrency;

import com.portmone.ecomsdk.util.Constant$Language;

import java.util.Arrays;
import java.util.List;

import static android.app.Activity.RESULT_OK;

public class PortmoneCardModule extends ReactContextBaseJavaModule {

    private static final AppStyleFactory APP_STYLE_FACTORY = new AppStyleFactory();
    private static final List<String> AVAILABLE_LANGUAGES = Arrays.asList(
        Constant$Language.EN, Constant$Language.RU, Constant$Language.UK
    );

    private ReactApplicationContext reactContext;
    private Promise promise;

    public PortmoneCardModule(@NonNull ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
        reactContext.addActivityEventListener(mActivityEventListener);
    }

    @Override
    public String getName() {
        return "PortmoneCardModule";
    }

    private String getLanguage(String lang) {
        return AVAILABLE_LANGUAGES.contains(lang) ? lang : Constant$Language.SYSTEM;
    }

    @ReactMethod
    public void invokePortmoneSdk(String lang) {
        try {
            final AppStyle styles = APP_STYLE_FACTORY.createStyles(reactContext);
            PortmoneSDK.setLanguage(getLanguage(lang));
            PortmoneSDK.setFingerprintPaymentEnable(true);
            PortmoneSDK.setAppStyle(styles);
        } catch (IllegalViewOperationException e) {
            Log.d("PORTMONE", "invokePortmoneSdk: ERROR", e);
        }
    }

    @ReactMethod
    public void initCardPayment(String payeeId, String phoneNumber, int billAmount) {
        try {
            final CardPaymentParams params = new CardPaymentParams(
                payeeId,
                Constants.BILL_NUMBER,
                Constants.ALLOW_PRE_AUTH,
                Constant$BillCurrency.UAH,
                Constants.ATTR_1,
                null,
                null,
                null,
                billAmount,
                phoneNumber
            );
            CardPaymentActivity.performTransaction(
                getCurrentActivity(),
                Constants.REQUEST_CODE,
                params
            );
        } catch (IllegalViewOperationException e) {
            Log.d("PORTMONE", "initCardPayment: ERROR", e);
        }
    }

    @ReactMethod
    public void initCardSaving(String payeeId) {
        try {
            final SaveCardParams saveCardParams = new SaveCardParams(
                payeeId,
                Constants.BILL_NUMBER,
                ""
            );
            PreauthCardActivity.performTransaction(
                getCurrentActivity(),
                Constants.REQUEST_CODE,
                saveCardParams
            );
        } catch (IllegalViewOperationException e) {
            Log.d("PORTMONE", "initCardSaving: ERROR", e);
        }
    }

    private final ActivityEventListener mActivityEventListener = new BaseActivityEventListener() {
        @Override
        public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent intent) {
            switch (requestCode) {
                case Constants.REQUEST_CODE:
                    if (resultCode == RESULT_OK) {
                        Bundle bundle = intent.getExtras();
                        Log.d("PORTMONE", bundle.toString());
//                        WritableMap map = Arguments.createMap();
//                        map.putString("token", message);
//                        promise.resolve(map);
                    } else {
                        promise.reject("PORTMONE", new Error("Result code: " + resultCode));
                    }
                    promise = null;
                    break;
            }
        }
    }
}
