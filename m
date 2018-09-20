From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v2 5/5] m68k: added __IGNORE* entries in asm/unistd.h
Date: Thu, 20 Sep 2018 20:36:13 +0530
Message-ID: <1537455973-12468-6-git-send-email-firoz.khan@linaro.org>
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
List-Id: linux-arch.vger.kernel.org

Added few __IGNORE* entries for seccomp, pkey_mprotect,
pkey_alloc, pkey_free, io_pgetevents and rseq in the file
asm/unistd.h as it is correct to keep __IGNORE* entry in
non uapi header asm/unistd.h while uapi/asm/unistd.h must
hold information only useful for user space applications.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/m68k/include/asm/unistd.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/m68k/include/asm/unistd.h b/arch/m68k/include/asm/unistd.h
index 5072e94..cc5f640 100644
--- a/arch/m68k/include/asm/unistd.h
+++ b/arch/m68k/include/asm/unistd.h
@@ -31,4 +31,11 @@
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
 
+#define __IGNORE_seccomp
+#define __IGNORE_pkey_mprotect
+#define __IGNORE_pkey_alloc
+#define __IGNORE_pkey_free
+#define __IGNORE_io_pgetevents
+#define __IGNORE_rseq
+
 #endif /* _ASM_M68K_UNISTD_H_ */
-- 
1.9.1
