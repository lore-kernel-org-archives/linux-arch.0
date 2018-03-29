From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH RFC tools/memory-model] Add s390.{cfg,cat}
Date: Thu, 29 Mar 2018 10:40:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1803291021500.1292-100000@iolanthe.rowland.org>
References: <20180329021812.GV3675@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329021812.GV3675@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

On Wed, 28 Mar 2018, Paul E. McKenney wrote:

> > > In the meantime, does the cat file look to you like it correctly
> > > models the combination of TSO and multicopy atomicity?  Do the
> > > fences really work, or did I just get lucky with my choice of
> > > litmus tests?
> > 
> > You got lucky.  Try creating an SB litmus test where, instead of an
> > smp_mb() fence between the write and the read, each thread executes
> > some other kind of fence.
> 
> Ah, it does indeed get "Never" in that case, which I do not believe
> to e correct.
> 
> > The acyclicity condition should have been written more like this:
> > 
> > let po_ghb = ([R] ; po ; [M]) | ([M] ; po ; [W])
> > 
> > acyclic mfence | po_ghb | rf | fr | co as tso-mca
> > 
> > I don't know what the fence instruction is on s390; change the "mfence"
> > above accordingly.  The main difference between this and the
> > corresponding expression in x86tso.cat is that I replaced rfe with rf.
> 
> The s390 fence instruction is "bcr 14,0" or "bcr 15,0", depending on
> how recent of hardware you are running.  The latter works everywhere,
> if I recall correctly.  But I do not believe that herd knows about either
> instruction yet.

Herd does not need to understand s390 assembly in order to handle the 
things defined in linux.def, such as "smp_mb()".  linux.def doesn't 
contain any x86 assembly language stuff either (or PPC or ARM).

>  Ah, and I need to lose the "empty rmw & (fre;coe)".
> That appears to be where my spurious ordering was coming from, strange
> though that seems to me.

No, don't drop it; it was not the source of your spurious ordering.  
The extra ordering came from your "(po \ (W * R))" term, which 
unintentionally matches fences as well as memory accesses.

> And your use of "rf" instead of "rfe" makes sense, as that is what makes
> the read-from-write provide ordering, correct?  And that should also cover
> the "Uniproc check" that would otherwise be required, right?

I don't think so...

> Except that I get "Sometimes" on CoWR+poonceonce+Once.litmus...

Exactly.

> Which I can fix by unioning po-loc into po-ghb.  Or is there some
> better way to do this?

You could just keep the "uniproc" check.  These two approaches accept 
the same set of litmus tests.

Logically, I think of these as two distinct categories of ordering.  
po_ghb and tso-mca have to do with the order in which stores reach the 
cache, whereas "uniproc" (AKA sequential consistency per variable) has 
to do with enforcement of the cache coherence requirements.  Clearly 
they are related, but they aren't the same thing.

> > This doesn't account for atomic operations properly; see the "implied" 
> > term in x86tso.cat.
> 
> I will look at this more later, reaching end of both battery and useful
> attention span...

Alan
