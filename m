From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v4 4/4] asm-generic: remove _STK_LIM_MAX
Date: Wed, 14 May 2014 13:52:48 +0100
Message-ID: <1400071968-21581-5-git-send-email-james.hogan@imgtec.com>
References: <1400071968-21581-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:60878 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755560AbaENMxC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 May 2014 08:53:02 -0400
In-Reply-To: <1400071968-21581-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: James Hogan <james.hogan@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, John David Anglin <dave.anglin@bell.net>

_STK_LIM_MAX could be used to override the RLIMIT_STACK hard limit from
an arch's include/uapi/asm-generic/resource.h file, but is no longer
used since both parisc and metag removed the override. Therefore remove
it entirely, setting the hard RLIMIT_STACK limit to RLIM_INFINITY
directly in include/asm-generic/resource.h.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>
Cc: John David Anglin <dave.anglin@bell.net>
---
This one will need to be applied after both the metag and parisc patches
which remove the overrides.
---
 include/asm-generic/resource.h      | 2 +-
 include/uapi/asm-generic/resource.h | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/asm-generic/resource.h b/include/asm-generic/resource.h
index b4ea8f50fc65..5e752b959054 100644
--- a/include/asm-generic/resource.h
+++ b/include/asm-generic/resource.h
@@ -12,7 +12,7 @@
 	[RLIMIT_CPU]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
 	[RLIMIT_FSIZE]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
 	[RLIMIT_DATA]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
-	[RLIMIT_STACK]		= {       _STK_LIM,   _STK_LIM_MAX },	\
+	[RLIMIT_STACK]		= {       _STK_LIM,  RLIM_INFINITY },	\
 	[RLIMIT_CORE]		= {              0,  RLIM_INFINITY },	\
 	[RLIMIT_RSS]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
 	[RLIMIT_NPROC]		= {              0,              0 },	\
diff --git a/include/uapi/asm-generic/resource.h b/include/uapi/asm-generic/resource.h
index f863428796d5..c6d10af50123 100644
--- a/include/uapi/asm-generic/resource.h
+++ b/include/uapi/asm-generic/resource.h
@@ -57,12 +57,5 @@
 # define RLIM_INFINITY		(~0UL)
 #endif
 
-/*
- * RLIMIT_STACK default maximum - some architectures override it:
- */
-#ifndef _STK_LIM_MAX
-# define _STK_LIM_MAX		RLIM_INFINITY
-#endif
-
 
 #endif /* _UAPI_ASM_GENERIC_RESOURCE_H */
-- 
1.9.3
