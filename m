Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38550 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935110AbXGQVnQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Jul 2007 17:43:16 -0400
Date: Tue, 17 Jul 2007 14:42:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: + sparc64-rename-tlb_flush_mmu.patch added to -mm tree
Message-Id: <20070717144245.7760a716.akpm@linux-foundation.org>
In-Reply-To: <20070717211445.GC16147@flint.arm.linux.org.uk>
References: <200707170748.l6H7m1so005969@imap1.linux-foundation.org>
	<20070717005551.cdb9504e.akpm@linux-foundation.org>
	<20070717010324.833fee7e.akpm@linux-foundation.org>
	<1184680583.21357.67.camel@localhost>
	<20070717181843.GB16147@flint.arm.linux.org.uk>
	<20070717120820.86a50e75.akpm@linux-foundation.org>
	<20070717211445.GC16147@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-arch@vger.kernel.org, davem@davemloft.net, hugh@veritas.com
List-ID: <linux-arch.vger.kernel.org>

On Tue, 17 Jul 2007 22:14:45 +0100
Russell King <rmk@arm.linux.org.uk> wrote:

> On Tue, Jul 17, 2007 at 12:08:20PM -0700, Andrew Morton wrote:
> > On Tue, 17 Jul 2007 19:18:43 +0100 Russell King <rmk@arm.linux.org.uk> wrote:
> > 
> > > On Tue, Jul 17, 2007 at 03:56:23PM +0200, Martin Schwidefsky wrote:
> > > > On Tue, 2007-07-17 at 01:03 -0700, Andrew Morton wrote:
> > > > > OK, I don't understand how this patch works - from a quick glance it
> > > > > appears to be forgetting to flush stuff altogether on arm and arm26 at
> > > > > least and I see no sign that Russell, Tony and Ian have even seen it.
> > > > 
> > > > Added linux-arch so that affected arch-maintainers can comment.
> > > 
> > > Having a little more information about Andrew's concern would be nice.
> > > Under what circumstances do you think we're forgetting to flush stuff?
> > > 
> > 
> > "quick glance".  ARM's tlb_flush_mmu() becomes a no-op and I though that
> > some real tlb_finish_mmu() got replaced by that.  But I didn't look very
> > closely.
> 
> I don't think ARM will have a problem with this change.
> 
> In the fullmm case, tlb_finish_mmu() will flush the entire mm, so
> missing out the flush for each chunk is itself a worthwhile optimisation.
> 
> In the !fullmm case, tlb_finish_mmu() does nothing as far as flushing
> is concerned, and in any case does nothing with it's start and end
> variables.
> 
> So I think this patch suits us just fine.

umm, OK, well what is the spec for this new interface which Martin
is proposing to add?

It _seems_ to be that if the arch implements tlb_flush_mmu() then its
tlb_finish_mmu() can (should) be a no-op?

Or if the arch's tlb_finish_mmu() does a full mm "flush" (god I hate that
term - here we meant writeback, and perhaps invalidate??)) then its
tlb_flush_mmu() can (should) be a no-op.

Or something like that.  Martin, I'd suggest that an update to
Documentation/cachetlb.txt is in order, spell this all out.

Doing this properly would require that Documentation/cachetlb.txt say
something about tlb_gather_mmu() and tlb_finish_mmu() too, I guess.
Please ;)


