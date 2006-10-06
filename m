Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:20450 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750803AbWJFLeZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Oct 2006 07:34:25 -0400
Date: Fri, 6 Oct 2006 13:25:50 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than	passing to IRQ handlers
Message-ID: <20061006112550.GA21733@elte.hu>
References: <20061002132116.2663d7a3.akpm@osdl.org> <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> <18975.1160058127@warthog.cambridge.redhat.com> <4525A8D8.9050504@garzik.org> <1160133932.1607.68.camel@localhost.localdomain> <45263ABC.4050604@garzik.org> <20061006111156.GA19678@elte.hu> <45263D9C.9030200@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45263D9C.9030200@garzik.org>
Sender: linux-arch-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>, torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>, Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>, Alan Stern <stern@rowland.harvard.edu>
List-ID: <linux-arch.vger.kernel.org>


* Jeff Garzik <jeff@garzik.org> wrote:

> >but pt_regs is alot less frequently used than irq - and where it's 
> >used they arent "drivers" but mostly arch level code like hw-timer 
> >handlers.
> 
> Nonetheless the -vast majority- of drivers don't use the argument at 
> all, and the minority that do use it are not modern drivers.

i'm all for changing that too :)

	Ingo
