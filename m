Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:26576 "EHLO
	mail2.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726AbbCKOVX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Mar 2015 10:21:23 -0400
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v7 13/17] h8300: configs
Date: Wed, 11 Mar 2015 23:21:04 +0900
Message-ID: <1426083668-5011-14-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1426083668-5011-1-git-send-email-ysato@users.sourceforge.jp>
References: <1426083668-5011-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20150311142104.jbogtfW4Y_rqG42Bq-MRm5PZvXtoomDwozQ2zh9JGEk@z>

h8300h-sim_defconfig: H8/300H simulator config.
h8s-sim_defconfig:    H8S simulator config.
edosk2674_defconfig:  EDOSK2674R evalution board config.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/configs/h8300h-sim_defconfig | 53 +++++++++++++++++++++++++++++++++
 arch/h8300/configs/h8s-sim_defconfig    | 53 +++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 arch/h8300/configs/h8300h-sim_defconfig
 create mode 100644 arch/h8300/configs/h8s-sim_defconfig

diff --git a/arch/h8300/configs/h8300h-sim_defconfig b/arch/h8300/configs/h8300h-sim_defconfig
new file mode 100644
index 0000000..bad1a1e
--- /dev/null
+++ b/arch/h8300/configs/h8300h-sim_defconfig
@@ -0,0 +1,53 @@
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_USELIB is not set
+# CONFIG_INIT_FALLBACK is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_UID16 is not set
+# CONFIG_SYSFS_SYSCALL is not set
+# CONFIG_KALLSYMS is not set
+# CONFIG_BASE_FULL is not set
+# CONFIG_FUTEX is not set
+# CONFIG_EPOLL is not set
+# CONFIG_SIGNALFD is not set
+# CONFIG_TIMERFD is not set
+# CONFIG_EVENTFD is not set
+# CONFIG_AIO is not set
+# CONFIG_ADVISE_SYSCALLS is not set
+CONFIG_EMBEDDED=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_SLOB=y
+# CONFIG_BLOCK is not set
+CONFIG_H8300H_SIM=y
+CONFIG_CPU_CLOCK=20000000
+CONFIG_RAMSIZE=0x200000
+# CONFIG_BINFMT_SCRIPT is not set
+CONFIG_BINFMT_FLAT=y
+# CONFIG_COREDUMP is not set
+# CONFIG_UEVENT_HELPER is not set
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FW_LOADER is not set
+# CONFIG_ALLOW_DEV_COREDUMP is not set
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_UNIX98_PTYS is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_SH_SCI=y
+CONFIG_SERIAL_SH_SCI_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
+# CONFIG_FILE_LOCKING is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY_USER is not set
+# CONFIG_PROC_FS is not set
+# CONFIG_SYSFS is not set
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+# CONFIG_CRC32 is not set
diff --git a/arch/h8300/configs/h8s-sim_defconfig b/arch/h8300/configs/h8s-sim_defconfig
new file mode 100644
index 0000000..025cdd8
--- /dev/null
+++ b/arch/h8300/configs/h8s-sim_defconfig
@@ -0,0 +1,53 @@
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_USELIB is not set
+# CONFIG_INIT_FALLBACK is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_UID16 is not set
+# CONFIG_SYSFS_SYSCALL is not set
+# CONFIG_KALLSYMS is not set
+# CONFIG_BASE_FULL is not set
+# CONFIG_FUTEX is not set
+# CONFIG_EPOLL is not set
+# CONFIG_SIGNALFD is not set
+# CONFIG_TIMERFD is not set
+# CONFIG_EVENTFD is not set
+# CONFIG_AIO is not set
+# CONFIG_ADVISE_SYSCALLS is not set
+CONFIG_EMBEDDED=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_SLOB=y
+# CONFIG_BLOCK is not set
+CONFIG_H8S_SIM=y
+CONFIG_CPU_CLOCK=33333333
+CONFIG_RAMSIZE=0x200000
+# CONFIG_BINFMT_SCRIPT is not set
+CONFIG_BINFMT_FLAT=y
+# CONFIG_COREDUMP is not set
+# CONFIG_UEVENT_HELPER is not set
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FW_LOADER is not set
+# CONFIG_ALLOW_DEV_COREDUMP is not set
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_UNIX98_PTYS is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_SH_SCI=y
+CONFIG_SERIAL_SH_SCI_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
+# CONFIG_FILE_LOCKING is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY_USER is not set
+# CONFIG_PROC_FS is not set
+# CONFIG_SYSFS is not set
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+# CONFIG_CRC32 is not set
-- 
2.1.4

