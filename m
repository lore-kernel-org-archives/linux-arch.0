From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 11/39] UAPI: Fix nested __KERNEL__ guards in
 video/edid.h
Date: Fri, 08 Jul 2011 15:24:41 +0100
Message-ID: <20110708142441.31344.91616.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32557 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752229Ab1GHOZY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:25:24 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

Fix nested __KERNEL__ guards in video/edid.h to make parsing easier.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/video/edid.h |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/video/edid.h b/include/video/edid.h
index 928c342..c5f1987 100644
--- a/include/video/edid.h
+++ b/include/video/edid.h
@@ -1,16 +1,14 @@
 #ifndef __linux_video_edid_h__
 #define __linux_video_edid_h__
 
-#if !defined(__KERNEL__) || defined(CONFIG_X86)
-
 struct edid_info {
 	unsigned char dummy[128];
 };
 
 #ifdef __KERNEL__
+#ifdef CONFIG_X86
 extern struct edid_info edid_info;
-#endif /* __KERNEL__ */
-
+#endif
 #endif
 
 #endif /* __linux_video_edid_h__ */
