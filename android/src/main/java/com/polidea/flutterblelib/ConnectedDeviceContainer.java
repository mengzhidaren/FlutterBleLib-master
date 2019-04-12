package com.polidea.flutterblelib;


import com.polidea.flutterblelib.wrapper.Device;

import java.util.HashMap;

import androidx.annotation.Nullable;

public class ConnectedDeviceContainer extends HashMap<String, Device> {

    public void register(Device connectedDeviceData) {
        this.put(connectedDeviceData.getRxBleDevice().getMacAddress(), connectedDeviceData);
    }

    @Nullable
    public Device getConnectedDeviceMessage(String macAddress) {
        return get(macAddress);
    }
}
