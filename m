From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 03/15] Provide atomic_t functions implemented with
 ISO-C++11 atomics
Date: Thu, 19 May 2016 12:50:00 +0200
Message-ID: <20160519105000.GV3193@twins.programming.kicks-ass.net>
References: <20160518173218.GE3206@twins.programming.kicks-ass.net>
 <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
 <146358425972.8596.7418861336334796772.stgit@warthog.procyon.org.uk>
 <10546.1463651539@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:39004 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181AbcESKuJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 May 2016 06:50:09 -0400
Content-Disposition: inline
In-Reply-To: <10546.1463651539@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org

On Thu, May 19, 2016 at 10:52:19AM +0100, David Howells wrote:
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Does this generate 'sane' code for LL/SC archs? That is, a single LL/SC
> > loop and not a loop around an LL/SC cmpxchg.

> I think the code it generates should look something like:
> 
> 	test_atomic_add_unless:
> 	.L7:
> 		ldaxr	w1, [x0]		# __atomic_load_n()
> 		cmp	w1, 35			# } if (cur == unless)
> 		beq	.L4			# }     break
> 		add	w2, w1, 86		# new = cur + addend
> 		stlxr	w4, w2, [x0]
> 		cbnz	w4, .L7
> 	.L4:
> 		mov	w1, w0
> 		ret
> 
> but that requires the compiler to split up the LDAXR and STLXR instructions
> and render arbitrary code between.

Exactly.

> I suspect that might be quite a stretch.
> 
> I've opened:
> 
> 	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=71191
> 
> to cover this.

Thanks; until such time as this stretch has been made I don't see this
intrinsic stuff being much use on any of the LL/SC archs.
