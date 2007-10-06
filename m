Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48168 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752893AbXJFKos (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 6 Oct 2007 06:44:48 -0400
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 10E4D22F76
	for <linux-arch@vger.kernel.org>; Sat,  6 Oct 2007 12:44:47 +0200 (CEST)
From: Andi Kleen <ak@suse.de>
Subject: Using __builtin_prefetch everywhere
Date: Sat, 6 Oct 2007 12:44:44 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710061244.44127.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Hallo,

Since there were some issues with the x86-64 prefetch I decided
to switch the standard prefetch over to gcc's __builtin_prefetch.
Since gcc supports this on all architectures I did that change
for everybody: if you don't define a ARCH_HAS_PREFETCH it will
use __builtin_prefetch(x) and the same with ARCH_HAS_PREFETCHW.

If you know of any problems with the __builtin_prefetch
(e.g. gcc miscompiling it) please complain now. The right fix
would be then to define a ARCH_HAS_PREFETCH{,w}

-Andi

Use __builtin_prefetch 

gcc 3.2+ supports __builtin_prefetch, so it's possible to use it on all architectures.
Change the generic fallback in linux/prefetch.h to use it instead of noping it out.
gcc should do the right thing when the architecture doesn't support prefetching

Undefine the x86-64 inline assembler version and use the fallback.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/include/asm-x86_64/processor.h
===================================================================
--- linux.orig/include/asm-x86_64/processor.h
+++ linux/include/asm-x86_64/processor.h
@@ -368,12 +368,6 @@ static inline void sync_core(void)
 	asm volatile("cpuid" : "=a" (tmp) : "0" (1) : "ebx","ecx","edx","memory");
 } 
 
-#define ARCH_HAS_PREFETCH
-static inline void prefetch(void *x) 
-{ 
-	asm volatile("prefetcht0 %0" :: "m" (*(unsigned long *)x));
-} 
-
 #define ARCH_HAS_PREFETCHW 1
 static inline void prefetchw(void *x) 
 { 
Index: linux/include/linux/prefetch.h
===================================================================
--- linux.orig/include/linux/prefetch.h
+++ linux/include/linux/prefetch.h
@@ -34,17 +34,12 @@
 	
 */
 
-/*
- *	These cannot be do{}while(0) macros. See the mental gymnastics in
- *	the loop macro.
- */
- 
 #ifndef ARCH_HAS_PREFETCH
-static inline void prefetch(const void *x) {;}
+#define prefetch(x) __builtin_prefetch(x) 
 #endif
 
 #ifndef ARCH_HAS_PREFETCHW
-static inline void prefetchw(const void *x) {;}
+#define prefetchw(x) __builtin_prefetch(x,1)
 #endif
 
 #ifndef ARCH_HAS_SPINLOCK_PREFETCH
