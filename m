Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:56652 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfAGPym (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jan 2019 10:54:42 -0500
Date: Mon, 7 Jan 2019 16:54:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC 3/4] barriers: convert a control to a data dependency
Message-ID: <20190107155423.GM2218@hirez.programming.kicks-ass.net>
References: <20190102205715.14054-1-mst@redhat.com>
 <20190102205715.14054-4-mst@redhat.com>
 <86023cbe-d1ae-a0d6-7b75-26556f1a0c1f@redhat.com>
 <20190106231756-mutt-send-email-mst@kernel.org>
 <20190107094610.GA2861@worktop.programming.kicks-ass.net>
 <20190107082223-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107082223-mutt-send-email-mst@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <andrea.parri@amarulasolutions.com>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Jonathan Corbet <corbet@lwn.net>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, linux-sparse@vger.kernel.org
Message-ID: <20190107155423.MXW-9zTTqH3nCYD6jxz8W0LC-q8vdfv5gLg3_nfpx6E@z>

On Mon, Jan 07, 2019 at 08:36:36AM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 07, 2019 at 10:46:10AM +0100, Peter Zijlstra wrote:

> > How about naming the thing: dependent_ptr() ? That is without any (r)mb
> > implications at all. The address dependency is strictly weaker than an
> > rmb in that it will only order the two loads in qestion and not, like
> > rmb, any prior to any later load.
> 
> So I'm fine with this as it's enough for virtio, but I would like to point out two things:
> 
> 1. E.g. on x86 both SMP and DMA variants can be NOPs but
> the madatory one can't, so assuming we do not want
> it to be stronger than rmp then either we want
> smp_dependent_ptr(), dma_dependent_ptr(), dependent_ptr()
> or we just will specify that dependent_ptr() works for
> both DMA and SMP.

The latter; the construct simply generates dependent loads. It is up to
the CPU as to what all that works for.

> 2. Down the road, someone might want to order a store after a load.
> Address dependency does that for us too. Assuming we make
> dependent_ptr a NOP on x86, we will want an mb variant
> which isn't a NOP on x86. Will we want to rename
> dependent_ptr to dependent_ptr_rmb at that point?

Not sure; what is the actual overhead of the construct on x86 vs the
NOP?
