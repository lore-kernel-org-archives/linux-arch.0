Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:8383 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264190AbUDHIts (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2004 04:49:48 -0400
Date: Thu, 8 Apr 2004 01:49:31 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: posix message queues
Message-Id: <20040408014931.5d56901f.akpm@osdl.org>
In-Reply-To: <200404081017.46132.arnd@arndb.de>
References: <20040407120720.6b937deb.akpm@osdl.org>
	<40745360.6000709@colorfullife.com>
	<200404081017.46132.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: manfred@colorfullife.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> wrote:
>
> > No. The unix spec mandates 'long' for the final C-library api. Using u32 
>  > would mean that glibc would have to add an emulation layer in user space 
>  > for 64-bit archs. In the long run, 64-bit kernels running 64-bit apps 
>  > will be the common case. I don't want to add an emulation layer to the 
>  > common case.
> 
>  Coincidentally, I have just finished writing handlers for them. 




In file included from kernel/sys.c:8:
include/linux/compat.h:98: error: `SIGEV_PAD_SIZE' undeclared here (not in a function)


---

 25-akpm/include/linux/compat.h |    1 +
 1 files changed, 1 insertion(+)

diff -puN include/linux/compat.h~compat_mq-fix include/linux/compat.h
--- 25/include/linux/compat.h~compat_mq-fix	2004-04-08 01:49:19.539180328 -0700
+++ 25-akpm/include/linux/compat.h	2004-04-08 01:49:19.541180024 -0700
@@ -13,6 +13,7 @@
 #include <linux/sem.h>
 
 #include <asm/compat.h>
+#include <asm/siginfo.h>
 
 #define compat_jiffies_to_clock_t(x)	\
 		(((unsigned long)(x) * COMPAT_USER_HZ) / HZ)

_
