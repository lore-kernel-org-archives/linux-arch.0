From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 22/39] UAPI: Fix drmP.h to use #include <...> when
 referring to system header files
Date: Fri, 08 Jul 2011 15:26:32 +0100
Message-ID: <20110708142631.31344.19233.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49113 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818Ab1GHO1N (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:27:13 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

Fix drmP.h to use #include <...> when referring to system header files,
otherwise #include_next breaks.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/drm/drmP.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/drm/drmP.h b/include/drm/drmP.h
index 00c02fc..fc13402 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -73,7 +73,11 @@
 #include <linux/workqueue.h>
 #include <linux/poll.h>
 #include <asm/pgalloc.h>
+#ifdef __KERNEL__
 #include <drm/drm.h>
+#else
+#include "drm.h"
+#endif
 
 #include <linux/idr.h>
 
@@ -83,9 +87,15 @@
 struct drm_file;
 struct drm_device;
 
+#ifdef __KERNEL__
 #include <drm/drm_os_linux.h>
 #include <drm/drm_hashtab.h>
 #include <drm/drm_mm.h>
+#else
+#include "drm_os_linux.h"
+#include "drm_hashtab.h"
+#include "drm_mm.h"
+#endif
 
 #define DRM_UT_CORE 		0x01
 #define DRM_UT_DRIVER		0x02
