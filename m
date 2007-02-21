Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:59261 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbXBUBqc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 20 Feb 2007 20:46:32 -0500
Received: from localhost.localdomain ([127.0.0.1]:24788 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039019AbXBUBjG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 21 Feb 2007 01:39:06 +0000
Date: Wed, 21 Feb 2007 01:38:33 +0000
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [patch 18/50] add epoll compat code to kernel/compat.c
Message-ID: <20070221013833.GA18968@linux-mips.org>
References: <200702202159.l1KLxMcC021074@shell0.pdx.osdl.net> <20070221102027.52bf703a.sfr@canb.auug.org.au> <Pine.LNX.4.64.0702201530250.2498@alien.or.mcafeemobile.com> <20070221120145.419a03ee.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070221120145.419a03ee.sfr@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Davide Libenzi <davidel@xmailserver.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, tony.luck@intel.com
List-ID: <linux-arch.vger.kernel.org>

On Wed, Feb 21, 2007 at 12:01:45PM +1100, Stephen Rothwell wrote:

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

I suggest to remove the MIPS implementation from arch/mips/kernel/linux32.c
instead.  Aside of a microoptimization it's identical to the one you've
posted.

  Ralf
