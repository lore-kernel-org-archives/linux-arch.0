Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:14754 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1751108AbWHZBRp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Aug 2006 21:17:45 -0400
Date: Sat, 26 Aug 2006 10:17:37 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
Message-ID: <20060826011737.GA10344@localhost.usen.ad.jp>
References: <20060824234445.6B519D52@localhost.localdomain> <20060825053127.GA9066@localhost.hsdv.com> <1156539879.12011.206.camel@localhost.localdomain> <20060824234445.6B519D52@localhost.localdomain> <20060825053127.GA9066@localhost.hsdv.com> <1156518223.12011.175.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156539879.12011.206.camel@localhost.localdomain> <1156518223.12011.175.camel@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Aug 25, 2006 at 08:03:43AM -0700, Dave Hansen wrote:
> On Fri, 2006-08-25 at 14:31 +0900, Paul Mundt wrote:
> I just changed this around a little bit so that only the architectures
> that care see the prompt:
> 
> > choice
> >         prompt "Kernel Page Size"
> >         depends on IA64 || SPARC64 || PARISC || MIPS
> >         default PAGE_SIZE_4KB if MIPS
> >         default PAGE_SIZE_8KB if IA64 || SPARC64 || PARISC
> > config PAGE_SIZE_4KB
> ...
> 
> That at least consolidates the four architectures.  I guess I could move
> them back, but some of the help text was _really_ similar and it all
> seemed pretty redundant.
> 
With only 4 architectures it's manageable, but I wonder what will happen
as more architectures decide to make this configurable. The number of
architectures is constantly growing, is it really worth having
centralized config options with special casing for virtually every
architecture supported by the kernel? This seems like a questionable
precedent to set and follow.

On the other hand, consolidating the help text is not a bad idea.
Amusingly this would not have been a problem with Configure.help ;-)

On Fri, Aug 25, 2006 at 02:04:39PM -0700, Dave Hansen wrote:
> On Fri, 2006-08-25 at 14:31 +0900, Paul Mundt wrote:
> > I like the idea of asm-generic/page_size.h (though why not just use
> > asm-generic/page.h?)
> 
> One reason is that get_order() is defined on a few architectures.  There
> would need to be some separate Kconfig and #ifdef work to get it
> conditionally defined.
> 
What about HAVE_ARCH_GET_ORDER? We've done it for just about everything
else, and there aren't many users.

--

 include/asm-generic/page.h |    2 ++
 include/asm-ia64/page.h    |    3 +++
 include/asm-ppc/page.h     |    2 ++
 include/asm-xtensa/page.h  |    2 ++
 4 files changed, 9 insertions(+)

diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
index a96b5d9..c7a3153 100644
--- a/include/asm-generic/page.h
+++ b/include/asm-generic/page.h
@@ -6,6 +6,7 @@ #ifndef __ASSEMBLY__
 
 #include <linux/compiler.h>
 
+#ifndef HAVE_ARCH_GET_ORDER
 /* Pure 2^n version of get_order */
 static __inline__ __attribute_const__ int get_order(unsigned long size)
 {
@@ -19,6 +20,7 @@ static __inline__ __attribute_const__ in
 	} while (size);
 	return order;
 }
+#endif
 
 #endif	/* __ASSEMBLY__ */
 #endif	/* __KERNEL__ */
diff --git a/include/asm-ia64/page.h b/include/asm-ia64/page.h
index f5a949e..a4108b6 100644
--- a/include/asm-ia64/page.h
+++ b/include/asm-ia64/page.h
@@ -174,6 +174,9 @@ get_order (unsigned long size)
 	return order;
 }
 
+#define HAVE_ARCH_GET_ORDER
+#include <asm-generic/page.h>
+
 # endif /* __KERNEL__ */
 #endif /* !__ASSEMBLY__ */
 
diff --git a/include/asm-ppc/page.h b/include/asm-ppc/page.h
index fe95c82..a4073e8 100644
--- a/include/asm-ppc/page.h
+++ b/include/asm-ppc/page.h
@@ -172,7 +172,9 @@ #define VM_DATA_DEFAULT_FLAGS	(VM_READ |
 
 /* We do define AT_SYSINFO_EHDR but don't use the gate mechanism */
 #define __HAVE_ARCH_GATE_AREA		1
+#define HAVE_ARCH_GET_ORDER
 
 #include <asm-generic/memory_model.h>
+#include <asm-generic/page.h>
 #endif /* __KERNEL__ */
 #endif /* _PPC_PAGE_H */
diff --git a/include/asm-xtensa/page.h b/include/asm-xtensa/page.h
index 40f4c6c..b19e409 100644
--- a/include/asm-xtensa/page.h
+++ b/include/asm-xtensa/page.h
@@ -80,6 +80,7 @@ #else
 #endif
 }
 
+#define HAVE_ARCH_GET_ORDER
 
 struct page;
 extern void clear_page(void *page);
@@ -127,4 +128,5 @@ #define VM_DATA_DEFAULT_FLAGS	(VM_READ |
 
 #endif /* __KERNEL__ */
 #include <asm-generic/memory_model.h>
+#include <asm-generic/page.h>
 #endif /* _XTENSA_PAGE_H */
