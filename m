From: Chris Metcalf <cmetcalf@tilera.com>
Subject: [PATCH] tile: work around bug in the generic sys_llseek
Date: Mon, 4 Mar 2013 11:19:09 -0500
Message-ID: <201303041627.r24GR7Ql032052@farm-0021.internal.tilera.com>
References: <20130227194156.GQ4503@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:8155 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758251Ab3CDQ1J (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Mar 2013 11:27:09 -0500
In-Reply-To: <20130227194156.GQ4503@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

sys_llseek should specify the high and low 32-bit seek values as "unsigned
int" but instead it specifies "unsigned long".  Since compat syscall
arguments are always sign-extended on tile, this means that a seek value
of 0xffffffff will be incorrectly interpreted as a value of -1ULL.

To avoid the risk of breaking binary compatibility on architectures
that already use sys_llseek this way, we follow the same path as MIPS
and provide a wrapper override.

Signed-off-by: Chris Metcalf <cmetcalf@tilera.com>
Cc: stable@kernel.org [v3.6 onwards]
---
Al Viro suggested changing the generic implementation but there has
been no followup, and his preference was just fixing tile anyway,
so this is what this patch does.  Al, can you ack this if it looks OK?
The generated code for compat_sys_llseek just clears the high 32 bits
of the two offset parameters and jumps to sys_llseek.

 arch/tile/include/asm/compat.h |    3 +++
 arch/tile/kernel/compat.c      |   13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/tile/include/asm/compat.h b/arch/tile/include/asm/compat.h
index 001d418..78f1f2d 100644
--- a/arch/tile/include/asm/compat.h
+++ b/arch/tile/include/asm/compat.h
@@ -288,6 +288,9 @@ long compat_sys_sync_file_range2(int fd, unsigned int flags,
 long compat_sys_fallocate(int fd, int mode,
 			  u32 offset_lo, u32 offset_hi,
 			  u32 len_lo, u32 len_hi);
+long compat_sys_llseek(unsigned int fd, unsigned int offset_high,
+		       unsigned int offset_low, loff_t __user * result,
+		       unsigned int origin);
 
 /* Assembly trampoline to avoid clobbering r0. */
 long _compat_sys_rt_sigreturn(void);
diff --git a/arch/tile/kernel/compat.c b/arch/tile/kernel/compat.c
index 7f72401..69034e2 100644
--- a/arch/tile/kernel/compat.c
+++ b/arch/tile/kernel/compat.c
@@ -76,6 +76,18 @@ long compat_sys_fallocate(int fd, int mode,
 			     ((loff_t)len_hi << 32) | len_lo);
 }
 
+/*
+ * Avoid bug in generic sys_llseek() that specifies offset_high and
+ * offset_low as "unsigned long", thus making it possible to pass
+ * a sign-extended high 32 bits in offset_low.
+ */
+long compat_sys_llseek(unsigned int fd, unsigned int offset_high,
+		       unsigned int offset_low, loff_t __user * result,
+		       unsigned int origin)
+{
+	return sys_llseek(fd, offset_high, offset_low, result, origin);
+}
+ 
 /* Provide the compat syscall number to call mapping. */
 #undef __SYSCALL
 #define __SYSCALL(nr, call) [nr] = (call),
@@ -83,6 +95,7 @@ long compat_sys_fallocate(int fd, int mode,
 /* See comments in sys.c */
 #define compat_sys_fadvise64_64 sys32_fadvise64_64
 #define compat_sys_readahead sys32_readahead
+#define sys_llseek compat_sys_llseek
 
 /* Call the assembly trampolines where necessary. */
 #define compat_sys_rt_sigreturn _compat_sys_rt_sigreturn
-- 
1.7.10.3
