USE_MITHORIUM_QCOM_HALS := true
USE_DEVICE_SPECIFIC_AUDIO := true
USE_DEVICE_SPECIFIC_DISPLAY := true
USE_DEVICE_SPECIFIC_MEDIA := true

#ifeq ($(call math_lt,$(PLATFORM_SDK_VERSION),33),true)
# LineageOS 18/19's display-commonsys-intf repo are too old to use LA.UM.9.6.4 tags
#MITHORIUM_QCOM_HALS_DEFAULT_VARIANT ?= LA.UM.9.6.3.r1-06200-89xx.0
#else
MITHORIUM_QCOM_HALS_DEFAULT_VARIANT ?= LA.UM.9.6.4.r1-05100-89xx.QSSI13.0
#endif

# Audio
DEVICE_SPECIFIC_AUDIO_PATH := $(LOCAL_PATH)/audio/$(MITHORIUM_QCOM_HALS_DEFAULT_VARIANT)/hal
PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)/audio/$(MITHORIUM_QCOM_HALS_DEFAULT_VARIANT)

# Media
ifeq ($(TARGET_KERNEL_VERSION),4.9)
    # Kernel 4.9 could not use LA.UM.9.6.3 and LA.UM.9.6.4 tags
    DEVICE_SPECIFIC_MEDIA_PATH := $(wildcard $(LOCAL_PATH)/media/lineage-*-caf-msm8953)/hal
else
    DEVICE_SPECIFIC_MEDIA_PATH := $(LOCAL_PATH)/media/$(MITHORIUM_QCOM_HALS_DEFAULT_VARIANT)/hal
endif

# Display
# $(QCOM_SOONG_NAMESPACE) must be a valid soong namespace
# that contains display_intf_headers module under /display
# (blame SOONG_CONFIG_lineageQcomVars_qcom_display_headers_namespace)
ifeq ($(TARGET_USES_Q_DISPLAY_STACK),true)
    # Non-QSSI HAL
    QCOM_SOONG_NAMESPACE := $(wildcard $(LOCAL_PATH)/display/LA.UM.8.6.2.r1-09500-89xx.0)
    DEVICE_SPECIFIC_DISPLAY_PATH := $(QCOM_SOONG_NAMESPACE)/display
else
    # QSSI compliant HAL
    QCOM_SOONG_NAMESPACE := $(LOCAL_PATH)/display/$(MITHORIUM_QCOM_HALS_DEFAULT_VARIANT)
    DEVICE_SPECIFIC_DISPLAY_PATH := $(QCOM_SOONG_NAMESPACE)/hal

    # To achieve the same effect as TARGET_ENFORCES_QSSI := true
    PRODUCT_SOONG_NAMESPACES += \
        vendor/qcom/opensource/commonsys-intf/display \
        $(wildcard vendor/qcom/opensource/commonsys/display) \
        $(wildcard vendor/qcom/opensource/display)
endif
