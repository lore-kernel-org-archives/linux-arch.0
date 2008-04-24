Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.183]:54083 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589AbYDXViA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Apr 2008 17:38:00 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: microblaze syscall list
Date: Thu, 24 Apr 2008 23:37:52 +0200
References: <4988.7968-24314-1195487808-1209070282@seznam.cz>
In-Reply-To: <4988.7968-24314-1195487808-1209070282@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200804242337.53681.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <Monstr@seznam.cz>
Cc: Will Newton <will.newton@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, git@xilinx.com, microblaze-uclinux@itee.uq.edu.au
Message-ID: <20080424213752.ZkPilGIeAox6N3CvzhtSAnXpti4ORvB3ze9MTWXQORw@z>

On Thursday 24 April 2008, Michal Simek wrote:
> Hi Arnd,
> here is current syscall table - I only rewrite your changes. I remove sys_ni_syscall except from #ifdefs. 
> I would like to match syscalls to logical block. Can I do it? (I'll fix unistd.h later)

yes, that makes a lot of sense to me. If we introduce a new
asm-generic/unistd.h, it's good to have it sorted in some
meaningful way, even if it is going to get messier over time.

> Can you look at it if I remove old syscalls? 
> I will continue tomorrow I am tired.

ok, I'll look at it tomorrow.

> 
> #ifdef __ARCH_WANT_SYS_SIGNAL
> 	.long sys_signal
> #else
> 	.long sys_ni_syscall
> #endif
> #ifdef __ARCH_WANT_SYS_TIME
> 	.long sys_time
> 	.long sys_stime
> #else
> 	.long sys_ni_syscall
> 	.long sys_ni_syscall
> #endif

I guess I wasn't entirely clear with what I mean referring to
__ARCH_WANT_SYS_*. Instead of adding the #ifdef here, I meant
you should just remove the call entirely. With a few exceptions
that I already mentioned, the fact that there is an __ARCH_WANT
check in the syscall definition means that new architectures
should not reference the call, nor #define the __ARCH_WANT macro.

	Arnd <><
