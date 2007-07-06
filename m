Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:49356 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757827AbXGFVzg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Jul 2007 17:55:36 -0400
Date: Fri, 6 Jul 2007 22:54:44 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: + print-utsname-on-oops-on-all-architectures.patch added to -mm tree
Message-ID: <20070706215444.GA1991@flint.arm.linux.org.uk>
References: <200707061754.l66HsXfb010994@imap1.linux-foundation.org> <20070706182612.GA26179@flint.arm.linux.org.uk> <Pine.LNX.4.64.0707061233450.617@internets.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707061233450.617@internets.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
To: Joshua Wise <jwise@google.com>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org, ak@suse.de, benh@kernel.crashing.org, ink@jurassic.park.msu.ru, linux-arch@vger.kernel.org, paulus@samba.org, rth@twiddle.net
List-ID: <linux-arch.vger.kernel.org>

On Fri, Jul 06, 2007 at 02:03:45PM -0700, Joshua Wise wrote:
> On Fri, 6 Jul 2007, Russell King wrote:
> > On Fri, Jul 06, 2007 at 10:54:33AM -0700, akpm@linux-foundation.org wrote:
> > > Potential impact:
> > >  This adds another line to the Oops output, causing the first few lines to
> > >  potentially scroll off the screen. This also adds a few more pointer
> > >  dereferences in the Oops path, because it adds to the die_chain notifier
> > >  chain, reducing the likelihood that the Oops will be printed if there is
> > >  very bad memory corruption.
> > 
> > Plus we don't get the utsname information on oops dumps during the kernel
> > initialisation.  Not good - I'd rather keep things as is rather than loose
> > that facility which we've just gained on ARM.
> 
> Ok -- would it be more agreeable to make that a core_initcall?

That just makes the reporting slightly earlier and doesn't solve the
real problem.

> > Instead, can we have this as a call-able function which returns the
> > pointer, or just make the pointer global.  That way we can also eliminate
> > the need for another additional line in the oops output.
> 
> Hm. I don't really like the precedent being set for sucking arbitrary
> globals into the Oops message.

It's much safer than walking notifier lists and such like.

> In particular, I am also considering a patch to print machine check
> statistics (if we took any machine check exceptions) at Oops-time, and I
> would implement that in a similar manner to this.

I'm also going to raise an additional objection - whoever introduced
notify_die() hasn't bothered fixing up the ARM implementation, so your
patch actually _removes_ functionality recently introduced.

In addition, I notice that the introduction of notify_die() didn't take
account of what other architectures do (eg passing siginfo structures),
so to convert ARM to using it would either require us to drop some 
functionality or re-engineer notify_die().

Therefore, I'm going to ask you to remove the changes from your patch
which touch the ARM architecture since the overall effect is a net
removal of functionality I've only recently merged.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
