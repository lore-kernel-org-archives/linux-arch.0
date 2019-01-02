Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfABXEi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Jan 2019 18:04:38 -0500
Date: Wed, 2 Jan 2019 18:04:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 0/4] barriers using data dependency
Message-ID: <20190102175247-mutt-send-email-mst@kernel.org>
References: <20190102205715.14054-1-mst@redhat.com>
 <Pine.LNX.4.44L0.1901021629150.1375-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1901021629150.1375-100000@iolanthe.rowland.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
Message-ID: <20190102230431.99sXYjWctw_U1rzZus9KVFjBvf7xN33O98rDg7wPmM8@z>

On Wed, Jan 02, 2019 at 04:36:40PM -0500, Alan Stern wrote:
> On Wed, 2 Jan 2019, Michael S. Tsirkin wrote:
> 
> > So as explained in Documentation/memory-barriers.txt e.g.
> > a load followed by a store require a full memory barrier,
> > to avoid store being ordered before the load.
> > Similarly load-load requires a read memory barrier.
> > 
> > Thinking about it, we can actually create a data dependency
> > by mixing the first loaded value into the pointer being
> > accessed.
> > 
> > This adds an API for this and uses it in virtio.
> > 
> > Written over the holiday and build tested only so far.
> 
> You are using the terminology from memory-barriers.txt, referring to
> the new dependency you create as a data dependency.  However,
> tools/memory-model/* uses a more precise name, calling it an address
> dependency.  Could you change the comments in the patches to use this
> name instead?

Sure, sounds good. While I'm at it, should memory-barriers.txt be
switched over too?

> > This patchset is also suboptimal on e.g. x86 where e.g. smp_rmb is a nop.
> 
> This should be easy to fix with an architecture-specific override.
> 
> Alan Stern

Absolutely. It does however mean that we'll need several
variants: mb/rmb, smp/dma/virt/mandatory.

I am still trying to decide whether it's good since it documents the
kind of barrier that we are trying to use - or bad since it's more
verbose and makes you choose one where they are all pretty cheap.

> > Sending out for early feedback/flames.
> > 
> > Michael S. Tsirkin (4):
> >   include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR
> >   include/linux/compiler.h: allow memory operands
> >   barriers: convert a control to a data dependency
> >   virtio: use dependent_ptr_mb
> > 
> >  Documentation/memory-barriers.txt | 20 ++++++++++++++++++++
> >  arch/alpha/include/asm/barrier.h  |  1 +
> >  drivers/virtio/virtio_ring.c      |  6 ++++--
> >  include/asm-generic/barrier.h     | 18 ++++++++++++++++++
> >  include/linux/compiler-clang.h    |  5 ++---
> >  include/linux/compiler-gcc.h      |  4 ----
> >  include/linux/compiler-intel.h    |  4 +---
> >  include/linux/compiler.h          |  8 +++++++-
> >  8 files changed, 53 insertions(+), 13 deletions(-)
