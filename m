From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH 03/15] Provide atomic_t functions implemented with
 ISO-C++11 atomics
Date: Fri, 20 May 2016 19:32:09 +1000
Message-ID: <1463736729.23394.3.camel@ellerman.id.au>
References: <20160518173218.GE3206@twins.programming.kicks-ass.net>
	 <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
	 <146358425972.8596.7418861336334796772.stgit@warthog.procyon.org.uk>
	 <10546.1463651539@warthog.procyon.org.uk>
	 <20160519105000.GV3193@twins.programming.kicks-ass.net>
	 <20160519142252.GR3528@linux.vnet.ibm.com>
	 <20160519144117.GX3193@twins.programming.kicks-ass.net>
	 <20160519150027.GT3528@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160519150027.GT3528@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paulmck@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>
Cc: David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, ramana.radhakrishnan@arm.com, dwmw2@infradead.org
List-Id: linux-arch.vger.kernel.org

On Thu, 2016-05-19 at 08:00 -0700, Paul E. McKenney wrote:
> On Thu, May 19, 2016 at 04:41:17PM +0200, Peter Zijlstra wrote:
> > On Thu, May 19, 2016 at 07:22:52AM -0700, Paul E. McKenney wrote:
> > > Agreed, these sorts of instruction sequences make a lot of sense.
> > > Of course, if you stuff too many intructions and cache misses between
> > > the LL and the SC, the SC success probability starts dropping, but short
> > > seqeunces of non-memory-reference instructions like the above should be
> > > just fine.
> > 
> > In fact, pretty much every single LL/SC arch I've looked at doesn't
> > allow _any_ loads or stores inside and will guarantee SC failure (or
> > worse) if you do.
> 
> Last I know, PowerPC allowed memory-reference instructions inside, but
> the more of them you have, the less likely your reservation is to survive.
> But perhaps I missed some fine print somewhere.  And in any case,
> omitting them is certainly better.

There's nothing in the architecture AFAIK.

Also I don't see anything to indicate that doing more unrelated accesses makes
the reservation more likely to be lost. Other than it causes you to hold the
reservation for longer, which increases the chance of some other CPU accessing
the variable.

Having said that, the architecture is written to provide maximum wiggle room
for implementations. So the list of things that may cause the reservation to be
lost includes "Implementation-specific characteristics of the coherence
mechanism", ie. anything.

> > This immediately disqualifies things like calls/traps/etc.. because
> > those implicitly issue stores.
> 
> Traps for sure.  Not so sure about calls on PowerPC.

Actually no, exceptions (aka interrupts/traps) are explicitly defined to *not*
clear the reservation. And function calls are just branches so should also be
fine.

cheers
