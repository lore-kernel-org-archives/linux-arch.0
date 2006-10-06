Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:14605 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1161062AbWJFQmh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 6 Oct 2006 12:42:37 -0400
Date: Fri, 6 Oct 2006 17:42:11 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
Message-ID: <20061006164211.GA15321@flint.arm.linux.org.uk>
References: <20061002132116.2663d7a3.akpm@osdl.org> <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> <18975.1160058127@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0610051632250.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610051632250.3952@g5.osdl.org>
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>, Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>, Alan Stern <stern@rowland.harvard.edu>
List-ID: <linux-arch.vger.kernel.org>

On Thu, Oct 05, 2006 at 04:35:02PM -0700, Linus Torvalds wrote:
> On Thu, 5 Oct 2006, David Howells wrote:
> > Anyway, I've made a GIT tree with just IRQ my patches in.  It can be browsed
> > at:
> > 
> > 	http://git.infradead.org/?p=users/dhowells/irq-2.6.git;a=shortlog
> > 
> > Or pulled from:
> > 
> > 	git://git.infradead.org/~dhowells/irq-2.6.git
> 
> Gaah. It has those ugly "cherry-picked from" messages (please use "-r" 
> when cherry-picking, or "-e" and edit them out), but it looks fine 
> otherwise, and I think I heard a _very_ convincing "please do it" from 
> everybody involved when this was discussed, so I've pulled. 
> 
> Any fall-out from this should be both obvious and pretty trivial to fix 
> up.

Someone needs to fix ARM - I'm told it's utterly broken at the moment.
Since I'm on holiday (and the machine with the git trees on is powered
off and there's no way I can power it on) it's someone elses job. 8)
I'm not likely to be in a position to fix this before next Wednesday in
any case.

If it's obvious and trivial, it should be easy for anyone to fix, even
the person who broke it.  Especially as there are build logs automatically
generated for every -git tree at http://armlinux.simtec.co.uk/kautobuild/

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
