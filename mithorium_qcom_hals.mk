USE_MITHORIUM_QCOM_HALS := true
USE_DEVICE_SPECIFIC_AUDIO := true
USE_DEVICE_SPECIFIC_DISPLAY := true
USE_DEVICE_SPECIFIC_MEDIA := true

# Audio
DEVICE_SPECIFIC_AUDIO_PATH := $(LOCAL_PATH)/audio
PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)/audio

# Media
DEVICE_SPECIFIC_MEDIA_PATH := $(LOCAL_PATH)/media

# Display
# $(QCOM_SOONG_NAMESPACE) must be a valid soong namespace
# that contains display_intf_headers module under /display
# (blame SOONG_CONFIG_lineageQcomVars_qcom_display_headers_namespace)
# QSSI compliant HAL
QCOM_SOONG_NAMESPACE := $(LOCAL_PATH)/display
DEVICE_SPECIFIC_DISPLAY_PATH := $(QCOM_SOONG_NAMESPACE)
# To achieve the same effect as TARGET_ENFORCES_QSSI := true
PRODUCT_SOONG_NAMESPACES += \
    vendor/qcom/opensource/commonsys-intf/display \
    $(wildcard vendor/qcom/opensource/commonsys/display) \
    $(wildcard vendor/qcom/opensource/display)
	
ifeq ($(wildcard vendor/lineage/config/BoardConfigQcom.mk),)
PRODUCT_SOONG_NAMESPACES += $(QCOM_SOONG_NAMESPACE)
endif
