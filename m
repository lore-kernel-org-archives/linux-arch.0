Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F66936605D
	for <linux-arch@vger.kernel.org>; Fri,  8 May 2026 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778229134; cv=none; b=mZ2JmM5Rx+uxZFWr18H5anR235sMR9/1xgBkgzFQfspUgkS/LnSzQjj+0N0ztLDMhMu+j9r0WZlBeD4bxKOaFG4VZW/IX2D/SFB1tTYzSMfqX4DsooL1V1PgPRR3UFA+GiMetDLG7meDcOZXIdw6wg7GqO4X0haH3w0a0sTM65U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778229134; c=relaxed/simple;
	bh=WCiA+7utCacQFgzJ8tiXSHFYh0uUZ6mMktYRNgx1ZS4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8Uc28qtlYEOoGYkK7WHQe7wdpLtRao1k505l5ayhFewF3IveMSXXSiG9Nd2fAihWtvxU96OMGsl20sIC4qDiSdmwbsSdwacv/nXtfeP6mAC+wxUVTtOKIOAchvtbOBBT44rNhSnSB2cYArIToRGBz3VtfYGAIOKF1YGxyxL+lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NW1nVRxw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NW1nVRxw"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso17221415e9.2
        for <linux-arch@vger.kernel.org>; Fri, 08 May 2026 01:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778229131; x=1778833931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWwFa4pj4HdftCfFhlpM5f3biTFRHPg+OaCJzQMTcbM=;
        b=NW1nVRxw4euprXmY1ykOvrrxh+RMp8QCV6KICOOkPYRjPYU7uPHUQVPaVn4Q3T3Djx
         lWe/LWEebAqKQOc6BznQTPuYYhjJ81iDCT+CnqveUBNwDpGLpvEYOTSHKsJ6WcXenimV
         DVC4DMURdF5bRytNXTGhMxoJQbqfRu4aa0W71pYv1ZYRHZi88pEW81KDQto7VDD3vW8B
         mQ/c9WvxIvDQcF3o3PTtRBcmtUztEYejA8dJvfdc5fOoZ7CA1zBfBkdiWxJmCO6Shr5r
         s7zkVWJejxIN2wBQaI4LpbkPXwdr05W5Rxw9txEr5apmOoEhtM0c5CdxgN/LrzTpgmDk
         XJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778229131; x=1778833931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AWwFa4pj4HdftCfFhlpM5f3biTFRHPg+OaCJzQMTcbM=;
        b=OejJZPrHEhAbXSxkm3Xc859q2d+RCFBP1VuiJ2D0UCneyHmxv9salMFDuLAqbygOuw
         jJ/4qY+vzPr/6Ao97MoL3RU/DdYYDe0ikjEq9ndzAFQQ5aUtQzufFYq2eeefT2d5EOQw
         NoBWs9jbOsZW/I+4iMKAC+4nArflwbebIkNiauhU3TWEt6OWMdKdP/uJ8xzig8rpclT+
         Zac+pe+HJR6owyx2c54lzS5EVLbKDGtwc1p8t5VlIEzw+rXhS3zRCFZzXH/yniGJ8dRp
         MB7Esv+CZcMNcpqnAEljExnBbZzr0BTT7gi607LJ+HjMHQVONhgUHr1p+rnPHjlfPLLd
         XOzw==
X-Forwarded-Encrypted: i=1; AFNElJ9NPcUUVpDu09jh4jvbTGOxxA4iN9pIDVoga55NlIWeGbuXjvCfhULsg3bGPoMt1uIFHZhtKSdrOyhc@vger.kernel.org
X-Gm-Message-State: AOJu0YyrLNIMbwEEkZcT/RovSzgdVf6T6ulCBlwF6oZ6mwtgLbv0X8vA
	Ncoy+gyEf51KjN8e5Mb6dmbkb68j21g5chXFwkgYO5A6eYh3vsKg0VxF
X-Gm-Gg: AeBDietb193Hx7W477I8g6Osh60HSdIZR7xKgOAwzwaA8r+oYhzAZfUCTqgC4Ph856O
	1fKW+S1Pk//aRZuigO2xCDh4jFkdhnmgOEm/bBYaOBhH6tNA4fl+USjrnGgLBbl2oQfyFfdqqZo
	1Co1kzdVIrKsml1+zjCnJcSqNg5olH7kR69hpAug2T0WnInKsdUQmugtzVXon+g8OWc2QDWll6Q
	zJd0lATtxxOEy9iR8ADWhfzJj8ujSlLwZTnVgHM4xZ/QppA/JNEUtxwjkPTCeWyzl8s3sv+RCTT
	nH1pZcSwu462yFbnAqF9VcRDKiMNDNLLLcyaP5GFwyT02iad5GL7/q47LeYWYR1lIP1yEaS92ae
	cWHjFZ6iMh51Rcfw/T9oDtb1/VNU2EjmEE8m1KOigaxZppBspVoOUWw/c1GMoqwpIvXtJdrKhKY
	LZT3ue8MX3vRsi0xfYftqXyB9cfpYuS9ACRzqBkMobLP7yoVTQVlBh2xpo22NBCbxg
X-Received: by 2002:a05:600c:1d11:b0:48a:7f90:2231 with SMTP id 5b1f17b1804b1-48e51f364f3mr189545395e9.19.1778229129820;
        Fri, 08 May 2026 01:32:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68ef5209sm20514445e9.15.2026.05.08.01.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 01:32:08 -0700 (PDT)
Date: Fri, 8 May 2026 09:32:06 +0100
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
Message-ID: <20260508093206.389d9af2@pumpkin>
In-Reply-To: <87lddujttz.fsf@oracle.com>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
	<20260408122538.3610871-2-ankur.a.arora@oracle.com>
	<874iklm1uy.fsf@oracle.com>
	<20260506095836.216d9cc5@pumpkin>
	<87o6isl0nl.fsf@oracle.com>
	<20260507105721.66ba1e45@pumpkin>
	<87lddujttz.fsf@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 07 May 2026 23:31:20 -0700
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> David Laight <david.laight.linux@gmail.com> writes:
> 
> > On Wed, 06 May 2026 13:54:06 -0700
> > Ankur Arora <ankur.a.arora@oracle.com> wrote:
> >  
> >> David Laight <david.laight.linux@gmail.com> writes:
> >>  
> >> > On Wed, 06 May 2026 00:30:29 -0700
> >> > Ankur Arora <ankur.a.arora@oracle.com> wrote:
> >> >  
> >> >> Ankur Arora <ankur.a.arora@oracle.com> writes:
> >> >>  
> >> >> > Add smp_cond_load_relaxed_timeout(), which extends
> >> >> > smp_cond_load_relaxed() to allow waiting for a duration.
> >> >> >
> >> >> > We loop around waiting for the condition variable to change while
> >> >> > peridically doing a time-check. The loop uses cpu_poll_relax() to slow
> >> >> > down the busy-wait, which, unless overridden by the architecture
> >> >> > code, amounts to a cpu_relax().
> >> >> >
> >> >> > Note that there are two ways for the time-check to fail: the timeout
> >> >> > case or, @time_expr_ns returning an invalid value (negative or zero).
> >> >> > The second failure mode allows for clocks attached to the clock-domain
> >> >> > of @cond_expr --  which might cease to operate meaningfully once some
> >> >> > state internal to @cond_expr has changed -- to fail.
> >> >> >
> >> >> > Evaluation of @time_expr_ns: in the fastpath we want to keep the
> >> >> > performance close to smp_cond_load_relaxed(). So defer evaluation
> >> >> > of the potentially costly @time_expr_ns to the slowpath.
> >> >> >
> >> >> > This also means that there will always be some hardware dependent
> >> >> > duration that has passed in cpu_poll_relax() iterations at the time
> >> >> > of first evaluation. Additionally cpu_poll_relax() is not guaranteed
> >> >> > to return at timeout boundary. In sum, expect timeout overshoot when
> >> >> > we exit due to expiration of the timeout.
> >> >> >
> >> >> > The number of spin iterations before time-check, SMP_TIMEOUT_POLL_COUNT
> >> >> > is chosen to be 200 by default. With a cpu_poll_relax() iteration
> >> >> > taking ~20-30 cycles (measured on a variety of x86 platforms), we
> >> >> > expect a time-check every ~4000-6000 cycles.
> >> >> >
> >> >> > The outer limit of the overshoot is double that when working with the
> >> >> > parameters above. This might be higher or lower depending on the
> >> >> > implementation of cpu_poll_relax() across architectures.
> >> >> >
> >> >> > Lastly, config option ARCH_HAS_CPU_RELAX indicates availability of a
> >> >> > cpu_poll_relax() that is cheaper than polling. This might be relevant
> >> >> > for cases with a long timeout.
> >> >> >
> >> >> > Cc: Arnd Bergmann <arnd@arndb.de>
> >> >> > Cc: Will Deacon <will@kernel.org>
> >> >> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> >> > Cc: Peter Zijlstra <peterz@infradead.org>
> >> >> > Cc: linux-arch@vger.kernel.org
> >> >> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> >> >> > Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> >> >> > ---
> >> >> > Notes:
> >> >> >    - add a comment mentioning that smp_cond_load_relaxed_timeout() might
> >> >> >      be using architectural primitives that don't support MMIO.
> >> >> >      (David Laight, Catalin Marinas)
> >> >> >
> >> >> >  include/asm-generic/barrier.h | 69 +++++++++++++++++++++++++++++++++++
> >> >> >  1 file changed, 69 insertions(+)
> >> >> >
> >> >> > diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> >> >> > index d4f581c1e21d..e5a6a1c04649 100644
> >> >> > --- a/include/asm-generic/barrier.h
> >> >> > +++ b/include/asm-generic/barrier.h
> >> >> > @@ -273,6 +273,75 @@ do {									\
> >> >> >  })
> >> >> >  #endif
> >> >> >
> >> >> > +/*
> >> >> > + * Number of times we iterate in the loop before doing the time check.
> >> >> > + * Note that the iteration count assumes that the loop condition is
> >> >> > + * relatively cheap.
> >> >> > + */
> >> >> > +#ifndef SMP_TIMEOUT_POLL_COUNT
> >> >> > +#define SMP_TIMEOUT_POLL_COUNT		200
> >> >> > +#endif
> >> >> > +
> >> >> > +/*
> >> >> > + * Platforms with ARCH_HAS_CPU_RELAX have a cpu_poll_relax() implementation
> >> >> > + * that is expected to be cheaper (lower power) than pure polling.
> >> >> > + */
> >> >> > +#ifndef cpu_poll_relax
> >> >> > +#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
> >> >> > +#endif
> >> >> > +
> >> >> > +/**
> >> >> > + * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
> >> >> > + * guarantees until a timeout expires.
> >> >> > + * @ptr: pointer to the variable to wait on.
> >> >> > + * @cond_expr: boolean expression to wait for.
> >> >> > + * @time_expr_ns: expression that evaluates to monotonic time (in ns) or,
> >> >> > + *  on failure, returns a negative value.
> >> >> > + * @timeout_ns: timeout value in ns
> >> >> > + * Both of the above are assumed to be compatible with s64; the signed
> >> >> > + * value is used to handle the failure case in @time_expr_ns.
> >> >> > + *
> >> >> > + * Equivalent to using READ_ONCE() on the condition variable.
> >> >> > + *
> >> >> > + * Callers that expect to wait for prolonged durations might want
> >> >> > + * to take into account the availability of ARCH_HAS_CPU_RELAX.
> >> >> > + *
> >> >> > + * Note that @ptr is expected to point to a memory address. Using this
> >> >> > + * interface with MMIO will be slower (since SMP_TIMEOUT_POLL_COUNT is
> >> >> > + * tuned for memory) and might also break in interesting architecture
> >> >> > + * dependent ways.
> >> >> > + */
> >> >> > +#ifndef smp_cond_load_relaxed_timeout
> >> >> > +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
> >> >> > +				      time_expr_ns, timeout_ns)		\
> >> >> > +({									\
> >> >> > +	typeof(ptr) __PTR = (ptr);					\  
> >
> > 		auto __PTR = ptr;
> >  
> >> >> > +	__unqual_scalar_typeof(*ptr) VAL;				\  
> >
> > It can't matter if integer promotions before assigning to VAL.
> > So something like:
> > 		auto VAL = 1 ? 0 : *__PTR + 0;
> > will generate a suitable writable variable.
> > (The '+ 0' is needed because some versions of gcc incorrectly propagate
> > 'const'.)  
> 
> Thanks. This is useful to know. However, we use the unqualified typeof
> dictum all over barrier.h. I didn't really see the need to depart from
> that.

The have been discussions in other threads, my interpretation of the result
is that the use of __unqual_scalar_typeof() should be limited to a few places
where there really is no other option.
If you've ever looked at the preprocessor output you'll understand part of the
problem.

> 
> >> >> > +	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
> >> >> > +	s64 __timeout = (s64)timeout_ns;				\  
> >
> > The (s64) cast can only hide errors.
> >  
> >> >> > +	s64 __time_now, __time_end = 0;					\
> >> >> > +									\
> >> >> > +	for (;;) {							\
> >> >> > +		VAL = READ_ONCE(*__PTR);				\
> >> >> > +		if (cond_expr)						\
> >> >> > +			break;						\
> >> >> > +		cpu_poll_relax(__PTR, VAL, (u64)__timeout);		\  
> >
> > That doesn't look right, __timeout is relative; if the underlying code
> > uses the timeout then the code delays for 200 * timeout_ns before even
> > looking at the actual time.
> >
> > If you want to spin then you may not even want the cpu_relax() at all.
> > (Or with a very short timeout as in the version below.)  
> 
> Yeah, BPF uses this in the fastpath where we want to avoid looking at
> the clock in the fastpath.
> Overshooting the deadline was a minor problem in comparison.
> 
> But I agree the version below with the shorter timeout works better.
> Unfortunately it doesn't help on arm64 if we are using WFE.

Yes, the code is ok if cpu_poll_relax() ignores the timeout.
But for WFE it is all broken.

Perhaps refactoring/optimising the WFE code might help.
IIRC it converts the relative timeout_ns into an absolute 'end time'
(of some other clock).
So if you do that conversion once, returning 0 (usually compile-time)
when WFE isn't in use then it should be possible to make this code work.

Actually, if you assume/require that the converted time is either 0 or
greater than 200 then it can be used as the initialiser for __n.

Even if the timeout passed to cpu_poll_relax() is relative, it doesn't
necessarily need reducing.
I'd expect that the timeout is only a 'guard' timeout to detect lockups.
So just documenting that the timeout might be double the specified value
would solve that problem.

> 
> >> >> > +		if (++__n < __spin)					\
> >> >> > +			continue;					\
> >> >> > +		__time_now = (s64)(time_expr_ns);			\  
> >
> > Another cast that can only hide bugs.
> >  
> >> >> > +		if (unlikely(__time_end == 0))				\
> >> >> > +			__time_end = __time_now + __timeout;		\
> >> >> > +		__timeout = __time_end - __time_now;			\
> >> >> > +		if (__time_now <= 0 || __timeout <= 0) {		\
> >> >> > +			VAL = READ_ONCE(*__PTR);			\
> >> >> > +			break;						\
> >> >> > +		}							\
> >> >> > +		__n = 0;						\  
> >
> > Resetting the spin count doesn't look right at all.
> > In principle the code will delay for 200 * __timeout.
> > Possibly the earlier check should be:
> > 			if (__n < __spin) {
> > 				__n++;
> > 				continue;
> > 			}
> > (Or just don't worry that the code will spin again after 4M loops.
> > The problem you have is that if cpu_poll_relay() ignores the timeout you
> > probably want to spin 'for a bit' in code that only accesses local data
> > (in particular avoiding evaluating cond_expr or time_expr_ns).  
> 
> Yeah we do avoid evaluating the time_expr_ns. And I agree we don't want
> to hammer the cond_expr but the cpu_relax() should help with that.
> (In my measurements I see an IPC of ~0.05 in a cpu_relax() loop of this
> kind.)

I'm not sure what cpu_relax() really does.
I suspect it helps if hyperthreading is in use, and may reduce power a bit
(and may be quite slow).
But the cpu will still be hammering cond_expr.
This is probably fine most of the time - since it will just hit the local
d-cache. Even if the line is evicted I'd expect the cost to mainly be load
on the inter-cpu bus (slowing down cond_expr won't matter).

I have a feeling that one of the reasons that WFE was better than just
spinning was that the expressions read a per-cpu variable; and doing that
on arm64 required locked bus cycles so affected system performance.
I'm sure that using mwait (or equivalent) will almost always increase latency
over just reading the variable, it is lower power - but that is different.

...

> >> >> I think this is worth cleaning up a bit. The change is mostly around
> >> >> introducing a u32 __itertime and explicitly computing the waiting time.
> >> >> And adding a check to ensure that we start with a valid value.
> >> >>
> >> >> This does make the implementation a little more involved. So just wanted
> >> >> to see if people have any opinions on this?
> >> >>
> >> >> +#ifndef smp_cond_load_relaxed_timeout
> >> >> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,          \
> >> >> +                                     time_expr_ns, timeout_ns) \
> >> >> +({                                                             \
> >> >> +       typeof(ptr) __PTR = (ptr);                              \
> >> >> +       __unqual_scalar_typeof(*(ptr)) VAL;                     \
> >> >> +       u32 __count = 0, __spin = SMP_TIMEOUT_POLL_COUNT;       \
> >> >> +       s64 __timeout = (s64)(timeout_ns);                      \
> >> >> +       s64 __time_now, __time_end = 0;                         \
> >> >> +       u32 __maybe_unused __itertime;                          \
> >> >> +                                                               \
> >> >> +       for (__itertime = NSEC_PER_USEC;                        \  
> >
> > Ok, so that limits the initial 'spin' to 200 usecs.
> > That gets added to any caller-specified timeout.
> >  
> >> >> +               VAL = READ_ONCE(*__PTR), __timeout > 0; ) {     \  
> >
> > Broken indentation.
> > I'd change it back to a for (;;) loop.
> >
> > If __timeout <= 0 then the code goes through the 'timer expired'
> > path (below) on the first iteration.
> > So the extra check is just bloat.  
> 
> Yes, but by the time of the first check we've done this
> computation with it:
> >> >> +               if (unlikely(__time_end == 0))                  \
> >> >> +                       __time_end = __time_now + __timeout;    \
> >> >> +               __timeout = __time_end - __time_now;            \  

Yep, but you don't expect 0 so there is no point optimising for it.

> >> >> +               if (cond_expr)                                  \
> >> >> +                       break;                                  \
> >> >> +               cpu_poll_relax(__PTR, VAL, __itertime);         \
> >> >> +               if (++__count < __spin)                         \
> >> >> +                       continue;                               \
> >> >> +               __time_now = (s64)(time_expr_ns);               \
> >> >> +               if (unlikely(__time_end == 0))                  \
> >> >> +                       __time_end = __time_now + __timeout;    \
> >> >> +               __timeout = __time_end - __time_now;            \
> >> >> +               if (__time_now <= 0 || __timeout <= 0) {        \
> >> >> +                       VAL = READ_ONCE(*__PTR);                \
> >> >> +                       break;                                  \
> >> >> +               }                                               \  
> >
> > How about:
> > 			if (unlikely(__time_end == 0)) {
> > 				if (__time_now <= 0)
> > 					goto timed_out;
> > 				__time_end = __time_now + __timeout;
> > 			} else {
> > 				if (__time_now >= __time_end) {
> > timed_out:
> > 					VAL = READ_ONCE(*__PTR);
> > 					break;
> > 				}
> > 				__timeout = __time_end - __time_now;
> > 			}  
> 
> I had a version like that for one of the iterations. One of the problems
> with it was that needed a named goto (because the whole thing is wrapped
> in a macro). I don't tihnk the extra check is expensive enough in the
> slowpath that it's worth rewriting this code.

It is probably possible to write it all in one condition - but it would
be unreadable :-)

Actually if you require that time_expr_ns be -1 on failure and use u64
(not s64) then you can do:
	if (!__time_end)
		__time_end = __time_now + __timeout;
	if (__time_now >= __time_end) {
		VAL = READ_ONCE(*__PTR);
		break;
	}
That relies on the '+' wrapping when the initial time_expr_ns fails.

> 
> >> >> +               __itertime = __timeout % NSEC_PER_MSEC +        \
> >> >> +                               NSEC_PER_USEC;                  \  
> >
> > That seems to just be putting a bound on the timeout.
> > So the '% NSEC_PER_MSEC' could be '& ((1u << 20) - 1)'
> > replacing an expensive signed divide with a cheap mask.  
> 
> I think this is a good idea. Let me do something like that instead.
> 
> > But overall this is a lot of code to inline.  
> 
> Sure. But it's a small number of callsites (and it's a relatively niche
> interface) so I don't think inlining it is a huge problem.

Until 'next week' :-)

	David
