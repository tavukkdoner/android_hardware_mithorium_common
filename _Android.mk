LOCAL_PATH := $(call my-dir)

ifeq ($(USE_MITHORIUM_QCOM_HALS),true)
include $(DEVICE_SPECIFIC_AUDIO_PATH)/Android.mk
endif # USE_MITHORIUM_QCOM_HALS