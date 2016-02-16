From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Writes, smp_wmb(), and transitivity?
Date: Tue, 16 Feb 2016 03:13:40 -0800
Message-ID: <20160216111340.GS6719@linux.vnet.ibm.com>
References: <20160215175825.GA15878@linux.vnet.ibm.com>
 <20160215185832.GQ6298@arm.com>
 <20160215203512.GL6719@linux.vnet.ibm.com>
 <20160216095319.GA14509@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e17.ny.us.ibm.com ([129.33.205.207]:38070 "EHLO
	e17.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbcBPLNk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Feb 2016 06:13:40 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 16 Feb 2016 06:13:39 -0500
Content-Disposition: inline
In-Reply-To: <20160216095319.GA14509@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Andy.Glew@imgtec.com, Leonid.Yegoshin@imgtec.com, peterz@infradead.org, linux-arch@vger.kernel.org, arnd@arndb.de, davem@davemloft.net, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org, graham.whaley@gmail.com, torvalds@linux-foundation.org, hpa@zytor.com, mingo@kernel.org

On Tue, Feb 16, 2016 at 09:53:20AM +0000, Will Deacon wrote:
> On Mon, Feb 15, 2016 at 12:35:12PM -0800, Paul E. McKenney wrote:
> > On Mon, Feb 15, 2016 at 06:58:32PM +0000, Will Deacon wrote:
> > > On Mon, Feb 15, 2016 at 09:58:25AM -0800, Paul E. McKenney wrote:
> > > > Some architectures provide local transitivity for a chain of threads doing
> > > > writes separated by smp_wmb(), as exemplified by the litmus tests below.
> > > > The pattern is that each thread writes to a its own variable, does an
> > > > smp_wmb(), then writes a different value to the next thread's variable.
> > > > 
> > > > I don't know of a use of this, but if everyone supports it, it might
> > > > be good to mandate it.  Status quo is that smp_wmb() is non-transitive,
> > > > so it currently isn't supported.
> > > > 
> > > > Anyone know of any architectures that do -not- support this?
> > > > 
> > > > Assuming all architectures -do- support this, any arguments -against-
> > > > officially supporting it in Linux?
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > Two threads:
> > > > 
> > > > 	int a, b;
> > > > 
> > > > 	void thread0(void)
> > > > 	{
> > > > 		WRITE_ONCE(a, 1);
> > > > 		smp_wmb();
> > > > 		WRITE_ONCE(b, 2);
> > > > 	}
> > > > 
> > > > 	void thread1(void)
> > > > 	{
> > > > 		WRITE_ONCE(b, 1);
> > > > 		smp_wmb();
> > > > 		WRITE_ONCE(a, 2);
> > > > 	}
> > > > 
> > > > 	/* After all threads have completed and the dust has settled... */
> > > > 
> > > > 	BUG_ON(a == 1 && b == 1);
> > > 
> > > My understanding is that this test, and the generalisation to n threads,
> > > is forbidden on ARM. However, the transitivity of DMB ST (used to
> > > construct smp_wmb()) has been the subject of long debates, because we
> > > allow the following test:
> > > 
> > > 
> > > P0:
> > > Wx = 1
> > > 
> > > P1:
> > > Rx == 1
> > > DMB ST
> > > Wy = 1
> > > 
> > > P2:
> > > Ry == 1
> > > <addr dep>
> > > Rx == 0
> > > 
> > > 
> > > so I'd be uneasy about saying "it's all transitive".
> > 
> > Agreed!  For one thing, doesn't DMB ST need writes on both sides?
> 
> Yes, but it's a common trap that people fall into where they think the
> above is forbidden because the DMB ST in P1 should order P0's write
> before its own write of y.

True enough.

> > But that is one reason that I am only semi-enthusiastic about this.
> > The potentially locally transitive case is -very- restrictive, applying
> > only to situations where -all- accesses are writes.
> 
> I think that we will confuse people more by trying to describe the
> restricted case where we provide order than if we blanket say that its
> not transitive. I know Linus prefers to be as strong as possible, but
> this doesn't look like a realistic programming paradigm and having a
> straightforward rule that "rmb and wmb are not transitive" is much
> easier for people to deal with in my opinion.

That is a good explanation of why I am only semi-enthusiastic about
this.  ;-)

							Thanx, Paul
