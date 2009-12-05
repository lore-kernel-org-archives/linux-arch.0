From: Al Viro <viro@ftp.linux.org.uk>
Subject: [RFC][PATCH 11/18] arch_mmap_check() on mn10300
Date: Sat, 05 Dec 2009 19:08:51 +0000
Message-ID: <E1NGzzv-0008Rh-1X@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757991AbZLEURK@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/mn10300/include/asm/mman.h   |    5 +++++
 arch/mn10300/kernel/sys_mn10300.c |    5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mn10300/include/asm/mman.h b/arch/mn10300/include/asm/mman.h
index 8eebf89..712f7b0 100644
--- a/arch/mn10300/include/asm/mman.h
+++ b/arch/mn10300/include/asm/mman.h
@@ -1 +1,6 @@
 #include <asm-generic/mman.h>
+
+#define MIN_MAP_ADDR	PAGE_SIZE	/* minimum fixed mmap address */
+
+#define arch_mmap_chech(addr, len, flags) \
+	(((flags) & MAP_FIXED && (addr) < MIN_MAP_ADDR) ? -EINVAL : 0)
diff --git a/arch/mn10300/kernel/sys_mn10300.c b/arch/mn10300/kernel/sys_mn10300.c
index 8ca5af0..ec4100d 100644
--- a/arch/mn10300/kernel/sys_mn10300.c
+++ b/arch/mn10300/kernel/sys_mn10300.c
@@ -23,8 +23,6 @@
 
 #include <asm/uaccess.h>
 
-#define MIN_MAP_ADDR	PAGE_SIZE	/* minimum fixed mmap address */
-
 /*
  * memory mapping syscall
  */
@@ -37,9 +35,6 @@ asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
 
 	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
 
-	if (flags & MAP_FIXED && addr < MIN_MAP_ADDR)
-		goto out;
-
 	error = -EBADF;
 	if (!(flags & MAP_ANONYMOUS)) {
 		file = fget(fd);
-- 
1.5.6.5
