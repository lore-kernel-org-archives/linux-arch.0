From: David Howells <dhowells@redhat.com>
Subject: Re: [RFC PATCH 03/15] Provide atomic_t functions implemented with ISO-C++11 atomics
Date: Thu, 19 May 2016 10:52:19 +0100
Message-ID: <10546.1463651539@warthog.procyon.org.uk>
References: <20160518173218.GE3206@twins.programming.kicks-ass.net> <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk> <146358425972.8596.7418861336334796772.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33019 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753849AbcESJwW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 May 2016 05:52:22 -0400
In-Reply-To: <20160518173218.GE3206@twins.programming.kicks-ass.net>
Content-ID: <10545.1463651539.1@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org

Peter Zijlstra <peterz@infradead.org> wrote:

> Does this generate 'sane' code for LL/SC archs? That is, a single LL/SC
> loop and not a loop around an LL/SC cmpxchg.

Depends on your definition of 'sane'.  The code will work - but it's not
necessarily the most optimal.  gcc currently keeps the __atomic_load_n() and
the fudging in the middle separate from the __atomic_compare_exchange_n().

So on aarch64:

	static __always_inline int __atomic_add_unless(atomic_t *v,
						       int addend, int unless)
	{
		int cur = __atomic_load_n(&v->counter, __ATOMIC_RELAXED);
		int new;

		do {
			if (__builtin_expect(cur == unless, 0))
				break;
			new = cur + addend;
		} while (!__atomic_compare_exchange_n(&v->counter,
						      &cur, new,
						      false,
						      __ATOMIC_SEQ_CST,
						      __ATOMIC_RELAXED));
		return cur;
	}

	int test_atomic_add_unless(atomic_t *counter)
	{
		return __atomic_add_unless(counter, 0x56, 0x23);
	}

is compiled to:

	test_atomic_add_unless:
		sub	sp, sp, #16		# unnecessary
		ldr	w1, [x0]		# __atomic_load_n()
		str	w1, [sp, 12]		# bug 70825
	.L5:
		ldr	w1, [sp, 12]		# bug 70825
		cmp	w1, 35			# } cur == unless
		beq	.L4			# }
		ldr	w3, [sp, 12]		# bug 70825
		add	w1, w1, 86		# new = cur + addend
	.L7:
		ldaxr	w2, [x0]		# }
		cmp	w2, w3			# } __atomic_compare_exchange()
		bne	.L8			# }
		stlxr	w4, w1, [x0]		# }
		cbnz	w4, .L7			# }
	.L8:
		beq	.L4
		str	w2, [sp, 12]		# bug 70825
		b	.L5
	.L4:
		ldr	w0, [sp, 12]		# bug 70825
		add	sp, sp, 16		# unnecessary
		ret

or if compiled with -march=armv8-a+lse, you get:

	test_atomic_add_unless:
		sub	sp, sp, #16		# unnecessary
		ldr	w1, [x0]		# __atomic_load_n()
		str	w1, [sp, 12]		# bug 70825
	.L5:
		ldr	w1, [sp, 12]		# bug 70825
		cmp	w1, 35			# } cur == unless
		beq	.L4			# }
		ldr	w3, [sp, 12]		# bug 70825
		add	w1, w1, 86		# new = cur + addend
		mov	w2, w3
		casal	w2, w1, [x0]		# __atomic_compare_exchange_n()
		cmp	w2, w3
		beq	.L4
		str	w2, [sp, 12]		# bug 70825
		b	.L5
	.L4:
		ldr	w0, [sp, 12]		# bug 70825
		add	sp, sp, 16		# unnecessary
		ret

which replaces the LDAXR/STLXR with a CASAL instruction, but is otherwise the
same.

I think the code it generates should look something like:

	test_atomic_add_unless:
	.L7:
		ldaxr	w1, [x0]		# __atomic_load_n()
		cmp	w1, 35			# } if (cur == unless)
		beq	.L4			# }     break
		add	w2, w1, 86		# new = cur + addend
		stlxr	w4, w2, [x0]
		cbnz	w4, .L7
	.L4:
		mov	w1, w0
		ret

but that requires the compiler to split up the LDAXR and STLXR instructions
and render arbitrary code between.  I suspect that might be quite a stretch.

I've opened:

	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=71191

to cover this.

David
