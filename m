Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:17077 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965499AbWJBXA2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Oct 2006 19:00:28 -0400
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
Date: Mon, 2 Oct 2006 16:00:22 -0700
References: <Pine.LNX.4.44L0.0610021729490.8219-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0610021729490.8219-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610021600.24477.david-b@pacbell.net>
Sender: linux-arch-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>, Greg KH <greg@kroah.com>
List-ID: <linux-arch.vger.kernel.org>

On Monday 02 October 2006 2:34 pm, Alan Stern wrote:
> On Mon, 2 Oct 2006, David Brownell wrote:
> 
> > > >  (*) finish_unlinks() in drivers/usb/host/ohci-q.c needs checking.  It does
> > > >      something different depending on whether it's been supplied with a regs
> > > >      pointer or not.
> > 
> > gaak!  where did that come from?  I'll be surprised if removing
> > that causes any problem at all.
> 
> Here's the statement in question:
> 
> 	if (likely (regs && HC_IS_RUNNING(ohci_to_hcd(ohci)->state))) {

Where as I said, removing the "regs &&" should be just fine.
(Is the plan that David Howells re-issue that patch?  If so, I'l
expect e will just fix it that way...)

> 		...
> 
> Notice another questionable use of hcd->state. 

Questionable in what way?  When that code is called to clean up
after driver death, that loop must be ignored ... every pending I/O
can safely be scrubbed.  That's the main point of that particular
HC_IS_RUNNING() test.  In other cases, it's essential not to touch
DMA queue entries that the host controller is still using.

- Dave

