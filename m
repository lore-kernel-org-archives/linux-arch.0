From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 14/39] UAPI: Fix definition of HZ in
 asm-generic/param.h
Date: Fri, 08 Jul 2011 15:25:14 +0100
Message-ID: <20110708142514.31344.60037.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47108 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900Ab1GHO0B (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:26:01 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

Fix definition of HZ in asm-generic/param.h so that the user-specific one is
#undef'd before the kernel-specific one is defined.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/asm-generic/param.h |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/param.h b/include/asm-generic/param.h
index cdf8251..835632a 100644
--- a/include/asm-generic/param.h
+++ b/include/asm-generic/param.h
@@ -1,12 +1,6 @@
 #ifndef __ASM_GENERIC_PARAM_H
 #define __ASM_GENERIC_PARAM_H
 
-#ifdef __KERNEL__
-# define HZ		CONFIG_HZ	/* Internal kernel timer frequency */
-# define USER_HZ	100		/* some user interfaces are */
-# define CLOCKS_PER_SEC	(USER_HZ)       /* in "ticks" like times() */
-#endif
-
 #ifndef HZ
 #define HZ 100
 #endif
@@ -21,4 +15,11 @@
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
 
+#ifdef __KERNEL__
+# undef HZ
+# define HZ		CONFIG_HZ	/* Internal kernel timer frequency */
+# define USER_HZ	100		/* some user interfaces are */
+# define CLOCKS_PER_SEC	(USER_HZ)       /* in "ticks" like times() */
+#endif
+
 #endif /* __ASM_GENERIC_PARAM_H */
