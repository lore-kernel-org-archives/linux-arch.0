Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from x35.xmailserver.org ([64.71.152.41]:54696 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244AbYBFREO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Feb 2008 12:04:14 -0500
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.25 ESMTP Server]
	id <S271AF4> for <linux-arch@vger.kernel.org> from <davidel@xmailserver.org>;
	Wed, 6 Feb 2008 12:04:09 -0500
Date: Wed, 6 Feb 2008 09:04:05 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH] Fix timerfd breakage on avr32
In-Reply-To: <20080206110425.GB25012@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0802060840490.18197@alien.or.mcafeemobile.com>
References: <200802050627.m156R9G9006417@imap1.linux-foundation.org>
 <20080205105454.2c0f8133@dhcp-252-066.norway.atmel.com>
 <20080206110425.GB25012@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, mtk-manpages@gmx.net, tglx@linutronix.de

On Wed, 6 Feb 2008, Russell King wrote:

> On Tue, Feb 05, 2008 at 10:54:54AM +0100, Haavard Skinnemoen wrote:
> > sys_timerfd() has been removed, but avr32 still references it from its
> > syscall table.
> > 
> > Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
> > ---
> > On Mon, 04 Feb 2008 22:27:28 -0800
> > akpm@linux-foundation.org wrote:
> > 
> > > From: Davide Libenzi <davidel@xmailserver.org>
> > > 
> > > Wires up the new timerfd API to the x86 family.
> > 
> > Just one thing...
> > 
> > > diff -puN arch/x86/kernel/syscall_table_32.S~timerfd-v3-wire-the-new-timerfd-api-to-the-x86-family arch/x86/kernel/syscall_table_32.S
> > > --- a/arch/x86/kernel/syscall_table_32.S~timerfd-v3-wire-the-new-timerfd-api-to-the-x86-family
> > > +++ a/arch/x86/kernel/syscall_table_32.S
> > > @@ -321,6 +321,8 @@ ENTRY(sys_call_table)
> > >  	.long sys_epoll_pwait
> > >  	.long sys_utimensat		/* 320 */
> > >  	.long sys_signalfd
> > > -	.long sys_timerfd
> > 
> > The next time you go and remove a system call, could you _please_ post
> > a HUGE warning to linux-arch? Or just do a quick grep and fix it up.

Haavard, that was my fault not Andrew's.  I thought that the patch setting 
it CONFIG_BROKEN carried a syscall unlink from tables.  I should have 
grepped anyway.



> Wasn't there a decision at a kernel summit that anything which adds
> new syscalls should have a test program included so that architecture
> maintainers can test the functionality on their architectures?

It was always there, even before KS:

http://www.xmailserver.org/timerfd-test2.c



> I seem to remember that it came up because the merged timerfd was a
> pile of utter crap which didn't have a hope in hells chance of working.

Your pile of utter crap, was a typo that made the syscall return a 
truncated 32 bit "expired ticks" value (instead of 64 bit), and a wish 
from the manpages maintainer to have a way to retrieve the remaining time.



- Davide


