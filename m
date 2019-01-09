From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH RFC memory-model 0/6] LKMM updates
Date: Wed, 9 Jan 2019 15:40:43 -0800
Message-ID: <20190109234043.GD1215@linux.ibm.com>
References: <20190109210706.GA27268@linux.ibm.com>
 <20190109231852.GA4494@andrea>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190109231852.GA4494@andrea>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, willy@infradead.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jan 10, 2019 at 12:18:53AM +0100, Andrea Parri wrote:
> On Wed, Jan 09, 2019 at 01:07:06PM -0800, Paul E. McKenney wrote:
> > Hello!
> > 
> > This series contains updates for the Linux-kernel memory model:
> > 
> > 1-3.	Add SRCU support, courtesy of Alan Stern.
> > 
> > 4.	Update README for adding of SRCU support.
> > 
> > 5.	Update memory-barriers.txt on enforcing heavy ordering for
> > 	port-I/O accesses, courtesy of Will Deacon.  This one needs
> > 	an ack, preferably by someone from Intel.  Matthew Wilcox
> > 	posted some feedback from an Intel manual here, which might
> > 	be considered to be a close substitute, but...  ;-)
> > 
> > 	http://lkml.kernel.org/r/20181127192234.GF10377@bombadil.infradead.org
> > 
> > 6.	Update Documentation/explanation.txt to include SRCU support,
> > 	courtesy of Alan Stern.
> > 
> > 7.	Dynamically check SRCU lock-to-unlock matching, courtesy of
> > 	Luc Maranget.  This needs an ack.
> 
> It seems that
> 
>   1b52d0186177 ("tools/memory-model: Model smp_mb__after_unlock_lock()")
>   
> from linux-rcu/dev got lost; this also needs an ack (probably yours! ;D,
> considered that, IIRC, you introduced the primitive and RCU is currently
> its only user.)

That commit is in -tip:

4607abbcf464 ("tools/memory-model: Model smp_mb__after_unlock_lock()")

So it has already left my -rcu tree.  ;-)

							Thanx, Paul
