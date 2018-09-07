From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Date: Fri, 7 Sep 2018 12:00:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1809071145260.1547-100000@iolanthe.rowland.org>
References: <20180906093655.GA9653@andrea>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180906093655.GA9653@andrea>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Will Deacon <will.deacon@arm.com>, Andrea Parri <parri.andrea@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Kernel development list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, akiyks@gmail.com, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>
List-Id: linux-arch.vger.kernel.org

On Thu, 6 Sep 2018, Andrea Parri wrote:

> > Have you noticed any part of the generic code that relies on ordinary 
> > acquire-release (rather than atomic RMW acquire-release) in order to 
> > implement locking constructs?
> 
> There are several places in code where the "lock-acquire" seems to be
> provided by an atomic_cond_read_acquire/smp_cond_load_acquire: I have
> mentioned one in qspinlock in this thread; qrwlock and mcs_spinlock
> provide other examples (grep for the primitives...).
> 
> As long as we don't consider these primitive as RMW (which would seem
> odd...) or as acquire for which "most people expect strong ordering"
> (see above), these provides other examples for the _gap_ I mentioned.

Okay, now I understand your objection.  It does appear that on RISC-V,
if nowhere else, the current implementations of qspinlock, qrwlock,
etc. will not provide "RCtso" ordering.

The discussions surrounding this topic have been so lengthy and 
confusing that I have lost track of any comments Palmer or Daniel may 
have made concerning this potential problem.

One possible resolution would be to define smp_cond_load_acquire() 
specially on RISC-V so that it provided the same ordering guarantees as 
RMW-acquire.  (Plus adding a comment in the asm-generic/barrier.h 
pointing out the necessity for the stronger guarantee on all 
architectures.)

Another would be to replace the usages of atomic/smp_cond_load_acquire 
in the locking constructs with a new function that would otherwise be 
the same but would provide the ordering guarantee we want.

Do you think either of these would be an adequate fix?

Alan
