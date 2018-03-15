Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:47138 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeCOI1b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Mar 2018 04:27:31 -0400
Date: Thu, 15 Mar 2018 09:27:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Do we need to disable preemption in flush_tlb_range()?
Message-ID: <20180315082720.GT4064@hirez.programming.kicks-ass.net>
References: <1519917189.13866.6.camel@synopsys.com>
 <5a5c67c1-9f45-f908-2c8d-0914cd616a18@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a5c67c1-9f45-f908-2c8d-0914cd616a18@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Message-ID: <20180315082721.8stUv1xYEfYNj-2HSoipjakl1A-1QELo0tHcOBj1Vz8@z>

On Wed, Mar 14, 2018 at 01:19:01PM -0700, Vineet Gupta wrote:
> +CC Peter since we have his attention ;-)

Yeah, timezone collision there, I typically sleep at 1am ;-)

> On 03/01/2018 07:13 AM, Alexey Brodkin wrote:
> > Hi Vineet,
> > 
> > Just noticed that in comments for smp_call_function_many() it is said that
> > preemption must be disabled during its execution. And that function gets executed
> > among other ways like that:
> > -------------------------->8-----------------------
> >    flush_tlb_range()
> >      -> on_each_cpu_mask()
> >           -> smp_call_function_many()
> > -------------------------->8-----------------------
> 
> In general I prefer not to - Peter what say you ?

The comment with smp_call_function_many() is correct, it relies on
preemption being disabled in a number of ways. I would expect
this_cpu_ptr() for example to complain when used with preemption
enabled (CONFIG_DEBUG_PREEMPT).
