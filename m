From: arnd@arndb.de
Subject: [patch 6/7] coda_psdev: dont export internals to user space
Date: Thu, 26 Feb 2009 00:51:44 +0100
Message-ID: <20090225235515.843118786@arndb.de>
References: <20090225235138.062045835@arndb.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:54105 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbZBZAC1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2009 19:02:27 -0500
Content-Disposition: inline; filename=0002-coda_psdev-don-t-export-internals-to-user-space.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Kyle McMartin <kyle@infradead.org>, Ingo Molnar <mingo@elte.hu>, Jaswinder Singh Rajput <jaswinderrajput@gmail.com>, mingo@redhat.com, dwmw2@infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Most of this header file makes no sense in user space
and should not be exported.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/coda_psdev.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/coda_psdev.h b/include/linux/coda_psdev.h
index 07ae8f8..babce2e 100644
--- a/include/linux/coda_psdev.h
+++ b/include/linux/coda_psdev.h
@@ -6,6 +6,8 @@
 #define CODA_PSDEV_MAJOR 67
 #define MAX_CODADEVS  5	   /* how many do we allow */
 
+#ifdef __KERNEL__
+
 struct kstatfs;
 
 /* communication pending/processing queues */
@@ -90,3 +92,4 @@ struct upc_req {
 extern struct venus_comm coda_comms[];
 
 #endif
+#endif
-- 
1.5.6.3

-- 
