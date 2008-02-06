Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52104 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526AbYBFLGT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Feb 2008 06:06:19 -0500
Date: Wed, 6 Feb 2008 11:04:25 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] Fix timerfd breakage on avr32
Message-ID: <20080206110425.GB25012@flint.arm.linux.org.uk>
References: <200802050627.m156R9G9006417@imap1.linux-foundation.org> <20080205105454.2c0f8133@dhcp-252-066.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080205105454.2c0f8133@dhcp-252-066.norway.atmel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: torvalds@linux-foundation.org, davidel@xmailserver.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org, mtk-manpages@gmx.net, tglx@linutronix.de

On Tue, Feb 05, 2008 at 10:54:54AM +0100, Haavard Skinnemoen wrote:
> sys_timerfd() has been removed, but avr32 still references it from its
> syscall table.
> 
> Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
> ---
> On Mon, 04 Feb 2008 22:27:28 -0800
> akpm@linux-foundation.org wrote:
> 
> > From: Davide Libenzi <davidel@xmailserver.org>
> > 
> > Wires up the new timerfd API to the x86 family.
> 
> Just one thing...
> 
> > diff -puN arch/x86/kernel/syscall_table_32.S~timerfd-v3-wire-the-new-timerfd-api-to-the-x86-family arch/x86/kernel/syscall_table_32.S
> > --- a/arch/x86/kernel/syscall_table_32.S~timerfd-v3-wire-the-new-timerfd-api-to-the-x86-family
> > +++ a/arch/x86/kernel/syscall_table_32.S
> > @@ -321,6 +321,8 @@ ENTRY(sys_call_table)
> >  	.long sys_epoll_pwait
> >  	.long sys_utimensat		/* 320 */
> >  	.long sys_signalfd
> > -	.long sys_timerfd
> 
> The next time you go and remove a system call, could you _please_ post
> a HUGE warning to linux-arch? Or just do a quick grep and fix it up.

Wasn't there a decision at a kernel summit that anything which adds
new syscalls should have a test program included so that architecture
maintainers can test the functionality on their architectures?

I seem to remember that it came up because the merged timerfd was a
pile of utter crap which didn't have a hope in hells chance of working.

So... where is the new timerfd test program?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
