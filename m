Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from x35.xmailserver.org ([64.71.152.41]:1350 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161092AbXBTXdx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 20 Feb 2007 18:33:53 -0500
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.25 ESMTP Server]
	id <S216C04> for <linux-arch@vger.kernel.org> from <davidel@xmailserver.org>;
	Tue, 20 Feb 2007 18:33:51 -0500
Date: Tue, 20 Feb 2007 15:33:50 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [patch 18/50] add epoll compat code to kernel/compat.c
In-Reply-To: <20070221102027.52bf703a.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0702201530250.2498@alien.or.mcafeemobile.com>
References: <200702202159.l1KLxMcC021074@shell0.pdx.osdl.net>
 <20070221102027.52bf703a.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, tony.luck@intel.com
List-ID: <linux-arch.vger.kernel.org>

On Wed, 21 Feb 2007, Stephen Rothwell wrote:

> On Tue, 20 Feb 2007 13:57:58 -0800 akpm@linux-foundation.org wrote:
> >
> > From: Davide Libenzi <davidel@xmailserver.org>
> >
> > Add epoll compat_ code to kernel/compat.c.  IA64 and ARM-OABI are currently
> > using their own version of epoll compat_ code and they could probably wire to
> > the new common code.
> 
> So did you just ignore the discussion that went on about this patch and
> the suggestions made (by me) and accepted by the author?  i.e. why has
> this gone to Linus in this form?

Reminder for Andrew ...
We talked about having an asm/compat.h define the proper 
compat_epoll_event structure, and having a define in there that triggers 
the proper code inside kernel/compat.c. It looks like the better way to 
go, as Stephen suggested.
If that's accepted by everyone, I can go ahead and make a patch. Lemme 
know ...



- Davide


