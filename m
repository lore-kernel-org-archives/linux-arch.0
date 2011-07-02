From: David Howells <dhowells@redhat.com>
Subject: [PATCH 09/35] UAPI: Fix nested __KERNEL__ guards in video/edid.h
Date: Sat, 02 Jul 2011 12:08:51 +0100
Message-ID: <20110702110851.21948.71293.stgit@warthog.procyon.org.uk>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40337 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201Ab1GBLIz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jul 2011 07:08:55 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p62B8shJ028413
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Sat, 2 Jul 2011 07:08:55 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

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
