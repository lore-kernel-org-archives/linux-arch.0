From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v7 29/37] nds32: defconfig
Date: Tue, 13 Feb 2018 17:09:33 +0800
Message-ID: <c8397de2d1a544e274cc60370f84c5a7d1f510c4.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

This patch adds nds32 defconfig.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/nds32/configs/defconfig | 104 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 arch/nds32/configs/defconfig

diff --git a/arch/nds32/configs/defconfig b/arch/nds32/configs/defconfig
new file mode 100644
index 000000000000..2546d8770785
--- /dev/null
+++ b/arch/nds32/configs/defconfig
@@ -0,0 +1,104 @@
+CONFIG_CROSS_COMPILE="nds32le-linux-"
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_USER_NS=y
+CONFIG_RELAY=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_PROFILING=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_CACHE_L2 is not set
+CONFIG_PREEMPT=y
+# CONFIG_COMPACTION is not set
+CONFIG_HZ_100=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_NET_KEY=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_BLK_DEV is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NET_CADENCE is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+CONFIG_FTMAC100=y
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_INPUT_TOUCHSCREEN=y
+# CONFIG_SERIO is not set
+CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_SERIAL_8250=y
+# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=3
+CONFIG_SERIAL_8250_RUNTIME_UARTS=3
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+# CONFIG_HID_A4TECH is not set
+# CONFIG_HID_APPLE is not set
+# CONFIG_HID_BELKIN is not set
+# CONFIG_HID_CHERRY is not set
+# CONFIG_HID_CHICONY is not set
+# CONFIG_HID_CYPRESS is not set
+# CONFIG_HID_EZKEY is not set
+# CONFIG_HID_ITE is not set
+# CONFIG_HID_KENSINGTON is not set
+# CONFIG_HID_LOGITECH is not set
+# CONFIG_HID_MICROSOFT is not set
+# CONFIG_HID_MONTEREY is not set
+# CONFIG_USB_SUPPORT is not set
+CONFIG_GENERIC_PHY=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+CONFIG_EXT4_ENCRYPTION=y
+CONFIG_FUSE_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_CONFIGFS_FS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+CONFIG_NFS_V4_1=y
+CONFIG_NFS_USE_LEGACY_DNS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DWARF4=y
+CONFIG_GDB_SCRIPTS=y
+CONFIG_READABLE_ASM=y
+CONFIG_HEADERS_CHECK=y
+CONFIG_DEBUG_SECTION_MISMATCH=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_PANIC_ON_OOPS=y
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_PREEMPT is not set
+CONFIG_STACKTRACE=y
+CONFIG_RCU_CPU_STALL_TIMEOUT=300
+# CONFIG_CRYPTO_HW is not set
-- 
2.16.1
