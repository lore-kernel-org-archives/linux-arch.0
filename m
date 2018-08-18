From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] export.h: remove VMLINUX_SYMBOL() and VMLINUX_SYMBOL_STR()
Date: Sun, 19 Aug 2018 07:34:47 +0900
Message-ID: <1534631687-18347-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-arch.vger.kernel.org

With the special case handling for Blackfin and Metag was removed by
commit 94e58e0ac312 ("export.h: remove code for prefixing symbols with
underscore"), VMLINUX_SYMBOL() is no-no.

Replace the remaining usages, then remove the definition of
VMLINUX_SYMBOL() and VMLINUX_SYMBOL_STR().

<asm-generic/vmlinux.lds.h> no longer needs to include <linux/export.h>.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 certs/system_certificates.S       | 16 ++++++++--------
 include/asm-generic/vmlinux.lds.h |  2 --
 include/linux/export.h            |  7 -------
 usr/initramfs_data.S              |  4 ++--
 4 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/certs/system_certificates.S b/certs/system_certificates.S
index 3918ff7..8f29058 100644
--- a/certs/system_certificates.S
+++ b/certs/system_certificates.S
@@ -5,8 +5,8 @@
 	__INITRODATA
 
 	.align 8
-	.globl VMLINUX_SYMBOL(system_certificate_list)
-VMLINUX_SYMBOL(system_certificate_list):
+	.globl system_certificate_list
+system_certificate_list:
 __cert_list_start:
 #ifdef CONFIG_MODULE_SIG
 	.incbin "certs/signing_key.x509"
@@ -15,21 +15,21 @@ __cert_list_start:
 __cert_list_end:
 
 #ifdef CONFIG_SYSTEM_EXTRA_CERTIFICATE
-	.globl VMLINUX_SYMBOL(system_extra_cert)
+	.globl system_extra_cert
 	.size system_extra_cert, CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE
-VMLINUX_SYMBOL(system_extra_cert):
+system_extra_cert:
 	.fill CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE, 1, 0
 
 	.align 4
-	.globl VMLINUX_SYMBOL(system_extra_cert_used)
-VMLINUX_SYMBOL(system_extra_cert_used):
+	.globl system_extra_cert_used
+system_extra_cert_used:
 	.int 0
 
 #endif /* CONFIG_SYSTEM_EXTRA_CERTIFICATE */
 
 	.align 8
-	.globl VMLINUX_SYMBOL(system_certificate_list_size)
-VMLINUX_SYMBOL(system_certificate_list_size):
+	.globl system_certificate_list_size
+system_certificate_list_size:
 #ifdef CONFIG_64BIT
 	.quad __cert_list_end - __cert_list_start
 #else
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f173b5f..7b75ff6 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -54,8 +54,6 @@
 #define LOAD_OFFSET 0
 #endif
 
-#include <linux/export.h>
-
 /* Align . to a 8 byte boundary equals to maximum function alignment. */
 #define ALIGN_FUNCTION()  . = ALIGN(8)
 
diff --git a/include/linux/export.h b/include/linux/export.h
index b768d6d..c363bde 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -10,13 +10,6 @@
  * hackers place grumpy comments in header files.
  */
 
-#define __VMLINUX_SYMBOL(x) x
-#define __VMLINUX_SYMBOL_STR(x) #x
-
-/* Indirect, so macros are expanded before pasting. */
-#define VMLINUX_SYMBOL(x) __VMLINUX_SYMBOL(x)
-#define VMLINUX_SYMBOL_STR(x) __VMLINUX_SYMBOL_STR(x)
-
 #ifndef __ASSEMBLY__
 struct kernel_symbol
 {
diff --git a/usr/initramfs_data.S b/usr/initramfs_data.S
index b28da79..d07648f 100644
--- a/usr/initramfs_data.S
+++ b/usr/initramfs_data.S
@@ -30,8 +30,8 @@ __irf_start:
 .incbin __stringify(INITRAMFS_IMAGE)
 __irf_end:
 .section .init.ramfs.info,"a"
-.globl VMLINUX_SYMBOL(__initramfs_size)
-VMLINUX_SYMBOL(__initramfs_size):
+.globl __initramfs_size
+__initramfs_size:
 #ifdef CONFIG_64BIT
 	.quad __irf_end - __irf_start
 #else
-- 
2.7.4
