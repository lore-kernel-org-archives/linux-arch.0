From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 03/15] Provide atomic_t functions implemented with
 ISO-C++11 atomics
Date: Wed, 1 Jun 2016 15:16:07 +0100
Message-ID: <20160601141607.GF355@arm.com>
References: <20160518173218.GE3206@twins.programming.kicks-ass.net>
 <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
 <146358425972.8596.7418861336334796772.stgit@warthog.procyon.org.uk>
 <10546.1463651539@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <10546.1463651539@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org
List-Id: linux-arch.vger.kernel.org

On Thu, May 19, 2016 at 10:52:19AM +0100, David Howells wrote:
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Does this generate 'sane' code for LL/SC archs? That is, a single LL/SC
> > loop and not a loop around an LL/SC cmpxchg.
> 
> Depends on your definition of 'sane'.  The code will work - but it's not
> necessarily the most optimal.  gcc currently keeps the __atomic_load_n() and
> the fudging in the middle separate from the __atomic_compare_exchange_n().
> 
> So on aarch64:
> 
> 	static __always_inline int __atomic_add_unless(atomic_t *v,
> 						       int addend, int unless)
> 	{
> 		int cur = __atomic_load_n(&v->counter, __ATOMIC_RELAXED);
> 		int new;
> 
> 		do {
> 			if (__builtin_expect(cur == unless, 0))
> 				break;
> 			new = cur + addend;
> 		} while (!__atomic_compare_exchange_n(&v->counter,
> 						      &cur, new,
> 						      false,
> 						      __ATOMIC_SEQ_CST,
> 						      __ATOMIC_RELAXED));
> 		return cur;
> 	}
> 
> 	int test_atomic_add_unless(atomic_t *counter)
> 	{
> 		return __atomic_add_unless(counter, 0x56, 0x23);
> 	}

[...]

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
> and render arbitrary code between.  I suspect that might be quite a stretch.

... it's also weaker than the requirements of the kernel memory model.
See 8e86f0b409a4 ("arm64: atomics: fix use of acquire + release for full
barrier semantics") for the gory details.

Will
