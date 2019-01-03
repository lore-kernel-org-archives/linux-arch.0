From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH RFC 0/4] barriers using data dependency
Date: Thu, 3 Jan 2019 10:11:34 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1901031007290.1460-100000@iolanthe.rowland.org>
References: <20190102175247-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190102175247-mutt-send-email-mst@kernel.org>
Sender: netdev-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org

On Wed, 2 Jan 2019, Michael S. Tsirkin wrote:

> On Wed, Jan 02, 2019 at 04:36:40PM -0500, Alan Stern wrote:
> > On Wed, 2 Jan 2019, Michael S. Tsirkin wrote:
> > 
> > > So as explained in Documentation/memory-barriers.txt e.g.
> > > a load followed by a store require a full memory barrier,
> > > to avoid store being ordered before the load.
> > > Similarly load-load requires a read memory barrier.
> > > 
> > > Thinking about it, we can actually create a data dependency
> > > by mixing the first loaded value into the pointer being
> > > accessed.
> > > 
> > > This adds an API for this and uses it in virtio.
> > > 
> > > Written over the holiday and build tested only so far.
> > 
> > You are using the terminology from memory-barriers.txt, referring to
> > the new dependency you create as a data dependency.  However,
> > tools/memory-model/* uses a more precise name, calling it an address
> > dependency.  Could you change the comments in the patches to use this
> > name instead?
> 
> Sure, sounds good. While I'm at it, should memory-barriers.txt be
> switched over too?

If you want to take care of that, great!  I never seem to get around to 
doing it.

> > > This patchset is also suboptimal on e.g. x86 where e.g. smp_rmb is a nop.
> > 
> > This should be easy to fix with an architecture-specific override.
> > 
> > Alan Stern
> 
> Absolutely. It does however mean that we'll need several
> variants: mb/rmb, smp/dma/virt/mandatory.
> 
> I am still trying to decide whether it's good since it documents the
> kind of barrier that we are trying to use - or bad since it's more
> verbose and makes you choose one where they are all pretty cheap.

How many places can these things be used?  My guess is not very many,
or at least, there aren't very many different _types_ of usage.  So
start only with variants you know will be used.  More can be added
later if we want.

Alan Stern
