Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:38332 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbeCPKLa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Mar 2018 06:11:30 -0400
Date: Fri, 16 Mar 2018 11:11:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Do we need to disable preemption in flush_tlb_range()?
Message-ID: <20180316101124.GB4064@hirez.programming.kicks-ass.net>
References: <1519917189.13866.6.camel@synopsys.com>
 <5a5c67c1-9f45-f908-2c8d-0914cd616a18@synopsys.com>
 <20180315082720.GT4064@hirez.programming.kicks-ass.net>
 <1521106770.11552.70.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521106770.11552.70.camel@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Message-ID: <20180316101124.CplhKkI8ck9-Y3e44oto3Fj_2juMffdpCdUWGrEsPQs@z>

On Thu, Mar 15, 2018 at 09:39:31AM +0000, Alexey Brodkin wrote:
> Hi Peter,
> 
> On Thu, 2018-03-15 at 09:27 +0100, Peter Zijlstra wrote:
> > On Wed, Mar 14, 2018 at 01:19:01PM -0700, Vineet Gupta wrote:
> > > +CC Peter since we have his attention ;-)
> > 
> > Yeah, timezone collision there, I typically sleep at 1am ;-)
> > 
> > > On 03/01/2018 07:13 AM, Alexey Brodkin wrote:
> > > > Hi Vineet,
> > > > 
> > > > Just noticed that in comments for smp_call_function_many() it is said that
> > > > preemption must be disabled during its execution. And that function gets executed
> > > > among other ways like that:
> > > > -------------------------->8-----------------------
> > > >    flush_tlb_range()
> > > >      -> on_each_cpu_mask()
> > > >           -> smp_call_function_many()
> > > > -------------------------->8-----------------------
> > > 
> > > In general I prefer not to - Peter what say you ?
> > 
> > The comment with smp_call_function_many() is correct, it relies on
> > preemption being disabled in a number of ways. I would expect
> > this_cpu_ptr() for example to complain when used with preemption
> > enabled (CONFIG_DEBUG_PREEMPT).

So on_each_cpu_mask() already disables preemption around calling
smp_call_function_many().
