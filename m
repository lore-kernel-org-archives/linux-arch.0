From: David Howells <dhowells@redhat.com>
Subject: [PATCH 10/17] UAPI: Guard linux/pmu.h
Date: Tue, 13 Dec 2011 10:04:06 +0000
Message-ID: <1323770653-19177-11-git-send-email-dhowells@redhat.com>
References: <1323770653-19177-1-git-send-email-dhowells@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323770653-19177-1-git-send-email-dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sfr@canb.auug.org.au, torvalds@linux-foundation.org
Cc: arnd@arndb.de, dhowells@redhat.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Place reinclusion guards on linux/pmu.h otherwise the UAPI splitter won't
insert the #include to include the UAPI header from the kernel header.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 include/linux/pmu.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/pmu.h b/include/linux/pmu.h
index cafe98d..84e6a55 100644
--- a/include/linux/pmu.h
+++ b/include/linux/pmu.h
@@ -6,6 +6,8 @@
  * Copyright (C) 1998 Paul Mackerras.
  */
 
+#ifndef _LINUX_PMU_H
+#define _LINUX_PMU_H
 
 #define PMU_DRIVER_VERSION	2
 
@@ -207,3 +209,5 @@ extern int pmu_sys_suspended;
 #endif
 
 #endif	/* __KERNEL__ */
+
+#endif /* _LINUX_PMU_H */
-- 
1.7.7.4
