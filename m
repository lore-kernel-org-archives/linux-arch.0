From: David Howells <dhowells@redhat.com>
Subject: [PATCH 12/35] UAPI: Fix definition of HZ in asm-generic/param.h
Date: Sat, 02 Jul 2011 12:09:18 +0100
Message-ID: <20110702110918.21948.36239.stgit@warthog.procyon.org.uk>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18345 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754122Ab1GBLJW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jul 2011 07:09:22 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p62B9Mba028449
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Sat, 2 Jul 2011 07:09:22 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

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
