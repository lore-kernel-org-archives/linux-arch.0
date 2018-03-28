From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tools/memory-model] Add s390.{cfg,cat}
Date: Wed, 28 Mar 2018 09:49:22 -0700
Message-ID: <20180328164922.GA25475@linux.vnet.ibm.com>
References: <20180328134232.GA29274@linux.vnet.ibm.com>
 <20180328134813.GF4082@hirez.programming.kicks-ass.net>
 <20180328142004.GR3675@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180328142004.GR3675@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 28, 2018 at 07:20:04AM -0700, Paul E. McKenney wrote:
> On Wed, Mar 28, 2018 at 03:48:13PM +0200, Peter Zijlstra wrote:
> > On Wed, Mar 28, 2018 at 06:42:32AM -0700, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > The prototype patch shown below provides files required to allow herd7 to
> > > evaluate C-language litmus tests for the multicopy-atomic TSO ordering
> > > provided by s390.  
> > 
> > There really isn't anything s390 specific here is there? That is, would
> > this not equally work for x86 and sparc, both of which are similarly TSO
> > ?
> 
> As I understand it, there is a difference.  The difference from TSO
> systems such as x86 is that s390 is multicopy atomic as well as TSO.
> In contrast, x86 is TSO as well as other-multicopy-atomic.  I must defer
> to Martin and Christian for details -- this should be interpreted as a
> feeble first attempt on my part, not any sort of IBM-approved definition
> of s390.  ;-)
> 
> > Given that, should this not be called TSO instead of s390 ?
> 
> I agree completely with a single tso.cfg, TSO.cfg, or whatever name,
> as opposed to a bunch of identical files for x86, SPARC, ...

And to Alan's point, it appears that you can already test x86 TSO ordering
on C-language litmus tests as follows:

	herd7 -conf linux-kernel.cfg -cat x86tso.cat litmus-tests/SB+poonceoncescoh.litmus

Might simply be working by accident, but it does currently work.  ;-)

							Thanx, Paul
