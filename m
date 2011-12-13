From: David Howells <dhowells@redhat.com>
Subject: [PATCH 13/17] UAPI: Fix nested __KERNEL__ guards in video/edid.h
Date: Tue, 13 Dec 2011 10:04:09 +0000
Message-ID: <1323770653-19177-14-git-send-email-dhowells@redhat.com>
References: <1323770653-19177-1-git-send-email-dhowells@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323770653-19177-1-git-send-email-dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sfr@canb.auug.org.au, torvalds@linux-foundation.org
Cc: arnd@arndb.de, dhowells@redhat.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
-- 
1.7.7.4
