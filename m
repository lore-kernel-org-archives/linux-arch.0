From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: RE: [PATCH 4/6v3] byteorder: wire up arches to use new headers
Date: Wed, 28 May 2008 13:31:59 -0700
Message-ID: <1212006719.5964.39.camel@brick>
References: <1212003182.5964.29.camel@brick>
	 <1FE6DD409037234FAB833C420AA843EC016FFBC4@orsmsx424.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:36949 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbYE1UcB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 May 2008 16:32:01 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2688293wfd.4
        for <linux-arch@vger.kernel.org>; Wed, 28 May 2008 13:32:00 -0700 (PDT)
In-Reply-To: <1FE6DD409037234FAB833C420AA843EC016FFBC4@orsmsx424.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, Andrew Morton <akpm@linux-foundation.org>

On Wed, 2008-05-28 at 13:21 -0700, Luck, Tony wrote:
> > diff --git a/include/asm-ia64/byteorder.h b/include/asm-ia64/byteorder.h
> >
> > -static __inline__ __attribute_const__ __u64
> > -__ia64_swab64 (__u64 x)
> > +#define __LITTLE_ENDIAN
> > +
> > +static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
> 
> You've changed the name of this routine from __ia64_swab64
> to __arch_swab64 here.
> 
> ...
> 
> But down below you still use the old name (twice):
> 
> > 	return __ia64_swab64(x) >> 32;
> 
> > 	return __ia64_swab64(x) >> 48;
> 
> Changing these calls to use the new name gets the build a lot further, but
> it still dies for me at:

Sorry about that, it was a last minute change that I shouldn't have made
to the __const_swab macros.  Here's a revert of that part, I'll also
check over the arch bits, but I think I just applied the wrong patch
when folding some other fixes together, thanks for testing:

diff --git a/include/linux/swab.h b/include/linux/swab.h
index 7dfb411..8f955b2 100644
--- a/include/linux/swab.h
+++ b/include/linux/swab.h
@@ -9,38 +9,33 @@
  * casts are necessary for constants, because we never know how for sure
  * how U/UL/ULL map to __u16, __u32, __u64. At least not in a portable way.
  */
-#define __const_swab16(x) ({					\
-	__u16 __x = (x);					\
-	((__x & (__u16)0x00ffU) << 8) |				\
-	((__x & (__u16)0xff00U) >> 8); })
+#define __const_swab16(x) ((__u16)(				\
+	(((__u16)(x) & (__u16)0x00ffU) << 8) |			\
+	(((__u16)(x) & (__u16)0xff00U) >> 8)))
 
-#define __const_swab32(x) ({					\
-	__u32 __x = (x);					\
-	((__x & (__u32)0x000000ffUL) << 24) |			\
-	((__x & (__u32)0x0000ff00UL) <<  8) |			\
-	((__x & (__u32)0x00ff0000UL) >>  8) |			\
-	((__x & (__u32)0xff000000UL) >> 24); })
+#define __const_swab32(x) ((__u32)(				\
+	(((__u32)(x) & (__u32)0x000000ffUL) << 24) |		\
+	(((__u32)(x) & (__u32)0x0000ff00UL) <<  8) |		\
+	(((__u32)(x) & (__u32)0x00ff0000UL) >>  8) |		\
+	(((__u32)(x) & (__u32)0xff000000UL) >> 24)))
 
-#define __const_swab64(x) ({					\
-	__u64 __x = (x);					\
-	((__x & (__u64)0x00000000000000ffULL) << 56) |		\
-	((__x & (__u64)0x000000000000ff00ULL) << 40) |		\
-	((__x & (__u64)0x0000000000ff0000ULL) << 24) |		\
-	((__x & (__u64)0x00000000ff000000ULL) <<  8) |		\
-	((__x & (__u64)0x000000ff00000000ULL) >>  8) |		\
-	((__x & (__u64)0x0000ff0000000000ULL) >> 24) |		\
-	((__x & (__u64)0x00ff000000000000ULL) >> 40) |		\
-	((__x & (__u64)0xff00000000000000ULL) >> 56); })
+#define __const_swab64(x) ((__u64)(				\
+	(((__u64)(x) & (__u64)0x00000000000000ffULL) << 56) |	\
+	(((__u64)(x) & (__u64)0x000000000000ff00ULL) << 40) |	\
+	(((__u64)(x) & (__u64)0x0000000000ff0000ULL) << 24) |	\
+	(((__u64)(x) & (__u64)0x00000000ff000000ULL) <<  8) |	\
+	(((__u64)(x) & (__u64)0x000000ff00000000ULL) >>  8) |	\
+	(((__u64)(x) & (__u64)0x0000ff0000000000ULL) >> 24) |	\
+	(((__u64)(x) & (__u64)0x00ff000000000000ULL) >> 40) |	\
+	(((__u64)(x) & (__u64)0xff00000000000000ULL) >> 56)))
 
-#define __const_swahw32(x) ({					\
-	__u32 __x = (x);					\
-	((__x & (__u32)0x0000ffffUL) << 16) |			\
-	((__x & (__u32)0xffff0000UL) >> 16); })
+#define __const_swahw32(x) ((__u32)(				\
+	(((__u32)(x) & (__u32)0x0000ffffUL) << 16) |		\
+	(((__u32)(x) & (__u32)0xffff0000UL) >> 16)))
 
-#define __const_swahb32(x) ({					\
-	__u32 __x = (x);					\
-	((__x & (__u32)0x00ff00ffUL) << 8) |			\
-	((__x & (__u32)0xff00ff00UL) >> 8); })
+#define __const_swahb32(x) ((__u32)(				\
+	(((__u32)(x) & (__u32)0x00ff00ffUL) << 8) |		\
+	(((__u32)(x) & (__u32)0xff00ff00UL) >> 8)))
 
 /*
  * Implement the following as inlines, but define the interface using
