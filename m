Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:38040 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750880AbWIATII
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 1 Sep 2006 15:08:08 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k81J87Mg005734
	for <linux-arch@vger.kernel.org>; Fri, 1 Sep 2006 15:08:07 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k81J87fa196752
	for <linux-arch@vger.kernel.org>; Fri, 1 Sep 2006 13:08:07 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k81J87m5016260
	for <linux-arch@vger.kernel.org>; Fri, 1 Sep 2006 13:08:07 -0600
Subject: [PATCH 2/9] conditionally define generic get_order() (ARCH_HAS_GET_ORDER)
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 01 Sep 2006 12:08:06 -0700
References: <20060901190805.C906A21A@localhost.localdomain>
In-Reply-To: <20060901190805.C906A21A@localhost.localdomain>
Message-Id: <20060901190806.5C0E59EC@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Dave Hansen <haveblue@us.ibm.com>
List-ID: <linux-arch.vger.kernel.org>


This patch makes asm-generic/page.h safe to include in lots of code.  This
prepares it for the introduction shortly of the generic PAGE_SIZE code.

There was some discussion that ARCH_HAS_FOO is a disgusting mechanism and
should be wiped off the face of the earth.  It was argued that these things
introduce unnecessary complexity, reduce greppability, and obscure the
conditions under which FOO was defined.  I agree with *ALL* of this.  I
think this patch is different. ;)

This is very greppable.  If you grep and see foo() showing up in
asm-generic/foo.h, it is *obvious* that it is a generic version.  If you
see another version in asm-i386/foo.h, it is also obvious that i386 has
(or can) override the generic one.

As for obscuring the conditions under which it is defined, you do this when
you are either missing a symbol, or have duplicate symbols.  So, you want to
know:

1. *IS* the generic one being defined?
2. When is this generic defined (and how do I turn it off)?
3. How to I get the damn thing defined (if the symbol is missing)?

With Kconfig, this is all easy, especially for arch-specific stuff.

If you requiring that the non-generic symbol be defined first:

	http://article.gmane.org/gmane.linux.kernel/422942/match=very+complex+xyzzy+don+t+want

it gets awfully messy because you end up having to fix up all of the
architectures' headers that define the thing to get rid of any circular
dependencies.

So, is _this_ patch disgusting?

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 threadalloc-dave/include/asm-generic/page.h |    4 +++-
 threadalloc-dave/mm/Kconfig                 |    4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff -puN include/asm-generic/page.h~generic-get_order include/asm-generic/page.h
--- threadalloc/include/asm-generic/page.h~generic-get_order	2006-09-01 11:28:15.000000000 -0700
+++ threadalloc-dave/include/asm-generic/page.h	2006-09-01 11:30:54.000000000 -0700
@@ -6,6 +6,7 @@
 
 #include <linux/compiler.h>
 
+#ifndef CONFIG_ARCH_HAVE_GET_ORDER
 /* Pure 2^n version of get_order */
 static __inline__ __attribute_const__ int get_order(unsigned long size)
 {
@@ -20,7 +21,8 @@ static __inline__ __attribute_const__ in
 	return order;
 }
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* CONFIG_ARCH_HAVE_GET_ORDER */
+#endif /*  __ASSEMBLY__ */
 #endif	/* __KERNEL__ */
 
 #endif	/* _ASM_GENERIC_PAGE_H */
diff -puN mm/Kconfig~generic-get_order mm/Kconfig
--- threadalloc/mm/Kconfig~generic-get_order	2006-09-01 11:28:15.000000000 -0700
+++ threadalloc-dave/mm/Kconfig	2006-09-01 11:30:54.000000000 -0700
@@ -1,3 +1,7 @@
+config ARCH_HAVE_GET_ORDER
+	def_bool y
+	depends on IA64 || PPC32 || XTENSA
+
 config SELECT_MEMORY_MODEL
 	def_bool y
 	depends on EXPERIMENTAL || ARCH_SELECT_MEMORY_MODEL
_
