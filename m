From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 5/8] PARISC: Use <asm-generic/statfs.h>
Date: Wed, 03 Sep 2008 10:38:12 +0100
Message-ID: <1220434692.2985.65.camel@pmac.infradead.org>
References: <1220275314.2982.83.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:44243 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439AbYICJiP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Sep 2008 05:38:15 -0400
In-Reply-To: <1220275314.2982.83.camel@pmac.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
---
 include/asm-parisc/statfs.h |   55 +-----------------------------------------
 1 files changed, 2 insertions(+), 53 deletions(-)

diff --git a/include/asm-parisc/statfs.h b/include/asm-parisc/statfs.h
index 1d2b813..324bea9 100644
--- a/include/asm-parisc/statfs.h
+++ b/include/asm-parisc/statfs.h
@@ -1,58 +1,7 @@
 #ifndef _PARISC_STATFS_H
 #define _PARISC_STATFS_H
 
-#ifndef __KERNEL_STRICT_NAMES
-
-#include <linux/types.h>
-
-typedef __kernel_fsid_t	fsid_t;
-
-#endif
-
-/*
- * It appears that PARISC could be 64 _or_ 32 bit.
- * 64-bit fields must be explicitly 64-bit in statfs64.
- */
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
-	__u64 f_blocks;
-	__u64 f_bfree;
-	__u64 f_bavail;
-	__u64 f_files;
-	__u64 f_ffree;
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
+#define __statfs_word long
+#include <asm-generic/statfs.h>
 
 #endif
-- 
1.5.5.1
-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
