From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] making HAVE_SYSCALL_WRAPPERS universal (Re: Issues with "x86, um: switch to generic fork/vfork/clone" commit)
Date: Tue, 22 Jan 2013 15:33:50 +0000
Message-ID: <201301221533.50965.arnd@arndb.de>
References: <50F3D2F2.3080200@6wind.com> <20130121023010.GR4939@ZenIV.linux.org.uk> <20130121225517.GV4939@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:52424 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986Ab3AVPeA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jan 2013 10:34:00 -0500
In-Reply-To: <20130121225517.GV4939@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>

On Monday 21 January 2013, Al Viro wrote:
>         1) alpha, mips
> .weak foo
> foo = sys_ni_syscall
>         2) itanic, ppc
> asmlinkage long x (void) __attribute__((weak,alias("sys_ni_syscall")))
>         3) very common - most of the architectures
> .weak foo
> .set foo sys_ni_syscall
>         3a) blackfin, h8300 - same as (3), except that asm symbols get
> underscore prepended.
> .weak _foo
> .set _foo _sys_ni_syscall

One question here: Is there still a reason why we can't use method 2 on
all architectures now? The comment in a lot of architectures says

 * What we want is __attribute__((weak,alias("sys_ni_syscall")))
 * but it doesn't work on all toolchains, so we just do it by hand

and my guess is that all toolchains we support at this point actually
do allow it, and turn it into the appropriate assembler syntax.

	Arnd
