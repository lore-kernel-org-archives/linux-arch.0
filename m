Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pip9.gyao.ne.jp ([61.122.117.247]:35791 "EHLO mx.gate01.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754695AbYBEK2A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 Feb 2008 05:28:00 -0500
Date: Tue, 5 Feb 2008 19:26:44 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] Fix timerfd breakage on avr32
Message-ID: <20080205102644.GA5038@linux-sh.org>
References: <200802050627.m156R9G9006417@imap1.linux-foundation.org> <20080205105454.2c0f8133@dhcp-252-066.norway.atmel.com> <20080205110347.62cf2925@dhcp-252-066.norway.atmel.com> <20080205021347.4785ca44.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080205021347.4785ca44.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>, torvalds@linux-foundation.org, davidel@xmailserver.org, David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, mtk-manpages@gmx.net, tglx@linutronix.de, Hirokazu Takata <takata@linux-m32r.org>

On Tue, Feb 05, 2008 at 02:13:47AM -0800, Andrew Morton wrote:
> On Tue, 5 Feb 2008 11:03:47 +0100 Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:
> 
> > On Tue, 5 Feb 2008 10:54:54 +0100
> > Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:
> > 
> > > The next time you go and remove a system call, could you _please_ post
> > > a HUGE warning to linux-arch? Or just do a quick grep and fix it up.
> > 
> > Btw, a quick grep through 2.6.24-mm1 shows
> > 
> > arch/frv/kernel/entry.S:	.long sys_timerfd
> > arch/m32r/kernel/syscall_table.S:	.long sys_timerfd
> > arch/sh/kernel/syscalls_32.S:	.long sys_timerfd
> > arch/sh/kernel/syscalls_64.S:	.long sys_timerfd		/* 350 */
> > 
> > so frv, m32r and sh are probably broken too.
> > 
> 
> argh. After fixing so many architectures I asked for a grepped
> fix :(
> 
> 
> This?
> 
At least if this patch goes in first then bisect won't needlessly break,
though the previous patch has already gone to Linus, so maybe it's too
late already. Once this patch and the previous one are in, then the new
interface can be wired up -- preferably in that order.
