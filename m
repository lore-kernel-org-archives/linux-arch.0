Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:36705 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759907AbXGFVEu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Jul 2007 17:04:50 -0400
Date: Fri, 6 Jul 2007 14:03:45 -0700 (PDT)
From: Joshua Wise <jwise@google.com>
Subject: Re: + print-utsname-on-oops-on-all-architectures.patch added to -mm
 tree
In-Reply-To: <20070706182612.GA26179@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0707061233450.617@internets.corp.google.com>
References: <200707061754.l66HsXfb010994@imap1.linux-foundation.org>
 <20070706182612.GA26179@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org, ak@suse.de, benh@kernel.crashing.org, ink@jurassic.park.msu.ru, linux-arch@vger.kernel.org, paulus@samba.org, rth@twiddle.net
List-ID: <linux-arch.vger.kernel.org>

On Fri, 6 Jul 2007, Russell King wrote:
> On Fri, Jul 06, 2007 at 10:54:33AM -0700, akpm@linux-foundation.org wrote:
> > Potential impact:
> >  This adds another line to the Oops output, causing the first few lines to
> >  potentially scroll off the screen. This also adds a few more pointer
> >  dereferences in the Oops path, because it adds to the die_chain notifier
> >  chain, reducing the likelihood that the Oops will be printed if there is
> >  very bad memory corruption.
> 
> Plus we don't get the utsname information on oops dumps during the kernel
> initialisation.  Not good - I'd rather keep things as is rather than loose
> that facility which we've just gained on ARM.

Ok -- would it be more agreeable to make that a core_initcall?

> Instead, can we have this as a call-able function which returns the
> pointer, or just make the pointer global.  That way we can also eliminate
> the need for another additional line in the oops output.

Hm. I don't really like the precedent being set for sucking arbitrary
globals into the Oops message. It's not particularly extensible, and the
additional line at the top doesn't seem like it will kill anyone...

In particular, I am also considering a patch to print machine check
statistics (if we took any machine check exceptions) at Oops-time, and I
would implement that in a similar manner to this.

joshua
