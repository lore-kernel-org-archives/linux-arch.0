From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/2] arm64: mm: Use READ_ONCE/WRITE_ONCE when
 accessing page tables
Date: Thu, 28 Sep 2017 08:43:54 -0700
Message-ID: <20170928154354.GK3521@linux.vnet.ibm.com>
References: <1506527369-19535-1-git-send-email-will.deacon@arm.com>
 <1506527369-19535-2-git-send-email-will.deacon@arm.com>
 <20170928083801.m6rb4frbbgzgam2o@hirez.programming.kicks-ass.net>
 <20170928084535.GA19060@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932113AbdI1PoC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 28 Sep 2017 11:44:02 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8SFgwJE008321
        for <linux-arch@vger.kernel.org>; Thu, 28 Sep 2017 11:44:02 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2d93yc02x2-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 28 Sep 2017 11:44:01 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 28 Sep 2017 11:44:00 -0400
Content-Disposition: inline
In-Reply-To: <20170928084535.GA19060@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org, ynorov@caviumnetworks.com, rruigrok@codeaurora.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, catalin.marinas@arm.com, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, linux-alpha@vger.kernel.org

On Thu, Sep 28, 2017 at 09:45:35AM +0100, Will Deacon wrote:
> On Thu, Sep 28, 2017 at 10:38:01AM +0200, Peter Zijlstra wrote:
> > On Wed, Sep 27, 2017 at 04:49:28PM +0100, Will Deacon wrote:
> > > In many cases, page tables can be accessed concurrently by either another
> > > CPU (due to things like fast gup) or by the hardware page table walker
> > > itself, which may set access/dirty bits. In such cases, it is important
> > > to use READ_ONCE/WRITE_ONCE when accessing page table entries so that
> > > entries cannot be torn, merged or subject to apparent loss of coherence.
> > 
> > In fact, we should use lockless_dereference() for many of them. Yes
> > Alpha is the only one that cares about the difference between that and
> > READ_ONCE() and they do have the extra barrier, but if we're going to do
> > this, we might as well do it 'right' :-)
> 
> I know this sounds daft, but I think one of the big reasons why
> lockless_dereference() doesn't get an awful lot of use is because it's
> such a mouthful! Why don't we just move the smp_read_barrier_depends()
> into READ_ONCE? Would anybody actually care about the potential impact on
> Alpha (which, frankly, is treading on thin ice given the low adoption of
> lockless_dereference())?

This is my cue to ask my usual question...  ;-)

Are people still running mainline kernels on Alpha?  (Added Alpha folks.)

As always, if anyone is, we must continue to support Alpha, but sounds
like time to check again.

							Thanx, Paul
