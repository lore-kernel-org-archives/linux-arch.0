Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02844394474
	for <linux-arch@vger.kernel.org>; Thu,  7 May 2026 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778147847; cv=none; b=PKJxcW9g9RBOy4jun4i/zWZ7l7gfYxJaXIfkDrUXiAw7elLqjdYdX81gBlyGVN+sGMIAcTLhEsWaRuZNyUhIsKVY1YHEpqrIO+QtgAgiStuZoJ8UBfAWJis55reBOo0baQi3Qs1s+0BgRjE8fc5QqsTlj/aT0c5o0LTvOjjf2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778147847; c=relaxed/simple;
	bh=hfGaOaB91E+XZBFp379GHs8PshD6s7Rlikxhrr5afig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cL9QhcB6Oqx8rmvSTGCOBrL2JVBePVrKt2E88na725emoYYT1fBpYVkbF7laKrl2sQ3VhvKNzfU1uxVZqHnUUqX97AUfwUURo/mQ3Kw9SIQrE/NCU5EoHe710+uus1H8eiwWihEteZcSTb29rVpAgCaoDaTQkEg6+tgTe126iiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9iGJjtG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9iGJjtG"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so5763315e9.2
        for <linux-arch@vger.kernel.org>; Thu, 07 May 2026 02:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778147843; x=1778752643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhLkLTolbyFKFrJFgOsn5aZNEw5iIaEfKoEnlONf3Ys=;
        b=f9iGJjtGGW5OD/Z68PnTMAc5pa5IGJBpfme4iErpujL9IruYgzql5GlO+A4wJ103Xr
         5COnQ7DVUtmvB/3MEYGEgCIOY/IwhB8ORUoOYMNEQcHQNgAWPkq7VGrk1FIwT9QtwRzp
         7s48Yotw7pQ5izpZJYMJ1EirPvE1cE6wbXRRGKWeAlzRM3wZsrFosjyERRC71RovadUH
         qjQLG0AivQh59Xssk6gQVZWMFhZgDSgcovqQ8W/XpXF6/aaTM/BUVgaiQBBooboWEg0C
         tJ0LcMnetpMCP/y60FAJtH+0vPVcsUymFcdjL4kJXaDLlGuDpr1oxs4HEI7XzCfY2aqf
         QP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778147843; x=1778752643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vhLkLTolbyFKFrJFgOsn5aZNEw5iIaEfKoEnlONf3Ys=;
        b=mY7VQevMT7ctRw9h7VgWCASr+RcjWdyp7+nfzmS09gOCkBXMGNCjKuDM2ccDbzL22T
         ZFSNrt9E1/vPuk48OYitJ28tNfRt26Y+SEJJw5inyoc6ZNpwYMb8FX3LomEIqZnQk/+l
         Th+qOHFgPN3SqrMVKqByA/ohcvpWHT4q7pf3eoj9FpPahlAM53P1E/ctsE+Kg+36vz34
         xcC74twBXDgPzV4J12iO2nE5G1GPc4LHeopg4L1w6XkgnAyTiY+D2csU5tt3vCH7Gd42
         UNdFUhCZY1+iI+/cJhDxPG3+V9UazuwlC+avR1qECbufGdXQ6GNy6NAr17yGlOp9b+mK
         gq/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9tPMBuCwuaG034y2AP/2EfC+NhGEDe/1bTA0DYgamfCFkfiFkaPJB/SN9rvYnXZDVA9uQVpZwZVORO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+sHLGGfNplCbzO5K0w8f0QFBWvH8H2iwuTSawlYIRag2MtbWr
	yEHcrBWUY6UvXDdPL4/FSdimQD1OvD31qC7eHYgo/k5/p5f6JFMFOIMb
X-Gm-Gg: AeBDietA2ALsbdpJHaJNGSXqHoQ6DGfhxuzwnpB2cSU3x7Dp6ivkPm6Z8a+tH+vfYAS
	PemoLqIGZ4yRFLmWPBbcuERV6rCPKLlU1b/BxSb3gsNi4z7NN5rMs75c2vCEuHN/xXmcCNQxHDu
	iLNLyWrJR+P5ZhtyaAldtAdKoBu5C2J3ot+MBcGzXN+Edoo+WgEYGdyyw4IsCZOL7EY9YG72qRd
	Q6kDJVVxj3E4cD69W4mk+zAc1IKNgvUSJ0OTM1mWYkngcdlVanp1zp/QzKKAiB1jxkCuEkhZ858
	NSrpllhuOgh2hXmphOY/4g9TcG4lNipuU8al3stHaSN6fEbBphntmWGEm5lFXQTYv+RmQsETVUS
	lATyvkYqtCQOnnnY3kjCATdOuZ1+hSbdpWmhlC9mFnyNm7d9KtkeModvUrQCmOgxwBoeCnMGjaB
	w8UwrowhRGUSZgzPuEdBaUNeN0tkgA+N8edBlYODHN8AkhsihY7YjYsk7IzVGXl2+5g8C049A=
X-Received: by 2002:a05:600c:1e8a:b0:488:fd7e:1063 with SMTP id 5b1f17b1804b1-48e51f4cdcdmr114717615e9.29.1778147843159;
        Thu, 07 May 2026 02:57:23 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538ca8c0sm104145975e9.13.2026.05.07.02.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 02:57:22 -0700 (PDT)
Date: Thu, 7 May 2026 10:57:21 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
 will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
 mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
 rafael@kernel.org, daniel.lezcano@linaro.org, memxor@gmail.com,
 zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com, rdunlap@infradead.org,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com, ashok.bhat@arm.com
Subject: Re: [PATCH v11 01/14] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
Message-ID: <20260507105721.66ba1e45@pumpkin>
In-Reply-To: <87o6isl0nl.fsf@oracle.com>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
	<20260408122538.3610871-2-ankur.a.arora@oracle.com>
	<874iklm1uy.fsf@oracle.com>
	<20260506095836.216d9cc5@pumpkin>
	<87o6isl0nl.fsf@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 06 May 2026 13:54:06 -0700
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> David Laight <david.laight.linux@gmail.com> writes:
> 
> > On Wed, 06 May 2026 00:30:29 -0700
> > Ankur Arora <ankur.a.arora@oracle.com> wrote:
> >  
> >> Ankur Arora <ankur.a.arora@oracle.com> writes:
> >>  
> >> > Add smp_cond_load_relaxed_timeout(), which extends
> >> > smp_cond_load_relaxed() to allow waiting for a duration.
> >> >
> >> > We loop around waiting for the condition variable to change while
> >> > peridically doing a time-check. The loop uses cpu_poll_relax() to slow
> >> > down the busy-wait, which, unless overridden by the architecture
> >> > code, amounts to a cpu_relax().
> >> >
> >> > Note that there are two ways for the time-check to fail: the timeout
> >> > case or, @time_expr_ns returning an invalid value (negative or zero).
> >> > The second failure mode allows for clocks attached to the clock-domain
> >> > of @cond_expr --  which might cease to operate meaningfully once some
> >> > state internal to @cond_expr has changed -- to fail.
> >> >
> >> > Evaluation of @time_expr_ns: in the fastpath we want to keep the
> >> > performance close to smp_cond_load_relaxed(). So defer evaluation
> >> > of the potentially costly @time_expr_ns to the slowpath.
> >> >
> >> > This also means that there will always be some hardware dependent
> >> > duration that has passed in cpu_poll_relax() iterations at the time
> >> > of first evaluation. Additionally cpu_poll_relax() is not guaranteed
> >> > to return at timeout boundary. In sum, expect timeout overshoot when
> >> > we exit due to expiration of the timeout.
> >> >
> >> > The number of spin iterations before time-check, SMP_TIMEOUT_POLL_COUNT
> >> > is chosen to be 200 by default. With a cpu_poll_relax() iteration
> >> > taking ~20-30 cycles (measured on a variety of x86 platforms), we
> >> > expect a time-check every ~4000-6000 cycles.
> >> >
> >> > The outer limit of the overshoot is double that when working with the
> >> > parameters above. This might be higher or lower depending on the
> >> > implementation of cpu_poll_relax() across architectures.
> >> >
> >> > Lastly, config option ARCH_HAS_CPU_RELAX indicates availability of a
> >> > cpu_poll_relax() that is cheaper than polling. This might be relevant
> >> > for cases with a long timeout.
> >> >
> >> > Cc: Arnd Bergmann <arnd@arndb.de>
> >> > Cc: Will Deacon <will@kernel.org>
> >> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> > Cc: Peter Zijlstra <peterz@infradead.org>
> >> > Cc: linux-arch@vger.kernel.org
> >> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> >> > Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> >> > ---
> >> > Notes:
> >> >    - add a comment mentioning that smp_cond_load_relaxed_timeout() might
> >> >      be using architectural primitives that don't support MMIO.
> >> >      (David Laight, Catalin Marinas)
> >> >
> >> >  include/asm-generic/barrier.h | 69 +++++++++++++++++++++++++++++++++++
> >> >  1 file changed, 69 insertions(+)
> >> >
> >> > diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> >> > index d4f581c1e21d..e5a6a1c04649 100644
> >> > --- a/include/asm-generic/barrier.h
> >> > +++ b/include/asm-generic/barrier.h
> >> > @@ -273,6 +273,75 @@ do {									\
> >> >  })
> >> >  #endif
> >> >
> >> > +/*
> >> > + * Number of times we iterate in the loop before doing the time check.
> >> > + * Note that the iteration count assumes that the loop condition is
> >> > + * relatively cheap.
> >> > + */
> >> > +#ifndef SMP_TIMEOUT_POLL_COUNT
> >> > +#define SMP_TIMEOUT_POLL_COUNT		200
> >> > +#endif
> >> > +
> >> > +/*
> >> > + * Platforms with ARCH_HAS_CPU_RELAX have a cpu_poll_relax() implementation
> >> > + * that is expected to be cheaper (lower power) than pure polling.
> >> > + */
> >> > +#ifndef cpu_poll_relax
> >> > +#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
> >> > +#endif
> >> > +
> >> > +/**
> >> > + * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
> >> > + * guarantees until a timeout expires.
> >> > + * @ptr: pointer to the variable to wait on.
> >> > + * @cond_expr: boolean expression to wait for.
> >> > + * @time_expr_ns: expression that evaluates to monotonic time (in ns) or,
> >> > + *  on failure, returns a negative value.
> >> > + * @timeout_ns: timeout value in ns
> >> > + * Both of the above are assumed to be compatible with s64; the signed
> >> > + * value is used to handle the failure case in @time_expr_ns.
> >> > + *
> >> > + * Equivalent to using READ_ONCE() on the condition variable.
> >> > + *
> >> > + * Callers that expect to wait for prolonged durations might want
> >> > + * to take into account the availability of ARCH_HAS_CPU_RELAX.
> >> > + *
> >> > + * Note that @ptr is expected to point to a memory address. Using this
> >> > + * interface with MMIO will be slower (since SMP_TIMEOUT_POLL_COUNT is
> >> > + * tuned for memory) and might also break in interesting architecture
> >> > + * dependent ways.
> >> > + */
> >> > +#ifndef smp_cond_load_relaxed_timeout
> >> > +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
> >> > +				      time_expr_ns, timeout_ns)		\
> >> > +({									\
> >> > +	typeof(ptr) __PTR = (ptr);					\

		auto __PTR = ptr;

> >> > +	__unqual_scalar_typeof(*ptr) VAL;				\

It can't matter if integer promotions before assigning to VAL.
So something like:
		auto VAL = 1 ? 0 : *__PTR + 0;
will generate a suitable writable variable.
(The '+ 0' is needed because some versions of gcc incorrectly propagate
'const'.)

> >> > +	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
> >> > +	s64 __timeout = (s64)timeout_ns;				\

The (s64) cast can only hide errors.

> >> > +	s64 __time_now, __time_end = 0;					\
> >> > +									\
> >> > +	for (;;) {							\
> >> > +		VAL = READ_ONCE(*__PTR);				\
> >> > +		if (cond_expr)						\
> >> > +			break;						\
> >> > +		cpu_poll_relax(__PTR, VAL, (u64)__timeout);		\

That doesn't look right, __timeout is relative; if the underlying code
uses the timeout then the code delays for 200 * timeout_ns before even
looking at the actual time.
If you want to spin then you may not even want the cpu_relax() at all.
(Or with a very short timeout as in the version below.)

> >> > +		if (++__n < __spin)					\
> >> > +			continue;					\
> >> > +		__time_now = (s64)(time_expr_ns);			\

Another cast that can only hide bugs.

> >> > +		if (unlikely(__time_end == 0))				\
> >> > +			__time_end = __time_now + __timeout;		\
> >> > +		__timeout = __time_end - __time_now;			\
> >> > +		if (__time_now <= 0 || __timeout <= 0) {		\
> >> > +			VAL = READ_ONCE(*__PTR);			\
> >> > +			break;						\
> >> > +		}							\
> >> > +		__n = 0;						\

Resetting the spin count doesn't look right at all.
In principle the code will delay for 200 * __timeout.
Possibly the earlier check should be:
			if (__n < __spin) {
				__n++;
				continue;
			}
(Or just don't worry that the code will spin again after 4M loops.
The problem you have is that if cpu_poll_relay() ignores the timeout you
probably want to spin 'for a bit' in code that only accesses local data
(in particular avoiding evaluating cond_expr or time_expr_ns).

> >> > +	}								\
> >> > +	(typeof(*ptr))VAL;						\

That cast is pointless; the return value will be subject to 'integer promotion'
and converted to a rvalue - which removes any const/volatile qualifiers. 

> >> > +})
> >> > +#endif
> >> > +  
> >>
> >> A cluster of issues that got flagged by sashiko was around timeout_ns
> >> being specified as s64 and a bunch of potential edge cases around
> >> that.
> >>
> >> These were mostly caused by an implicit assumption in the code that
> >> the timeout specified by the caller is generally reasonable. So, way
> >> below S64_MAX, not 0 etc.  
> >
> > There are plenty of ways kernel code can break things.
> > Provided this code doesn't itself overwrite anywhere (rather than
> > just loop forever or return immediately etc) I'd be tempted to
> > just document the valid range rather than slow everything down
> > with the extra tests.  
> 
> I don't disagree. In this case, however, it's somewhat borderline.
> 
> On the pro side, we get rid of some of the implicit type conversions
> and assumptions around those.
> 
> On the negative, it adds an extra modulo operation in the slow path.
> And, the for loop is structured a little differently from the usual
> version.
> 
> On balance, I think this is a good change if only because it makes
> the types a little more explicit.
> 
> Ankur
> 
> > 	David
> >  
> >>
> >> I think this is worth cleaning up a bit. The change is mostly around
> >> introducing a u32 __itertime and explicitly computing the waiting time.
> >> And adding a check to ensure that we start with a valid value.
> >>
> >> This does make the implementation a little more involved. So just wanted
> >> to see if people have any opinions on this?
> >>
> >> +#ifndef smp_cond_load_relaxed_timeout
> >> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,          \
> >> +                                     time_expr_ns, timeout_ns) \
> >> +({                                                             \
> >> +       typeof(ptr) __PTR = (ptr);                              \
> >> +       __unqual_scalar_typeof(*(ptr)) VAL;                     \
> >> +       u32 __count = 0, __spin = SMP_TIMEOUT_POLL_COUNT;       \
> >> +       s64 __timeout = (s64)(timeout_ns);                      \
> >> +       s64 __time_now, __time_end = 0;                         \
> >> +       u32 __maybe_unused __itertime;                          \
> >> +                                                               \
> >> +       for (__itertime = NSEC_PER_USEC;                        \

Ok, so that limits the initial 'spin' to 200 usecs.
That gets added to any caller-specified timeout.

> >> +               VAL = READ_ONCE(*__PTR), __timeout > 0; ) {     \

Broken indentation.
I'd change it back to a for (;;) loop.

If __timeout <= 0 then the code goes through the 'timer expired'
path (below) on the first iteration.
So the extra check is just bloat.

> >> +               if (cond_expr)                                  \
> >> +                       break;                                  \
> >> +               cpu_poll_relax(__PTR, VAL, __itertime);         \
> >> +               if (++__count < __spin)                         \
> >> +                       continue;                               \
> >> +               __time_now = (s64)(time_expr_ns);               \
> >> +               if (unlikely(__time_end == 0))                  \
> >> +                       __time_end = __time_now + __timeout;    \
> >> +               __timeout = __time_end - __time_now;            \
> >> +               if (__time_now <= 0 || __timeout <= 0) {        \
> >> +                       VAL = READ_ONCE(*__PTR);                \
> >> +                       break;                                  \
> >> +               }                                               \

How about:
			if (unlikely(__time_end == 0)) {
				if (__time_now <= 0)
					goto timed_out;
				__time_end = __time_now + __timeout;
			} else {
				if (__time_now >= __time_end) {
timed_out:
					VAL = READ_ONCE(*__PTR);
					break;
				}
				__timeout = __time_end - __time_now;
			}
				
> >> +               __itertime = __timeout % NSEC_PER_MSEC +        \
> >> +                               NSEC_PER_USEC;                  \

That seems to just be putting a bound on the timeout.
So the '% NSEC_PER_MSEC' could be '& ((1u << 20) - 1)'
replacing an expensive signed divide with a cheap mask.

But overall this is a lot of code to inline.
It has to be possible to get it down to something like:
	struct info info = { .tmo_ns = timeout_ns };
	for (;;) {
		VAL = READ_ONCE(PTR);
		if (cond_expr)
			break;
		if (_smp_cond_load_relaxed_timeout(&info, PTR, VAL))
			break;
	}
	VAL;
(yes, I know it isn't that simple because the arm 'relax' code
has a re-read in it so needs to know the size.)

-- David


> >> +               __count = 0;                                    \
> >> +       }                                                       \
> >> +       (typeof(*(ptr)))VAL;                                    \
> >> +})
> >> +#endif
> >>
> >> Thanks
> >>
> >> --
> >> ankur
> >>  
> 
> 
> --
> ankur
> 

