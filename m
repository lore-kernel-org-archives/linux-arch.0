Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:39117 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbYB1IqH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 28 Feb 2008 03:46:07 -0500
Date: Thu, 28 Feb 2008 09:45:58 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [rfc][patch] x86-64 new smp_call_function design
Message-ID: <20080228084558.GA32631@elte.hu>
References: <20080227124217.GA1340@wotan.suse.de> <20080227132713.GA13681@elte.hu> <20080227135041.GC1340@wotan.suse.de> <20080227150210.GA21610@elte.hu> <20080227221407.GA26067@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080227221407.GA26067@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org


* Nick Piggin <npiggin@suse.de> wrote:

> On Wed, Feb 27, 2008 at 04:02:10PM +0100, Ingo Molnar wrote:
> > 
> > * Nick Piggin <npiggin@suse.de> wrote:
> > 
> > > > the two structures are quite similar in size and role - why not have 
> > > > a type field and handle them largely together? I think we should try 
> > > > to preserve a single queue and a single vector - that would remove a 
> > > > number of ugly special-cases from the patch.
> > > 
> > > A single queue will kill one of the big fundamental scalability 
> > > improvements of the call_single. That's the problem.
> > 
> > hm, indeed. Then how about the other way around: couldnt the normal 
> > all-cpus SMP function call be implemented transparently via using 
> > smp_call_single() calls?
> 
> That's possible, but it is slower and less scalable on my 8-way, and
> I suspect it might become even slower than the generic code on larger
> systems.

i dont mean "implement call-all as a series of call-single" calls, but 
use just a single queue of requests and differentiate on the data 
structure level. Right now you use the vector # as the differentiator.

but ... no strong feelings, i'm just playing the devil's advocate :) 
Your work is great (and i now see that i forgot to state this clearly 
enough in my first mail - i thought i to be obvious, based on your 
numbers!), i'm really just trying to micro-optimize the concept.

Could you try to unify it with the 32-bit code, preferably into a 
separate, unified arch/x86/kernel/smp.c file? Such an approach would 
make it into x86.git in a heartbeat :)

> > The vector duplication is really ugly and feels wrong.
> 
> Why?

it's ~0.5% of our irq vector space? :-)

we could also try to implement a "NOP" type of single call [ using a nop 
callback is one of the easiest possibilities there ;) ] - which would 
allow us to eliminate the special reschedule vector as well. That means 
we could consolidate all the SMP cross-calls into a single vector.

OTOH, i see how you save multiplexing/demultiplexing complexity on both 
the sending and the receiving side by using the separate vectors. So i 
guess, if it's fast enough, we should indeed do your two vectors 
approach and also merge the reschedule special vector into the 
single-call path and thus have no effect on the size of the vector 
space. (no need to add a new vector even - just rename the reschedule 
vector to single-call vector)

	Ingo
