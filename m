From: David Howells <dhowells@redhat.com>
Subject: [PATCH 25/35] UAPI: Guard linux/isdn_divertif.h
Date: Sat, 02 Jul 2011 12:11:10 +0100
Message-ID: <20110702111109.21948.73903.stgit@warthog.procyon.org.uk>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45427 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753980Ab1GBLLM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jul 2011 07:11:12 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p62BBCBd029254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Sat, 2 Jul 2011 07:11:12 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

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
