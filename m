Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from x35.xmailserver.org ([64.71.152.41]:1383 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313AbXBUBMR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 20 Feb 2007 20:12:17 -0500
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.25 ESMTP Server]
	id <S216C2F> for <linux-arch@vger.kernel.org> from <davidel@xmailserver.org>;
	Tue, 20 Feb 2007 20:12:15 -0500
Date: Tue, 20 Feb 2007 17:12:14 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [patch 18/50] add epoll compat code to kernel/compat.c
In-Reply-To: <20070221120145.419a03ee.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0702201708230.2498@alien.or.mcafeemobile.com>
References: <200702202159.l1KLxMcC021074@shell0.pdx.osdl.net>
 <20070221102027.52bf703a.sfr@canb.auug.org.au>
 <Pine.LNX.4.64.0702201530250.2498@alien.or.mcafeemobile.com>
 <20070221120145.419a03ee.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, tony.luck@intel.com, ralf@linux-mips.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 21 Feb 2007, Stephen Rothwell wrote:

> Hi Davide,
> 
> > Reminder for Andrew ...
> > We talked about having an asm/compat.h define the proper 
> > compat_epoll_event structure, and having a define in there that triggers 
> > the proper code inside kernel/compat.c. It looks like the better way to 
> > go, as Stephen suggested.
> > If that's accepted by everyone, I can go ahead and make a patch. Lemme 
> > know ...
> 
> Like below?  I did the above and moved the code to fs/compat.c (from
> kernel/compat.c).  Also MIPS already has a compat_sys_epoll_pwait, so I
> had to add an #ifndef CONFIG_MIPS.

I was thinking something different. Example:

[include/asm-XXX/compat.h]

	struct compat_epoll_event {
		...
	} ATTR ...;
	#define NEED_EPOLL_EVENT_COMPAT 1


[kernel/compat.c]

	#ifdef CONFIG_EPOLL

	#ifdef NEED_EPOLL_EVENT_COMPAT
	....
	#endif

	#endif


That way we don't have arch-specific (MIPS, IA64, ...) ifdefs inside 
common code.




- Davide


