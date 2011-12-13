From: David Howells <dhowells@redhat.com>
Subject: [PATCH 09/17] UAPI: Guard linux/isdn_divertif.h
Date: Tue, 13 Dec 2011 10:04:05 +0000
Message-ID: <1323770653-19177-10-git-send-email-dhowells@redhat.com>
References: <1323770653-19177-1-git-send-email-dhowells@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323770653-19177-1-git-send-email-dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sfr@canb.auug.org.au, torvalds@linux-foundation.org
Cc: arnd@arndb.de, dhowells@redhat.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Place reinclusion guards on linux/isdn_divertif.h otherwise the UAPI splitter
script won't insert the #include to include the UAPI header from the kernel
header.

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
-- 
1.7.7.4
