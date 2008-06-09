From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 04/41] cpu ops: Core piece for generic atomic per cpu
 operations
Date: Mon, 9 Jun 2008 12:00:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0806091158020.30776@schroedinger.engr.sgi.com>
References: <20080530035620.587204923@sgi.com> <200806021200.41652.rusty@rustcorp.com.au>
 <4846DC6B.6030802@sgi.com> <200806060959.13362.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:48603 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751088AbYFITAh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jun 2008 15:00:37 -0400
In-Reply-To: <200806060959.13362.rusty@rustcorp.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Mike Travis <travis@sgi.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>

On Fri, 6 Jun 2008, Rusty Russell wrote:

> > Also, the above cpu_local_wrap(...) adds:
> >
> > 	#define cpu_local_wrap(l)               \
> > 	({                                      \
> > 	        preempt_disable();              \
> > 	        (l);                            \
> > 	        preempt_enable();               \
> > 	})                                      \
> >
> > ... and there isn't a non-preemption version that I can find.
> 
> Yes, this should be fixed.  I thought i386 had optimized versions pre-merge, 
> but I was wrong (%gs for per-cpu came later, and noone cleaned up these naive 
> versions).  Did you want me to write them?

How can that be fixed? You have no atomic instruction that calculates the 
per cpu address in one go. And as long as that is the case you need to 
disable preempt. Otherwise you may increment the per cpu variable of 
another processor because the process was rescheduled after the address 
was calculated but before the increment was done.

> > One other distinction is CPU_INC increments an arbitrary sized variable
> > while local_inc requires a local_t variable.  This may not make it usable
> > in all cases.
> 
> You might be right, but note that local_t is 64 bit on 64-bit platforms.  And 
> speculation of possible use cases isn't a good reason to rip out working 
> infrastructure :)

Its fundamentally broken since because of the preemption issue. This is 
also why local_t is rarely used.
