Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:35072 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfAGJrQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jan 2019 04:47:16 -0500
Date: Mon, 7 Jan 2019 10:46:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC 3/4] barriers: convert a control to a data dependency
Message-ID: <20190107094610.GA2861@worktop.programming.kicks-ass.net>
References: <20190102205715.14054-1-mst@redhat.com>
 <20190102205715.14054-4-mst@redhat.com>
 <86023cbe-d1ae-a0d6-7b75-26556f1a0c1f@redhat.com>
 <20190106231756-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190106231756-mutt-send-email-mst@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <andrea.parri@amarulasolutions.com>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Jonathan Corbet <corbet@lwn.net>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, linux-sparse@vger.kernel.org
Message-ID: <20190107094610.OluiTJbG8ZRtwOdt8FviM9aJvjOjItD7g_kG44A5HU8@z>

On Sun, Jan 06, 2019 at 11:23:07PM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 07, 2019 at 11:58:23AM +0800, Jason Wang wrote:
> > On 2019/1/3 上午4:57, Michael S. Tsirkin wrote:

> > > +#if defined(COMPILER_HAS_OPTIMIZER_HIDE_VAR) && \
> > > +	!defined(ARCH_NEEDS_READ_BARRIER_DEPENDS)
> > > +
> > > +#define dependent_ptr_mb(ptr, val) ({					\
> > > +	long dependent_ptr_mb_val = (long)(val);			\
> > > +	long dependent_ptr_mb_ptr = (long)(ptr) - dependent_ptr_mb_val;	\
> > > +									\
> > > +	BUILD_BUG_ON(sizeof(val) > sizeof(long));			\
> > > +	OPTIMIZER_HIDE_VAR(dependent_ptr_mb_val);			\
> > > +	(typeof(ptr))(dependent_ptr_mb_ptr + dependent_ptr_mb_val);	\
> > > +})
> > > +
> > > +#else
> > > +
> > > +#define dependent_ptr_mb(ptr, val) ({ mb(); (ptr); })
> > 
> > 
> > So for the example of patch 4, we'd better fall back to rmb() or need a
> > dependent_ptr_rmb()?
> > 
> > Thanks
> 
> You mean for strongly ordered architectures like Intel?
> Yes, maybe it makes sense to have dependent_ptr_smp_rmb,
> dependent_ptr_dma_rmb and dependent_ptr_virt_rmb.
> 
> mb variant is unused right now so I'll remove it.

How about naming the thing: dependent_ptr() ? That is without any (r)mb
implications at all. The address dependency is strictly weaker than an
rmb in that it will only order the two loads in qestion and not, like
rmb, any prior to any later load.
