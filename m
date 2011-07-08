From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 27/39] UAPI: Guard linux/isdn_divertif.h
Date: Fri, 08 Jul 2011 15:27:20 +0100
Message-ID: <20110708142720.31344.49755.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37209 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218Ab1GHO2B (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:28:01 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

Place reinclusion guards on linux/isdn_divertif.h otherwise the splitter
script won't insert a #include_next.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/isdn_divertif.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/isdn_divertif.h b/include/linux/isdn_divertif.h
index 07821ca..a5a50f5 100644
--- a/include/linux/isdn_divertif.h
+++ b/include/linux/isdn_divertif.h
@@ -10,6 +10,8 @@
  *
  */
 
+#ifndef _LINUX_ISDN_DIVERTIF_H
+#define _LINUX_ISDN_DIVERTIF_H
 
 /***********************************************************/
 /* magic value is also used to control version information */
@@ -45,3 +47,5 @@ typedef struct
 /*********************/
 extern int DIVERT_REG_NAME(isdn_divert_if *);
 #endif
+
+#endif /* _LINUX_ISDN_DIVERTIF_H */
