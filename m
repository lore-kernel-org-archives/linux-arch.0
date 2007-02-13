Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from x35.xmailserver.org ([64.71.152.41]:2687 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161109AbXBMHe7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 Feb 2007 02:34:59 -0500
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.25 ESMTP Server]
	id <S214FC4> for <linux-arch@vger.kernel.org> from <davidel@xmailserver.org>;
	Tue, 13 Feb 2007 02:26:42 -0500
Date: Mon, 12 Feb 2007 23:26:42 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [patch] (2nd try)  add epoll compat code to kernel/compat.c ...
In-Reply-To: <20070213153525.c1440cff.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0702122321570.30273@alien.or.mcafeemobile.com>
References: <Pine.LNX.4.64.0702111615340.24568@alien.or.mcafeemobile.com>
 <20070213153525.c1440cff.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 13 Feb 2007, Stephen Rothwell wrote:

> A better way here might be to have each 64 bit architecture define
> compat_epoll_event in its asm/compat.h and then you can just use:
> 
> 	if (copy_from_user(&user, event, sizeof(user)))
> 		return -EFAULT;
> 	kernel = compat_alloc_user_space(sizeof(struct epoll_event));
> 	err |= __put_user(user.events, &kernel->events);
> 	err |= __put_user(user.data, &kernel->data);
> 
> And you shouldn't need the compat routine if
> offsetof(struct compat_epoll_event, data) == offsetof(struct epoll_event, data).

That is *definitely* better, because at that point you can make them also
define a NEED_COMPAT_EPOLL_{CTL,WAIT}, and that code can be excluded 
altogether if not needed. I simply wanted to reduce work for arch 
maintainers, but I'm all for something like the above.



> OK, I have thought about this some more and I *think* the only
> architecture that needs compat_sys_epoll_ctl or compat_sys_epoll_wait is
> ia64 where the 64 bit version of struct epoll_event is different from the
> 32 bit version.  On x86_64, the struct is explictly packed (so it is the
> same as the 32 bit version) and on all the other 64 bit architectures the
> alignment of the u64 is the same as the equivalent 32 bit version.
> 
> Since ia64 already has its own version of these two, we only have to
> worry about epoll_pwait and then the struct epoll_event is only a problem
> for ia64.
> 
> Am I right?  (I have cc'd linux-arch for guidance.)

ARM-OABI also defines them, dunno why. Rmk?



- Davide


