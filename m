Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:1216 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262730AbUDHUYn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2004 16:24:43 -0400
Date: Thu, 8 Apr 2004 13:24:28 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: posix message queues
Message-Id: <20040408132428.416044ef.akpm@osdl.org>
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

It broke ppc64.   Please check other architectures for the same pattern.



In file included from arch/ppc64/kernel/signal.c:29:
include/asm/ppc32.h:144: redefinition of `struct compat_sigevent'
include/asm/ppc32.h:156: redefinition of `compat_sigevent_t'
include/linux/compat.h:107: `compat_sigevent_t' previously declared here


---

 25-power4-akpm/include/asm-ppc64/ppc32.h |   14 --------------
 1 files changed, 14 deletions(-)

diff -puN include/asm-ppc64/ppc32.h~compat_mq-ppc-fix include/asm-ppc64/ppc32.h
--- 25-power4/include/asm-ppc64/ppc32.h~compat_mq-ppc-fix	2004-04-08 13:21:48.262814248 -0700
+++ 25-power4-akpm/include/asm-ppc64/ppc32.h	2004-04-08 13:22:35.262669184 -0700
@@ -141,20 +141,6 @@ struct ucontext32 { 
 	struct mcontext32	uc_mcontext;
 };
 
-typedef struct compat_sigevent {
-	compat_sigval_t sigev_value;
-	int sigev_signo;
-	int sigev_notify;
-	union {
-		int _pad[SIGEV_PAD_SIZE];
-		int _tid;
-		struct {
-			compat_uptr_t _function;
-			compat_uptr_t _attribute;
-		} _sigev_thread;
-	} _sigev_un;
-} compat_sigevent_t;
-
 struct ipc_kludge_32 {
 	unsigned int msgp;
 	int msgtyp;

_
