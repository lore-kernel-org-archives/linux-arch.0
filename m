From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] barriers: introduce smp_mb__release_acquire and update
 documentation
Date: Tue, 22 Sep 2015 16:58:28 +0100
Message-ID: <20150922155828.GK7356@arm.com>
References: <20150916091452.GC3816@twins.programming.kicks-ass.net>
 <20150916102908.GA28771@arm.com>
 <20150916104314.GA3604@twins.programming.kicks-ass.net>
 <20150916110706.GF28771@arm.com>
 <20150917025012.GB4000@fixme-laptop.cn.ibm.com>
 <20150917180001.GR25634@arm.com>
 <20150921134515.GA970@fixme-laptop.cn.ibm.com>
 <20150921141038.GB970@fixme-laptop.cn.ibm.com>
 <20150921222301.GF7356@arm.com>
 <20150922152241.GN4029@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150922152241.GN4029@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Paul,

On Tue, Sep 22, 2015 at 04:22:41PM +0100, Paul E. McKenney wrote:
> On Mon, Sep 21, 2015 at 11:23:01PM +0100, Will Deacon wrote:
> > On Mon, Sep 21, 2015 at 03:10:38PM +0100, Boqun Feng wrote:
> > > On Mon, Sep 21, 2015 at 09:45:15PM +0800, Boqun Feng wrote:
> > > > 
> > > > Ah.. that's indeed an issue! for example:
> > > > 
> > > > CPU 0			CPU 1				CPU 2
> > > > =====================	==========================	================
> > > > {a = 0, b = 0, c = 0}
> > > > r1 = READ_ONCE(a);	WRITE_ONCE(b, 1);		r3 = smp_load_acquire(&c);
> > > > smp_rmb();		smp_store_release(&c, 1);	WRITE_ONCE(a, 1);
> > > > r2 = READ_ONCE(b)
> > > > 
> > > > where r1 == 1 && r2 == 0 && r3 == 1 is actually not prohibitted, at
> > > > least on POWER.
> > > > 
> > > 
> > > Oops.. I use wrong litmus here.. so this is prohibitted on POWER. Sorry
> > > for the misleading. How about the behavior of that on arm and arm64?
> > 
> > That explicit test is forbidden on arm/arm64 because of the smp_rmb(),
> > but if you rewrite it as (LDAR is acquire, STLR is release):
> > 
> > 
> >   {
> >   0:X1=x; 0:X3=y;
> >   1:X1=y; 1:X2=z;
> >   2:X1=z; 2:X3=x;
> >   }
> >    P0           | P1           | P2                ;
> >    LDAR W0,[X1] | MOV W0,#1    | LDAR W0,[X1]      ;
> >    LDR W2,[X3]  | STR W0,[X1]  | MOV W2,#1         ;
> >                 | STLR W0,[X2] | STR W2,[X3]       ;
> > 
> >   Observed
> >       0:X0=1; 0:X2=0; 2:X0=1;
> > 
> > 
> > then it is permitted on arm64. Note that herd currently claims that this
> > is forbidden, but I'm talking to the authors about getting that fixed :)
> 
> But a pure store-release/load-acquire chain would be forbidden in
> hardware as well as by herd, correct?

Yup, and since that's likely the common use-case, I think that's precisely
the scenario where it makes sense for us to require transitivity in the
kernel.

Will
