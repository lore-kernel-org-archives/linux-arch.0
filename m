From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V9 02/21] csky: defconfig
Date: Tue, 16 Oct 2018 10:58:21 +0800
Message-ID: <9ae20a094ce79774f2a1c84468221ad73a38e90a.1539655731.git.ren_guo@c-sky.com>
References: <cover.1539655731.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1539655731.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1539655731.git.ren_guo@c-sky.com>
References: <cover.1539655731.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, hch@infradead.org, marc.zyngier@arm.com, mark.rutland@arm.com, peterz@infradead.org, robh@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, c-sky_gcc_upstream@c-sky.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

This patch adds csky defconfig.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/configs/defconfig | 61 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 arch/csky/configs/defconfig

diff --git a/arch/csky/configs/defconfig b/arch/csky/configs/defconfig
new file mode 100644
index 0000000..7ef4289
--- /dev/null
+++ b/arch/csky/configs/defconfig
@@ -0,0 +1,61 @@
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_DEFAULT_HOSTNAME="csky"
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_AUDIT=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_DEFAULT_DEADLINE=y
+CONFIG_CPU_CK807=y
+CONFIG_CPU_HAS_FPU=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=65536
+CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_SERIAL_NONSTANDARD=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_TTY_PRINTK=y
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_CSKY_MPTIMER=y
+CONFIG_GX6605S_TIMER=y
+CONFIG_PM_DEVFREQ=y
+CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
+CONFIG_DEVFREQ_GOV_PERFORMANCE=y
+CONFIG_DEVFREQ_GOV_POWERSAVE=y
+CONFIG_DEVFREQ_GOV_USERSPACE=y
+CONFIG_GENERIC_PHY=y
+CONFIG_EXT4_FS=y
+CONFIG_FANOTIFY=y
+CONFIG_QUOTA=y
+CONFIG_FSCACHE=m
+CONFIG_FSCACHE_STATS=y
+CONFIG_CACHEFILES=m
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_UTF8=y
+CONFIG_NTFS_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROC_CHILDREN=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_CONFIGFS_FS=y
+CONFIG_CRAMFS=y
+CONFIG_ROMFS_FS=y
+CONFIG_NFS_FS=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
-- 
2.7.4
