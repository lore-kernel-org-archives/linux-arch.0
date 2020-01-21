From: MaJun <majun258@linux.alibaba.com>
Subject: [PATCH] csky: Fix the compile error when enable ck860
Date: Tue, 21 Jan 2020 18:50:00 +0800
Message-ID: <1579603800-25146-1-git-send-email-majun258@linux.alibaba.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: guoren@kernel.org
Cc: mj145409@alibaba-inc.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, linux-csky@vger.kernel.org, MaJun <majun258@linux.alibaba.com>
List-Id: linux-arch.vger.kernel.org

There is a compile error when ck860 processor is choosed.
To fix this compile error, the FPU config should be disabled.

Signed-off-by: MaJun <majun258@linux.alibaba.com>
---
 arch/csky/Kconfig           | 2 +-
 arch/csky/configs/defconfig | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 3973847..f6ad4c6 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -154,7 +154,7 @@ config CPU_CK860
 	select CPU_HAS_TLBI
 	select CPU_HAS_CACHEV2
 	select CPU_HAS_LDSTEX
-	select CPU_HAS_FPUV2
+	select CPU_HAS_FPUV2 if CPU_HAS_FPU
 endchoice
 
 choice
diff --git a/arch/csky/configs/defconfig b/arch/csky/configs/defconfig
index 7ef4289..ad9591c 100644
--- a/arch/csky/configs/defconfig
+++ b/arch/csky/configs/defconfig
@@ -10,9 +10,6 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-CONFIG_DEFAULT_DEADLINE=y
-CONFIG_CPU_CK807=y
-CONFIG_CPU_HAS_FPU=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -27,10 +24,7 @@ CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
-CONFIG_TTY_PRINTK=y
 # CONFIG_VGA_CONSOLE is not set
-CONFIG_CSKY_MPTIMER=y
-CONFIG_GX6605S_TIMER=y
 CONFIG_PM_DEVFREQ=y
 CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
 CONFIG_DEVFREQ_GOV_PERFORMANCE=y
@@ -56,6 +50,5 @@ CONFIG_CRAMFS=y
 CONFIG_ROMFS_FS=y
 CONFIG_NFS_FS=y
 CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
-- 
1.8.3.1
