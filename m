From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH-FIX 1/4] fix extra underscore on in-place byteswapping
	methods
Date: Fri, 23 May 2008 15:38:27 -0700
Message-ID: <1211582307.6888.48.camel@brick>
References: <1211580536.6888.43.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:34342 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbYEWWib (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 23 May 2008 18:38:31 -0400
Received: by yw-out-2324.google.com with SMTP id 9so513681ywe.1
        for <linux-arch@vger.kernel.org>; Fri, 23 May 2008 15:38:29 -0700 (PDT)
In-Reply-To: <1211580536.6888.43.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch <linux-arch@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---

 include/linux/swab.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/swab.h b/include/linux/swab.h
index 4898f74..102b992 100644
--- a/include/linux/swab.h
+++ b/include/linux/swab.h
@@ -141,7 +141,7 @@ static inline __u32 __swahb32p(const __u32 *p)
 #endif
 }
 
-static inline void ___swab16s(__u16 *p)
+static inline void __swab16s(__u16 *p)
 {
 #ifdef HAVE_ARCH_SWAB16S
 	__arch_swab16s(p);
@@ -150,7 +150,7 @@ static inline void ___swab16s(__u16 *p)
 #endif
 }
 
-static inline void ___swab32s(__u32 *p)
+static inline void __swab32s(__u32 *p)
 {
 #ifdef HAVE_ARCH_SWAB32S
 	__arch_swab32s(p);
@@ -159,7 +159,7 @@ static inline void ___swab32s(__u32 *p)
 #endif
 }
 
-static inline void ___swab64s(__u64 *p)
+static inline void __swab64s(__u64 *p)
 {
 #ifdef HAVE_ARCH_SWAB64S
 	__arch_swab64s(p);
@@ -168,7 +168,7 @@ static inline void ___swab64s(__u64 *p)
 #endif
 }
 
-static inline void ___swahw32s(__u32 *p)
+static inline void __swahw32s(__u32 *p)
 {
 #ifdef HAVE_ARCH_SWAHW32S
 	__arch_swahw32s(p);
@@ -177,7 +177,7 @@ static inline void ___swahw32s(__u32 *p)
 #endif
 }
 
-static inline void ___swahb32s(__u32 *p)
+static inline void __swahb32s(__u32 *p)
 {
 #ifdef HAVE_ARCH_SWAHB32S
 	__arch_swahb32s(p);
-- 
1.5.5.1.579.g4e43
