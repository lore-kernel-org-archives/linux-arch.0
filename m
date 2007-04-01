Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:39532 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964893AbXDAUSq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 1 Apr 2007 16:18:46 -0400
Date: Sun, 1 Apr 2007 22:19:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: missing syscalls
Message-ID: <20070401201929.GB10652@uranus.ravnborg.org>
References: <20070401160123.GA9178@uranus.ravnborg.org> <20070401191511.GA24987@flint.arm.linux.org.uk> <20070401.122345.123969742.davem@davemloft.net> <20070401200947.GB826@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070401200947.GB826@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: David Miller <davem@davemloft.net>, rmk@arm.linux.org.uk, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Apr 01, 2007 at 02:09:47PM -0600, Matthew Wilcox wrote:
> On Sun, Apr 01, 2007 at 12:23:45PM -0700, David Miller wrote:
> > You should hook both of these syscalls up even if the config option
> > that enables them usually is not, or cannot currently be, enabled.
> > 
> > The cond_syscall()'s will make sure they always link properly and
> > provide a -ENOSYS implementation.
> > 
> > Hooking them up makes it easier to check future missed cases without
> > us having to add a plethora of ifdefs to the missing syscall checks
> > for each platform.
> 
> I haven't looked at the missing syscall check implementation, but it seems
> like it's poorly designed if we have to add ifdefs for each arch.  Why not
> allow arches a mechanism to state which syscalls they intentionally
> don't implement?

It's a stupid script so it is easy to fool.
The following patch makes x86_64 shut up:

diff --git a/include/asm-x86_64/unistd.h b/include/asm-x86_64/unistd.h
index c5f596e..6f73918 100644
--- a/include/asm-x86_64/unistd.h
+++ b/include/asm-x86_64/unistd.h
@@ -620,6 +620,9 @@ __SYSCALL(__NR_vmsplice, sys_vmsplice)
 #define __NR_move_pages		279
 __SYSCALL(__NR_move_pages, sys_move_pages)
 
+#define __NR_getcpu             /* 318 - not relevant */
+#define __NR_epoll_pwait        /* 319 - not relevant */
+
 #define __NR_syscall_max __NR_move_pages
 
 #ifndef __NO_STUBS

NOTE - I am NOT proposing this patch. It is purely an example how
to in an arch specific fashion to shut up the syscall check.

