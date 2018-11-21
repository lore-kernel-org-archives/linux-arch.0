From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v8 1/6] parisc: move __IGNORE* entries to non uapi header
Date: Wed, 21 Nov 2018 09:44:25 +0530
Message-ID: <1542773670-25460-2-git-send-email-firoz.khan@linaro.org>
References: <1542773670-25460-1-git-send-email-firoz.khan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542773670-25460-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
List-Id: linux-arch.vger.kernel.org

All the __IGNORE* entries are resides in the uapi header
file move to non uapi header asm/unistd.h as it is not
used by any user space applications.

It is correct to keep __IGNORE* entry in non uapi header
asm/unistd.h while uapi/asm/unistd.h must hold information
only useful for user space applications.

One of the patch in this patch series will generate uapi
header file. The information which directly used by the
user space application must be present in uapi file.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
---
 arch/parisc/include/asm/unistd.h      | 6 ++++++
 arch/parisc/include/uapi/asm/unistd.h | 7 -------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index bc37a49..fd1013f 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -8,6 +8,12 @@
 
 #define SYS_ify(syscall_name)   __NR_##syscall_name
 
+#define __IGNORE_select			/* newselect */
+#define __IGNORE_fadvise64		/* fadvise64_64 */
+#define __IGNORE_pkey_mprotect
+#define __IGNORE_pkey_alloc
+#define __IGNORE_pkey_free
+
 #ifndef ASM_LINE_SEP
 # define ASM_LINE_SEP ;
 #endif
diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
index dc77c5a..bb52e12 100644
--- a/arch/parisc/include/uapi/asm/unistd.h
+++ b/arch/parisc/include/uapi/asm/unistd.h
@@ -368,13 +368,6 @@
 
 #define __NR_Linux_syscalls	(__NR_io_pgetevents + 1)
 
-
-#define __IGNORE_select		/* newselect */
-#define __IGNORE_fadvise64	/* fadvise64_64 */
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
-
 #define LINUX_GATEWAY_ADDR      0x100
 
 #endif /* _UAPI_ASM_PARISC_UNISTD_H_ */
-- 
1.9.1
