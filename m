Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:51126 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263238AbUCTGhm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 20 Mar 2004 01:37:42 -0500
Date: Fri, 19 Mar 2004 22:37:44 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: compat-signal-noarch-2004-01-29.patch again
Message-Id: <20040319223744.1f003f9f.akpm@osdl.org>
In-Reply-To: <20040320051519.780318b8.ak@suse.de>
References: <20040319214949.6b7d50bc.akpm@osdl.org>
	<20040320051519.780318b8.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org, carlos@baldric.uwo.ca
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen <ak@suse.de> wrote:
>
> On Fri, 19 Mar 2004 21:49:49 -0800
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > 
> > This patch continues to hang around at Morton manor.  last time it was
> > discussed Andi had issues with it and thing petered out.
> > 
> > Can we please wrap this up one ay or the other?
> 
> My only issue was the exporting of is_compat_task() to generic linux/compat.h
> If that is fixed (the code that does the is_compat_task is moved to arch/* 
> again) then the change is fine and I would also likely use it for x86-64.

Cannot you define HAVE_ARCH_IS_COMPAT_TASK?



+#ifndef CONFIG_COMPAT
 
+/* Non-native task requiring compat... doesn't exist */
+#define is_compat_task(x) 0
+
+#else
+
 #include <linux/stat.h>
 #include <linux/param.h>	/* for HZ */
+#include <linux/personality.h>  /* Conditional process compat */
 #include <linux/sem.h>
 
 #include <asm/compat.h>
@@ -17,6 +23,11 @@
 #define compat_jiffies_to_clock_t(x)	\
 		(((unsigned long)(x) * COMPAT_USER_HZ) / HZ)
 
+/* Non-native task requiring compat */
+#ifndef HAVE_ARCH_IS_COMPAT_TASK
+#define is_compat_task(x) (x->personality == PER_LINUX32)
+#endif
+
