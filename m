From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 03/15] Provide atomic_t functions implemented with
 ISO-C++11 atomics
Date: Thu, 19 May 2016 13:31:16 +0200
Message-ID: <20160519113116.GL3205@twins.programming.kicks-ass.net>
References: <20160518173218.GE3206@twins.programming.kicks-ass.net>
 <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
 <146358425972.8596.7418861336334796772.stgit@warthog.procyon.org.uk>
 <10546.1463651539@warthog.procyon.org.uk>
 <20160519105000.GV3193@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:39043 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbcESLbZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 May 2016 07:31:25 -0400
Content-Disposition: inline
In-Reply-To: <20160519105000.GV3193@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org

On Thu, May 19, 2016 at 12:50:00PM +0200, Peter Zijlstra wrote:
> > I suspect that might be quite a stretch.
> > 
> > I've opened:
> > 
> > 	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=71191
> > 
> > to cover this.
> 
> Thanks; until such time as this stretch has been made I don't see this
> intrinsic stuff being much use on any of the LL/SC archs.

FWIW, Will and me have been discussing a GCC/LLVM language extension
that would allow generating the insides of LL/SC loops. But neither has
had time to properly write something down yet :/


My latest thinking is something along the lines of:


static __always_inline int __load_locked(int *ptr)
{
	int val;

	__asm__ __volatile__ ("ldaxr %[val], [%[ptr]]"
				: [val] "r" (val)
				: [ptr] "m" (*ptr));

	return val;
}

static __always_inline bool __store_conditional(int *ptr, int old, int new)
{
	int ret;

	__asm__ __volatile__ ("stlxr %[ret], %[new], [%[ptr]]"
		: [ret] "r" (ret)
		: [new] "r" (new),
		  [ptr] "m" (*ptr));

	return ret != 0;
}

bool atomic_add_unless(atomic_t *v, int a, int u)
{
	int val, old;

	do __special_marker__ {
		old = val = __load_locked(&v->counter);

		if (val == u)
			goto fail;

		val += a;
	} while (__store_conditional(&v->counter, old, val));

	return true;

fail:
	return false;
}


Where the __special_marker__ marks the whole { } scope as being the
inside of LL/SC and all variables must be in registers before we start.
If the compiler is not able to guarantee this, it must generate a
compile time error etc..

The __sc takes the @old and @new arguments such that we can implement
this on CAS archs with a regular load and CAS.
