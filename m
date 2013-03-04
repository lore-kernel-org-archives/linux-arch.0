From: Chris Metcalf <cmetcalf@tilera.com>
Subject: [PATCH] tile: properly use COMPAT_SYSCALL_DEFINEx
Date: Mon, 4 Mar 2013 13:37:32 -0500
Message-ID: <201303041841.r24If3rp001825@farm-0021.internal.tilera.com>
References: <20130304165410.GS4503@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:63357 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932263Ab3CDSlF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Mar 2013 13:41:05 -0500
In-Reply-To: <20130304165410.GS4503@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

This was pointed out by Al Viro.  Using the correct wrappers
properly does sign extension as necessary on syscall arguments.

Signed-off-by: Chris Metcalf <cmetcalf@tilera.com>
---
 arch/tile/kernel/compat.c |   35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/tile/kernel/compat.c b/arch/tile/kernel/compat.c
index 69034e2..6ea4cdb 100644
--- a/arch/tile/kernel/compat.c
+++ b/arch/tile/kernel/compat.c
@@ -32,45 +32,48 @@
  * adapt the usual convention.
  */
 
-long compat_sys_truncate64(char __user *filename, u32 dummy, u32 low, u32 high)
+COMPAT_SYSCALL_DEFINE4(truncate64, char __user *, filename, u32, dummy,
+                       u32, low, u32, high)
 {
 	return sys_truncate(filename, ((loff_t)high << 32) | low);
 }
 
-long compat_sys_ftruncate64(unsigned int fd, u32 dummy, u32 low, u32 high)
+COMPAT_SYSCALL_DEFINE4(ftruncate64, unsigned int, fd, u32, dummy,
+                       u32, low, u32, high)
 {
 	return sys_ftruncate(fd, ((loff_t)high << 32) | low);
 }
 
-long compat_sys_pread64(unsigned int fd, char __user *ubuf, size_t count,
-			u32 dummy, u32 low, u32 high)
+COMPAT_SYSCALL_DEFINE6(pread64, unsigned int, fd, char __user *, ubuf,
+                       size_t, count, u32, dummy, u32, low, u32, high)
 {
 	return sys_pread64(fd, ubuf, count, ((loff_t)high << 32) | low);
 }
 
-long compat_sys_pwrite64(unsigned int fd, char __user *ubuf, size_t count,
-			 u32 dummy, u32 low, u32 high)
+COMPAT_SYSCALL_DEFINE6(pwrite64, unsigned int, fd, char __user *, ubuf,
+                       size_t, count, u32, dummy, u32, low, u32, high)
 {
 	return sys_pwrite64(fd, ubuf, count, ((loff_t)high << 32) | low);
 }
 
-long compat_sys_lookup_dcookie(u32 low, u32 high, char __user *buf, size_t len)
+COMPAT_SYSCALL_DEFINE4(lookup_dcookie, u32, low, u32, high,
+                       char __user *, buf, size_t, len)
 {
 	return sys_lookup_dcookie(((loff_t)high << 32) | low, buf, len);
 }
 
-long compat_sys_sync_file_range2(int fd, unsigned int flags,
-				 u32 offset_lo, u32 offset_hi,
-				 u32 nbytes_lo, u32 nbytes_hi)
+COMPAT_SYSCALL_DEFINE6(sync_file_range2, int, fd, unsigned int, flags,
+                       u32, offset_lo, u32, offset_hi,
+                       u32, nbytes_lo, u32, nbytes_hi)
 {
 	return sys_sync_file_range(fd, ((loff_t)offset_hi << 32) | offset_lo,
 				   ((loff_t)nbytes_hi << 32) | nbytes_lo,
 				   flags);
 }
 
-long compat_sys_fallocate(int fd, int mode,
-			  u32 offset_lo, u32 offset_hi,
-			  u32 len_lo, u32 len_hi)
+COMPAT_SYSCALL_DEFINE6(fallocate, int, fd, int, mode,
+                       u32, offset_lo, u32, offset_hi,
+                       u32, len_lo, u32, len_hi)
 {
 	return sys_fallocate(fd, mode, ((loff_t)offset_hi << 32) | offset_lo,
 			     ((loff_t)len_hi << 32) | len_lo);
@@ -81,9 +84,9 @@ long compat_sys_fallocate(int fd, int mode,
  * offset_low as "unsigned long", thus making it possible to pass
  * a sign-extended high 32 bits in offset_low.
  */
-long compat_sys_llseek(unsigned int fd, unsigned int offset_high,
-		       unsigned int offset_low, loff_t __user * result,
-		       unsigned int origin)
+COMPAT_SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned int, offset_high,
+		       unsigned int, offset_low, loff_t __user *, result,
+		       unsigned int, origin)
 {
 	return sys_llseek(fd, offset_high, offset_low, result, origin);
 }
-- 
1.7.10.3
