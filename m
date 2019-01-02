From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 0/4] barriers using data dependency
Date: Wed, 2 Jan 2019 18:04:31 -0500
Message-ID: <20190102175247-mutt-send-email-mst@kernel.org>
References: <20190102205715.14054-1-mst@redhat.com>
	<Pine.LNX.4.44L0.1901021629150.1375-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1901021629150.1375-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, linux-arch@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Daniel Lustig <dlustig@nvidia.com>, Akira Yokosawa <akiyks@gmail.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, virtualization@lists.linux-foundation.org, David Howells <dhowells@redhat.com>, netdev@vger.kernel.org, Luc Maranget <luc.maranget@inria.fr>, Jade Alglave <j.alglave@ucl.ac.uk>, Boqun Feng <boqun.feng@gmail.com>
List-Id: linux-arch.vger.kernel.org

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
