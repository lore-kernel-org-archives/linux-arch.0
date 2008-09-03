From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 7/8] SPARC: Use <asm-generic/statfs.h>
Date: Wed, 03 Sep 2008 10:38:22 +0100
Message-ID: <1220434702.2985.67.camel@pmac.infradead.org>
References: <1220275314.2982.83.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:44248 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754649AbYICJiY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Sep 2008 05:38:24 -0400
In-Reply-To: <1220275314.2982.83.camel@pmac.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
---
 arch/sparc/include/asm/statfs.h    |    8 ++---
 arch/sparc/include/asm/statfs_32.h |    6 ----
 arch/sparc/include/asm/statfs_64.h |   54 ------------------------------------
 3 files changed, 3 insertions(+), 65 deletions(-)
 delete mode 100644 arch/sparc/include/asm/statfs_32.h
 delete mode 100644 arch/sparc/include/asm/statfs_64.h

diff --git a/arch/sparc/include/asm/statfs.h b/arch/sparc/include/asm/statfs.h
index 5e937a7..55e607a 100644
--- a/arch/sparc/include/asm/statfs.h
+++ b/arch/sparc/include/asm/statfs.h
@@ -1,8 +1,6 @@
 #ifndef ___ASM_SPARC_STATFS_H
 #define ___ASM_SPARC_STATFS_H
-#if defined(__sparc__) && defined(__arch64__)
-#include <asm/statfs_64.h>
-#else
-#include <asm/statfs_32.h>
-#endif
+
+#include <asm-generic/statfs.h>
+
 #endif
diff --git a/arch/sparc/include/asm/statfs_32.h b/arch/sparc/include/asm/statfs_32.h
deleted file mode 100644
index 304520f..0000000
--- a/arch/sparc/include/asm/statfs_32.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _SPARC_STATFS_H
-#define _SPARC_STATFS_H
-
-#include <asm-generic/statfs.h>
-
-#endif
diff --git a/arch/sparc/include/asm/statfs_64.h b/arch/sparc/include/asm/statfs_64.h
deleted file mode 100644
index 79b3c89..0000000
--- a/arch/sparc/include/asm/statfs_64.h
+++ /dev/null
@@ -1,54 +0,0 @@
-#ifndef _SPARC64_STATFS_H
-#define _SPARC64_STATFS_H
-
-#ifndef __KERNEL_STRICT_NAMES
-
-#include <linux/types.h>
-
-typedef __kernel_fsid_t	fsid_t;
-
-#endif
-
-struct statfs {
-	long f_type;
-	long f_bsize;
-	long f_blocks;
-	long f_bfree;
-	long f_bavail;
-	long f_files;
-	long f_ffree;
-	__kernel_fsid_t f_fsid;
-	long f_namelen;
-	long f_frsize;
-	long f_spare[5];
-};
-
-struct statfs64 {
-	long f_type;
-	long f_bsize;
-	long f_blocks;
-	long f_bfree;
-	long f_bavail;
-	long f_files;
-	long f_ffree;
-	__kernel_fsid_t f_fsid;
-	long f_namelen;
-	long f_frsize;
-	long f_spare[5];
-};
-
-struct compat_statfs64 {
-	__u32 f_type;
-	__u32 f_bsize;
-	__u64 f_blocks;
-	__u64 f_bfree;
-	__u64 f_bavail;
-	__u64 f_files;
-	__u64 f_ffree;
-	__kernel_fsid_t f_fsid;
-	__u32 f_namelen;
-	__u32 f_frsize;
-	__u32 f_spare[5];
-};
-
-#endif
-- 
1.5.5.1
-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
