From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH/RFC 01/16] compat: let architectures define
 __ARCH_WANT_COMPAT_SYS_GETDENTS64
Date: Thu, 20 Mar 2014 15:51:28 +0100
Message-ID: <20140320145128.GE4403@osiris>
References: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
 <1394121083-2507-2-git-send-email-heiko.carstens@de.ibm.com>
 <CAMuHMdUqjhcmaRo-2=qr_DgbXoj9bAGfvzuRPDZ+tOMx6Hvr-Q@mail.gmail.com>
 <20140320113333.GD4403@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:44412 "EHLO
	e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933546AbaCTOve (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Mar 2014 10:51:34 -0400
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 20 Mar 2014 14:51:32 -0000
Content-Disposition: inline
In-Reply-To: <20140320113333.GD4403@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Al Viro <viro@zeniv.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Linux-Arch <linux-arch@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Linux-Next <linux-next@vger.kernel.org>, Chris Metcalf <cmetcalf@tilera.com>

On Thu, Mar 20, 2014 at 12:33:33PM +0100, Heiko Carstens wrote:
> On Thu, Mar 20, 2014 at 11:03:14AM +0100, Geert Uytterhoeven wrote:
> > On Thu, Mar 6, 2014 at 4:51 PM, Heiko Carstens
> > <heiko.carstens@de.ibm.com> wrote:
> > > For architecture dependent compat syscalls in common code an architecture
> > > must define something like __ARCH_WANT_<WHATEVER> if it wants to use the
> > > code.
> > > This however is not true for compat_sys_getdents64 for which architectures
> > > must define __ARCH_OMIT_COMPAT_SYS_GETDENTS64 if they do not want the code.
> > >
> > > This leads to the situation where all architectures, except mips, get the
> > > compat code but only x86_64, arm64 and the generic syscall architectures
> > > actually use it.
> > >
> > > So invert the logic, so that architectures actively must do something to
> > > get the compat code.
> > >
> > > This way a couple of architectures get rid of otherwise dead code.
> > >
> > > Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> > 
> > Is this the cause of the tilegx_defconfig failures in -next?
> > 
> > include/uapi/asm-generic/unistd.h:195:1: error:
> > 'compat_sys_getdents64' undeclared here (not in a function)
> > make[3]: *** [arch/tile/kernel/compat.o] Error 1
> > 
> > http://kisskb.ellerman.id.au/kisskb/buildresult/10808012/
> 
> Yes. That's unexpected header include order from my side...
> Looking into it. Thanks!

I think the simple patch below should fix the compile error.
Unfortunately I don't have a tile cross compiler.

But at least s390, x86_64, sparc64 and mip64 still compile, so it
looks like I'm not immediatly lost in include order hell.

(pushed to the s390 compat branch, so the next linux-next release
 should contain the fix)

From f80f4cd232c56f491ecbeea3dd0627598b59b61e Mon Sep 17 00:00:00 2001
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Thu, 20 Mar 2014 15:30:14 +0100
Subject: [PATCH] compat: include linux/unistd.h within linux/compat.h

linux/compat.h does not include linux/unistd.h but the compat.h header
file contains various conditional

 #ifdef __ARCH_WANT_COMPAT_...
 asmlinkage long compat...()
 #endif

compat system call function declarations.
If linux/unistd.h isn't included it depends on previous includes if those
__ARCH_WANT_COMPAT_... defines are defined or not. So add an additional
linux/unistd.h include.

Should fix this compile error on tile:

include/uapi/asm-generic/unistd.h:195:1: error: 'compat_sys_getdents64' undeclared
make[3]: *** [arch/tile/kernel/compat.o] Error 1

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 include/linux/compat.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 7c765624b7ef..01c0aa57ccec 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -14,6 +14,7 @@
 #include <linux/if.h>
 #include <linux/fs.h>
 #include <linux/aio_abi.h>	/* for aio_context_t */
+#include <linux/unistd.h>
 
 #include <asm/compat.h>
 #include <asm/siginfo.h>
-- 
1.8.5.5
