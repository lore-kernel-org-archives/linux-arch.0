Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46382 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967776Ab2EQWOF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 May 2012 18:14:05 -0400
From: "H.J. Lu" <hjl.tools@gmail.com>
Subject: [PATCH 09/10] Use __kernel_ulong_t in struct ipc64_perm
Date: Thu, 17 May 2012 15:13:35 -0700
Message-ID: <1337292816-10839-10-git-send-email-hjl.tools@gmail.com>
In-Reply-To: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: torvalds@linux-foundation.org, hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de, "H.J. Lu" <hjl.tools@gmail.com>
Message-ID: <20120517221335.Efr0Zgl7xjBSNIH8eTUGVHTKV4_f4Gq0IK6UMlEwTQ4@z>

From: "H.J. Lu" <hjl.tools@gmail.com>

Replace unsigned long with __kernel_ulong_t in struct ipc64_perm for
user space.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
---
 include/asm-generic/ipcbuf.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/ipcbuf.h b/include/asm-generic/ipcbuf.h
index 76982b2..3dbcc1e 100644
--- a/include/asm-generic/ipcbuf.h
+++ b/include/asm-generic/ipcbuf.h
@@ -27,8 +27,8 @@ struct ipc64_perm {
 	unsigned char		__pad1[4 - sizeof(__kernel_mode_t)];
 	unsigned short		seq;
 	unsigned short		__pad2;
-	unsigned long		__unused1;
-	unsigned long		__unused2;
+	__kernel_ulong_t	__unused1;
+	__kernel_ulong_t	__unused2;
 };
 
 #endif /* __ASM_GENERIC_IPCBUF_H */
-- 
1.7.6.5

