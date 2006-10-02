Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:6259 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965093AbWJBUqR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Oct 2006 16:46:17 -0400
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
Date: Mon, 2 Oct 2006 13:46:11 -0700
References: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> <20061002132116.2663d7a3.akpm@osdl.org>
In-Reply-To: <20061002132116.2663d7a3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610021346.13135.david-b@pacbell.net>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>, Greg KH <greg@kroah.com>, Alan Stern <stern@rowland.harvard.edu>
List-ID: <linux-arch.vger.kernel.org>

The only downside I can think of for dropping pt_regs is that now it's harder
to just find the IRQ handler in a driver ... it's previously been all but
guaranteed that the _only_ use of that type is the IRQ logic.  The upsides
surely outweigh that.

> >  (*) finish_unlinks() in drivers/usb/host/ohci-q.c needs checking.  It does
> >      something different depending on whether it's been supplied with a regs
> >      pointer or not.

gaak!  where did that come from?  I'll be surprised if removing
that causes any problem at all.

- Dave

