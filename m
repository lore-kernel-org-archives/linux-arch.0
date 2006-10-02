Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:37345 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965445AbWJBVzn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Oct 2006 17:55:43 -0400
Date: Mon, 2 Oct 2006 23:47:32 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
Message-ID: <20061002214732.GA11451@elte.hu>
References: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002140121.f588b463.akpm@osdl.org> <Pine.LNX.4.64.0610021412200.3952@g5.osdl.org> <200610022319.59029.ak@suse.de> <Pine.LNX.4.64.0610021445570.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610021445570.3952@g5.osdl.org>
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>, Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>, Alan Stern <stern@rowland.harvard.edu>
List-ID: <linux-arch.vger.kernel.org>


* Linus Torvalds <torvalds@osdl.org> wrote:

> On Mon, 2 Oct 2006, Andi Kleen wrote:
> > 
> > How would you test something like this? It would touch all 
> > architectures and nearly all drivers too.
> 
> "If it compiles, it works".
> 
> Pretty close.

Note that the IRQ threading code in the -rt tree already passes NULL as 
the pt_regs argument to /all/ drivers [except the timer interrupt]. So 
there's more than just the compilation evidence ;-)

	Ingo
