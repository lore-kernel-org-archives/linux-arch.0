From: David Howells <dhowells@redhat.com>
Subject: [PATCH 20/35] UAPI: Fix drmP.h to use #include <...> when referring
 to system header files
Date: Sat, 02 Jul 2011 12:10:28 +0100
Message-ID: <20110702111027.21948.17321.stgit@warthog.procyon.org.uk>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32569 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754332Ab1GBLKc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jul 2011 07:10:32 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p62BAVbO019375
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Sat, 2 Jul 2011 07:10:31 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

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
