From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 04/41] cpu ops: Core piece for generic atomic per cpu operations
Date: Sun, 15 Jun 2008 20:33:02 +1000
Message-ID: <200806152033.02891.rusty@rustcorp.com.au>
References: <20080530035620.587204923@sgi.com> <200806131038.12987.rusty@rustcorp.com.au> <Pine.LNX.4.64.0806121921260.4570@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757532AbYFOKd3@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0806121921260.4570@schroedinger.engr.sgi.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Martin Peschke <mp3@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Mike Travis <travis@sgi.com>
List-Id: linux-arch.vger.kernel.org

On Friday 13 June 2008 12:27:07 Christoph Lameter wrote:
> On Fri, 13 Jun 2008, Rusty Russell wrote:
> > cpu_possible_map should definitely be minimal, but your point is well
> > made: dynamic percpu could actually cut memory allocation.  If we go for
> > a hybrid scheme where static percpu is always allocated from the initial
> > chunk, however, we still need the current pessimistic overallocation.
>
> The initial chunk would mean that the percpu areas all come from the same
> NUMA node. We really need to allocate from the node that is nearest to a
> processor (not all processors have processor local memory!).

Yes, this is where it gets nasty.  We shouldn't even allocate the initial 
chunk in a non-NUMA aware way (I'm using the term chunk loosely, it's a chunk 
per cpu of course).

> It would be good to standardize the way that percpu areas are allocated.
> We have various ways of allocation now in various arches.
> init/main.c:setup_per_cpu_ares() needs to be generalized:
>
> 1. Allocate the per cpu areas in a NUMA aware fashions.

Definitely.  We also need to reserve virtual address space to create more 
areas with congruent mappings; that's the fun part.

Maybe a simpler non-NUMA variant too, but it's trivial if we want it.

> 2. Have a function for instantiating a single per cpu area that
>    can be used during cpu hotplug.

Unfortunately this breaks the current percpu semantics: that if you iterate 
over all possible cpus you can access percpu vars.  This means you don't need 
to have hotplug CPU notifiers for simple percpu counters.  We could do this 
with helpers, but AFAICT it's orthogonal to the other plans.

> 3. Some hooks for arches to override particular behavior as needed.
>    F.e. IA64 allocates percpu structures in a special way. x86_64
>    needs to do some tricks for the pda etc etc.

IA64 is going to need some work, since dynamic percpu addresses won't be able 
to use their pinned TLB trick to get the local version.

> > Mike's a clever guy, I'm sure he'll think of something :)
>
> Hopefully. Otherwise he will ask me =-).

And as always, lkml will offer feedback; useful and otherwise :)

Cheers,
Rusty.
