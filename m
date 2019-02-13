Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57678 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732218AbfBMRUy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Feb 2019 12:20:54 -0500
Date: Wed, 13 Feb 2019 17:20:47 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
Message-ID: <20190213172047.GH6346@brain-police>
References: <20190211172948.3322-1-will.deacon@arm.com>
 <CAHk-=wiP42aqBApAUJbLAB43u5ips9ArgLxXn5L1r74bowxdow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiP42aqBApAUJbLAB43u5ips9ArgLxXn5L1r74bowxdow@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, tony.luck@intel.com
Message-ID: <20190213172047.O8P5aJ0lB_pK12cGq6LG_kTUKP4CR9fZF3EHODlNYRw@z>

[+Tony]

On Mon, Feb 11, 2019 at 02:34:31PM -0800, Linus Torvalds wrote:
> On Mon, Feb 11, 2019 at 9:30 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > +
> > +     1. All readX() and writeX() accesses to the same peripheral are ordered
> > +        with respect to each other. For example, this ensures that MMIO register
> > +       writes by the CPU to a particular device will arrive in program order.
> 
> Hmm. I'd like more people look at strengthening this one wrt across
> CPUs and locking.
> 
> Right now we document mmiowb(), but that "documentation" is really
> just a fairy tale. Very *very* few drivers actually do mmiowb() on
> their own.
> 
> IOW, we should seriously just consider making the rule be that locking
> will order mmio too. Because that's practically the rule anyway.

I would /love/ to get rid of mmiowb() because I think it's both extremely
difficult to use and also pretty much never needed. It reminds me a lot of
smp_read_barrier_depends(), which we finally pushed into READ_ONCE for
Alpha.

> Powerpc already does it. IO within a locked region will serialize with the
> lock.

I thought ia64 was the hold out here? Did they actually have machines that
needed this in practice? If so, I think we can either:

  (a) Add an mmiowb() to their spin_unlock() code, or
  (b) Remove ia64 altogether if nobody complains

I know that Peter has been in favour of (b) for a while...

Will
