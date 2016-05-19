From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 03/15] Provide atomic_t functions implemented with
 ISO-C++11 atomics
Date: Thu, 19 May 2016 08:00:27 -0700
Message-ID: <20160519150027.GT3528@linux.vnet.ibm.com>
References: <20160518173218.GE3206@twins.programming.kicks-ass.net>
 <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
 <146358425972.8596.7418861336334796772.stgit@warthog.procyon.org.uk>
 <10546.1463651539@warthog.procyon.org.uk>
 <20160519105000.GV3193@twins.programming.kicks-ass.net>
 <20160519142252.GR3528@linux.vnet.ibm.com>
 <20160519144117.GX3193@twins.programming.kicks-ass.net>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:58286 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019AbcESPA1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 May 2016 11:00:27 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 19 May 2016 09:00:25 -0600
Content-Disposition: inline
In-Reply-To: <20160519144117.GX3193@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, ramana.radhakrishnan@arm.com, dwmw2@infradead.org

On Thu, May 19, 2016 at 04:41:17PM +0200, Peter Zijlstra wrote:
> On Thu, May 19, 2016 at 07:22:52AM -0700, Paul E. McKenney wrote:
> > Agreed, these sorts of instruction sequences make a lot of sense.
> > Of course, if you stuff too many intructions and cache misses between
> > the LL and the SC, the SC success probability starts dropping, but short
> > seqeunces of non-memory-reference instructions like the above should be
> > just fine.
> 
> In fact, pretty much every single LL/SC arch I've looked at doesn't
> allow _any_ loads or stores inside and will guarantee SC failure (or
> worse) if you do.

Last I know, PowerPC allowed memory-reference instructions inside, but
the more of them you have, the less likely your reservation is to survive.
But perhaps I missed some fine print somewhere.  And in any case,
omitting them is certainly better.

> This immediately disqualifies things like calls/traps/etc.. because
> those implicitly issue stores.

Traps for sure.  Not so sure about calls on PowerPC.

							Thanx, Paul
