Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751144AbdJEQby (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Oct 2017 12:31:54 -0400
Date: Thu, 5 Oct 2017 17:31:54 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 1/2] arm64: mm: Use READ_ONCE/WRITE_ONCE when
 accessing page tables
Message-ID: <20171005163154.GH11088@arm.com>
References: <1506527369-19535-2-git-send-email-will.deacon@arm.com>
 <20170928083801.m6rb4frbbgzgam2o@hirez.programming.kicks-ass.net>
 <20170928084535.GA19060@arm.com>
 <20170928154354.GK3521@linux.vnet.ibm.com>
 <20170928185909.kgwy36hkoqxqgyc3@tower>
 <20170929005830.GU3521@linux.vnet.ibm.com>
 <20170929090843.GB14791@arm.com>
 <20170929162939.GY3521@linux.vnet.ibm.com>
 <20170929163348.GD2376@arm.com>
 <20171003191109.GB3521@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171003191109.GB3521@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Michael Cree <mcree@orcon.net.nz>, Peter Zijlstra <peterz@infradead.org>, kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org, ynorov@caviumnetworks.com, rruigrok@codeaurora.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, catalin.marinas@arm.com, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, linux-alpha@vger.kernel.org
Message-ID: <20171005163154.0teVCk4Q-Iv45SJCXgQwMRAS-fxwRypZuNKchezvAaU@z>

Hi Paul,

On Tue, Oct 03, 2017 at 12:11:10PM -0700, Paul E. McKenney wrote:
> On Fri, Sep 29, 2017 at 05:33:49PM +0100, Will Deacon wrote:
> > On Fri, Sep 29, 2017 at 09:29:39AM -0700, Paul E. McKenney wrote:
> > > On Fri, Sep 29, 2017 at 10:08:43AM +0100, Will Deacon wrote:
> > > > Ok, but where does that leave us wrt my initial proposal of moving
> > > > smp_read_barrier_depends() into READ_ONCE and getting rid of
> > > > lockless_dereference?
> > > > 
> > > > Michael (or anybody else running mainline on SMP Alpha) -- would you be
> > > > able to give the diff below a spin and see whether there's a measurable
> > > > performance impact?
> > > 
> > > This will be a sensitive test.  The smp_read_barrier_depends() can be
> > > removed from lockless_dereference().  Without this removal Alpha will
> > > get two memory barriers from rcu_dereference() and friends.
> > 
> > Oh yes, good point. I was trying to keep the diff simple, but you're
> > right that this is packing too many barriers. Fixed diff below.
> 
> Not seeing any objections thus far.  If there are none by (say) the
> end of this week, I would be happy to queue a patch for the 4.16
> merge window.  That should give ample opportunity for further review
> and testing.

Ok, full patch below.

Will

--->8
