From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 03/15] Provide atomic_t functions implemented with
 ISO-C++11 atomics
Date: Thu, 19 May 2016 07:22:52 -0700
Message-ID: <20160519142252.GR3528@linux.vnet.ibm.com>
References: <20160518173218.GE3206@twins.programming.kicks-ass.net>
 <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
 <146358425972.8596.7418861336334796772.stgit@warthog.procyon.org.uk>
 <10546.1463651539@warthog.procyon.org.uk>
 <20160519105000.GV3193@twins.programming.kicks-ass.net>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e18.ny.us.ibm.com ([129.33.205.208]:35412 "EHLO
	e18.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932686AbcESOWz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 May 2016 10:22:55 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 19 May 2016 10:22:54 -0400
Content-Disposition: inline
In-Reply-To: <20160519105000.GV3193@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, ramana.radhakrishnan@arm.com, dwmw2@infradead.org

On Thu, May 19, 2016 at 12:50:00PM +0200, Peter Zijlstra wrote:
> On Thu, May 19, 2016 at 10:52:19AM +0100, David Howells wrote:
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > Does this generate 'sane' code for LL/SC archs? That is, a single LL/SC
> > > loop and not a loop around an LL/SC cmpxchg.
> 
> > I think the code it generates should look something like:
> > 
> > 	test_atomic_add_unless:
> > 	.L7:
> > 		ldaxr	w1, [x0]		# __atomic_load_n()
> > 		cmp	w1, 35			# } if (cur == unless)
> > 		beq	.L4			# }     break
> > 		add	w2, w1, 86		# new = cur + addend
> > 		stlxr	w4, w2, [x0]
> > 		cbnz	w4, .L7
> > 	.L4:
> > 		mov	w1, w0
> > 		ret
> > 
> > but that requires the compiler to split up the LDAXR and STLXR instructions
> > and render arbitrary code between.
> 
> Exactly.
> 
> > I suspect that might be quite a stretch.
> > 
> > I've opened:
> > 
> > 	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=71191
> > 
> > to cover this.

Thank you!

> Thanks; until such time as this stretch has been made I don't see this
> intrinsic stuff being much use on any of the LL/SC archs.

Agreed, these sorts of instruction sequences make a lot of sense.
Of course, if you stuff too many intructions and cache misses between
the LL and the SC, the SC success probability starts dropping, but short
seqeunces of non-memory-reference instructions like the above should be
just fine.

							Thanx, Paul
