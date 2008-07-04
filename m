From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH 3/5] byteorder: wire up arches to use new headers
Date: Fri, 04 Jul 2008 10:23:59 -0700
Message-ID: <1215192239.16647.84.camel@brick>
References: <1215144733.16647.69.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:12751 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbYGDRYC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jul 2008 13:24:02 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1260945wfd.4
        for <linux-arch@vger.kernel.org>; Fri, 04 Jul 2008 10:24:02 -0700 (PDT)
In-Reply-To: <1215144733.16647.69.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

=EF=BB=BFSigned-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
rebasing to today's next, noticed a conflict in m68knommu, here's a rev=
ised part
of the arch hook-up.

diff --git a/include/asm-m68knommu/byteorder.h b/include/asm-m68knommu/=
byteorder.h
index 20bb442..8a68b3c 100644
--- a/include/asm-m68knommu/byteorder.h
+++ b/include/asm-m68knommu/byteorder.h
@@ -3,13 +3,11 @@
=20
 #include <linux/types.h>
=20
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__) || defined(__KERNEL=
__)
-#  define __BYTEORDER_HAS_U64__
-#  define __SWAB_64_THRU_32__
-#endif
+#define __BIG_ENDIAN
+#define __SWAB_64_THRU_32__
=20
 #if defined (__mcfisaaplus__) || defined (__mcfisac__)
-static inline __attribute_const__ __u32 ___arch__swab32(__u32 val)
+static inline __attribute_const__ __u32 __arch_swab32(__u32 val)
 {
 	asm(
 			"byterev %0"
@@ -18,10 +16,9 @@ static inline __attribute_const__ __u32 ___arch__swa=
b32(__u32 val)
 	   );
 	return val;
 }
-
-#define __arch__swab32(x) ___arch__swab32(x)
+#define HAVE_ARCH_SWAB32
 #endif
=20
-#include <linux/byteorder/big_endian.h>
+#include <linux/byteorder.h>
=20
 #endif /* _M68KNOMMU_BYTEORDER_H */
