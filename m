From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: Rough notes from sys_membarrier() lightning BoF
Date: Thu, 21 Sep 2017 10:23:39 -0700
Message-ID: <1506014619.3848.59.camel@HansenPartnership.com>
References: <20170917223608.GA14577@linux.vnet.ibm.com>
         <CALCETrUta2LvC=e7DNDDo_F5_OuEtehFoZJg1MUwUigTT5K7xw@mail.gmail.com>
         <1264439870.15044.1505931230400.JavaMail.zimbra@efficios.com>
         <20170921130950.nwfbyiil34psoyua@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170921130950.nwfbyiil34psoyua@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andy Lutomirski <luto@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, Alan Stern <stern@rowland.harvard.edu>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Dave Watson <davejwatson@fb.com>, maged michael <maged.michael@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Thu, 2017-09-21 at 15:09 +0200, Peter Zijlstra wrote:
> On Wed, Sep 20, 2017 at 06:13:50PM +0000, Mathieu Desnoyers wrote:
> 
> > 
> > > 
> > > Also, can you elaborate on the PPC issue?  PPC appears to track
> > > mm_cpumask more or less just like x86.  Is the issue just that
> > > this
> > > tracking has no implied barriers?  If so, how does TLB flush on
> > > ppc
> > > work?  It really does seem impressive to me that an architecture
> > > can
> > > efficiently support munmap() but not an expedited private
> > > membarrier.
> > 
> > I'll leave this question to the PPC experts :)
> 
> IIRC PPC does not keep a tight mm_cpumask, it only sets bit, it never
> clears bits. The atomic op required to set bits does not imply any
> memory barrier on PPC.
> 
> TLB invalidation is a TLBI instruction, it sends TLBI broadcast
> packets over the interconnect, it doesn't require IPIs like x86.

I believe this to be true for all SMP RISC systems ... it's certainly
true for PA-RISC as well.  There are so many RISC coherency issues that
the CPUs pretty much have to have a private bus to broadcast and
interlock coherency operations.  We have one system that locks up if
multiple CPUs have outstanding coherency operations on the private bus,
but that's only one annoying CPU (which we manage with a special lock
inside the PA-RISC mmu code).

James
