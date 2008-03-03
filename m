From: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] Use U64_C() instead of casts in kernel/time.c
Date: Sun, 2 Mar 2008 16:09:56 -0800
Message-ID: <b5b828ae3f1d4edff5509ba64a98bdba283a28e0@tazenda.hos.anvin.org>
References: <4a8566f54ff84f498c5c0c0340076c296b1840e6@tazenda.hos.anvin.org>
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4a8566f54ff84f498c5c0c0340076c296b1840e6-TYXNXmPMDn57u0wkx6qpVYSLwOllVvif@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

Use the new U64_C() constructor macro instead of using casts for
constants in kernel/time.c.  This avoids warnings with some gcc
versions.

This resolves Bugzilla 10153.

Signed-off-by: H. Peter Anvin <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
---
 kernel/time.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time.c b/kernel/time.c
index a5ec013..47b24f4 100644
--- a/kernel/time.c
+++ b/kernel/time.c
@@ -244,7 +244,7 @@ unsigned int inline jiffies_to_msecs(const unsigned long j)
 	return (j + (HZ / MSEC_PER_SEC) - 1)/(HZ / MSEC_PER_SEC);
 #else
 # if BITS_PER_LONG == 32
-	return ((u64)HZ_TO_MSEC_MUL32 * j) >> HZ_TO_MSEC_SHR32;
+	return (U64_C(HZ_TO_MSEC_MUL32) * j) >> HZ_TO_MSEC_SHR32;
 # else
 	return (j * HZ_TO_MSEC_NUM) / HZ_TO_MSEC_DEN;
 # endif
@@ -260,7 +260,7 @@ unsigned int inline jiffies_to_usecs(const unsigned long j)
 	return (j + (HZ / USEC_PER_SEC) - 1)/(HZ / USEC_PER_SEC);
 #else
 # if BITS_PER_LONG == 32
-	return ((u64)HZ_TO_USEC_MUL32 * j) >> HZ_TO_USEC_SHR32;
+	return (U64_C(HZ_TO_USEC_MUL32) * j) >> HZ_TO_USEC_SHR32;
 # else
 	return (j * HZ_TO_USEC_NUM) / HZ_TO_USEC_DEN;
 # endif
@@ -469,7 +469,7 @@ unsigned long msecs_to_jiffies(const unsigned int m)
 	if (HZ > MSEC_PER_SEC && m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
 		return MAX_JIFFY_OFFSET;
 
-	return ((u64)MSEC_TO_HZ_MUL32 * m + MSEC_TO_HZ_ADJ32)
+	return (U64_C(MSEC_TO_HZ_MUL32) * m + MSEC_TO_HZ_ADJ32)
 		>> MSEC_TO_HZ_SHR32;
 #endif
 }
@@ -484,7 +484,7 @@ unsigned long usecs_to_jiffies(const unsigned int u)
 #elif HZ > USEC_PER_SEC && !(HZ % USEC_PER_SEC)
 	return u * (HZ / USEC_PER_SEC);
 #else
-	return ((u64)USEC_TO_HZ_MUL32 * u + USEC_TO_HZ_ADJ32)
+	return (U64_C(USEC_TO_HZ_MUL32) * u + USEC_TO_HZ_ADJ32)
 		>> USEC_TO_HZ_SHR32;
 #endif
 }
-- 
1.5.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
