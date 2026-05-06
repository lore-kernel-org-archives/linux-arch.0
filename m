Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07CB3EDAAD
	for <linux-arch@vger.kernel.org>; Wed,  6 May 2026 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778057924; cv=none; b=iqMbuBg50AakEPoW6tkB+OTJWiJfRyvJ1ko01VQanKRMPYoiW7aMKGE7kRwUrFyHc5H4rzlGGhBwm85gWdazqe5N6XL6OtmWt+RF6ehtQN1WlspqekjdsBQzezmtj46FLEvzOCtmmCpiatKUwKbl41Pkprs0Xo7WPDBiDT6TI+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778057924; c=relaxed/simple;
	bh=eD+Yz7GzQtMbbGfGGTFutD9Fa1k6iUTPX/y/AAqXEfI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TajMZxTJU+PVih/CqaeP4DmOupAWNAXOMTTNKQ84TWEhBn/b/212UoO2qojl4qOVlu5JyVQMevwTDKzRjs+AQzRBDKaF8sFoLzPCdPz4dBcZp+/F+MHqwMTgC8PxsGYhh284ZhUOljY7o7FCZJgqjKTqUogPZXAUEUI4SL+mSSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1R5A6j1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1R5A6j1"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b0046078so53695245e9.1
        for <linux-arch@vger.kernel.org>; Wed, 06 May 2026 01:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778057918; x=1778662718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhzB8ETmB1Gn6S1MA51/Lwkn0HDnlQZbCh2CXttfCBk=;
        b=N1R5A6j1KHqEnuDzehRV6x+CkZA0wfw4LWwjh5newBX0VQKGkpuvZGxFkaP0+33IyO
         d1swmpE/ROmeIEi3Y3p2mkIVM9RF9j7Q17sqOdkKDMcRFL7MqScv6SszLF6K+IX0zcxG
         WCCiawKpINnNY9phFqnNtxm6jikCx3IptBLI8ntluz1RRyzOvmezphYb2SbONwSj3dpz
         fAkD5Xc3uTaz29UELJnjA+n3B53lpg+YhP+I3pHczprCvGkmb67tS+q1UAShLaWGDa5k
         68sFn6Mt1/Jw7Kpj2ssU3xGhMCwysaDAF/ztDoEwzCUYadBxGZsN5NMRTYe5K4Og6+RU
         5y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778057918; x=1778662718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EhzB8ETmB1Gn6S1MA51/Lwkn0HDnlQZbCh2CXttfCBk=;
        b=fSAGF0koE/ZBYU2zIzhFwBH1TzXWer7Gfa8rRpa0X+LhZV50x0Zyv8zJXp1waf6Hnq
         YdjQ5vHbEeHlzk1HnbWUFJcHKW8EGhSjcBU5Ff32vgUz4se1J4e2nXeldNU55m+ckLDs
         ocpg9K4dlKjKZbQVWAaG9vBWAIypdipVQwv1CSoDKGk1evZoVsYx75OwD6fziAT+1sN8
         O9bn9Yd9G/HUOq78fhFwXBQjQeb931tL/6ZOM3P6r9WFYP82spyJg+tSAnGUXiYdy0nr
         2aJYlVsegQau3rds1M6lXK/m9NtezOVBpB8/8w+uzxbjHXkku6fITEHRkla1A/yItMDh
         j77A==
X-Forwarded-Encrypted: i=1; AFNElJ85MbjkEiOH1elN7MlgOCg9hwX5Gn9QvDfa7C3fU07i2jeTeRo6jALLQ3gxs1PQxmfIt632om3ihmbY@vger.kernel.org
X-Gm-Message-State: AOJu0YzzGuvmuYz7NLwFrOOBV88HEfePHvg9QUtnz3oPSN8FAHtbnBeC
	IGfUY80js6qW8z5FQ5SE/JQJCbgrZmo4cyg6WW9iN0/CU96AOA0QYY8E
X-Gm-Gg: AeBDiessCrH/zH2i5j9J2gkQ0jMfpuY2ClKSa8Tv36puf4HvWWET2YjGqxE1wJ04A9b
	JzpY3W2zIjIxh7KjLszjW5s1/yc6GiomYW9wRAjXkBzJg/vtnfCwiksr9PMlT4vrO8+8rXzFyCz
	p8UHZCfXGtGad2ptTeXa62v1Dprj1PDeg7uPlUe2fkHo8T8HiZ1PYWYlUUlqZ58mJKFw/exfkie
	vOLxNITcPlQeoYDbzyOj85CsNtwBRwAtjRmOI8jMyfM0LqjC5YBd4LdSMj/9WDDrpl6qxRfLD1r
	xYAEkIaESW5aH2YF+DSzB29NcULoibfwZSyBbHwgIM33RD8lERhNi81sXdZtvYnN1mjf+qi1xwN
	U8uL6dAbLkC8iTttClbp+LvSu1XmDkq/oDUe9ovGWEKMG5uQzPCBlfhLgHFDFrSiu/HV5mKrSJL
	25bDpwZE4WAYRLKxiRx31Fux1tacoNvOyRBK+syXRiTyYa0WqUvxbesVI9ESqwE+uLZZBt/cv2L
	hA=
X-Received: by 2002:a05:600d:6:b0:48a:8905:a500 with SMTP id 5b1f17b1804b1-48e51f1d04bmr31640885e9.12.1778057917950;
        Wed, 06 May 2026 01:58:37 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a50d0sm55769975e9.5.2026.05.06.01.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 01:58:37 -0700 (PDT)
Date: Wed, 6 May 2026 09:58:36 +0100
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
Message-ID: <20260506095836.216d9cc5@pumpkin>
In-Reply-To: <874iklm1uy.fsf@oracle.com>
References: <20260408122538.3610871-1-ankur.a.arora@oracle.com>
	<20260408122538.3610871-2-ankur.a.arora@oracle.com>
	<874iklm1uy.fsf@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 06 May 2026 00:30:29 -0700
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> Ankur Arora <ankur.a.arora@oracle.com> writes:
> 
> > Add smp_cond_load_relaxed_timeout(), which extends
> > smp_cond_load_relaxed() to allow waiting for a duration.
> >
> > We loop around waiting for the condition variable to change while
> > peridically doing a time-check. The loop uses cpu_poll_relax() to slow
> > down the busy-wait, which, unless overridden by the architecture
> > code, amounts to a cpu_relax().
> >
> > Note that there are two ways for the time-check to fail: the timeout
> > case or, @time_expr_ns returning an invalid value (negative or zero).
> > The second failure mode allows for clocks attached to the clock-domain
> > of @cond_expr --  which might cease to operate meaningfully once some
> > state internal to @cond_expr has changed -- to fail.
> >
> > Evaluation of @time_expr_ns: in the fastpath we want to keep the
> > performance close to smp_cond_load_relaxed(). So defer evaluation
> > of the potentially costly @time_expr_ns to the slowpath.
> >
> > This also means that there will always be some hardware dependent
> > duration that has passed in cpu_poll_relax() iterations at the time
> > of first evaluation. Additionally cpu_poll_relax() is not guaranteed
> > to return at timeout boundary. In sum, expect timeout overshoot when
> > we exit due to expiration of the timeout.
> >
> > The number of spin iterations before time-check, SMP_TIMEOUT_POLL_COUNT
> > is chosen to be 200 by default. With a cpu_poll_relax() iteration
> > taking ~20-30 cycles (measured on a variety of x86 platforms), we
> > expect a time-check every ~4000-6000 cycles.
> >
> > The outer limit of the overshoot is double that when working with the
> > parameters above. This might be higher or lower depending on the
> > implementation of cpu_poll_relax() across architectures.
> >
> > Lastly, config option ARCH_HAS_CPU_RELAX indicates availability of a
> > cpu_poll_relax() that is cheaper than polling. This might be relevant
> > for cases with a long timeout.
> >
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: linux-arch@vger.kernel.org
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> > ---
> > Notes:
> >    - add a comment mentioning that smp_cond_load_relaxed_timeout() might
> >      be using architectural primitives that don't support MMIO.
> >      (David Laight, Catalin Marinas)
> >
> >  include/asm-generic/barrier.h | 69 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> >
> > diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> > index d4f581c1e21d..e5a6a1c04649 100644
> > --- a/include/asm-generic/barrier.h
> > +++ b/include/asm-generic/barrier.h
> > @@ -273,6 +273,75 @@ do {									\
> >  })
> >  #endif
> >
> > +/*
> > + * Number of times we iterate in the loop before doing the time check.
> > + * Note that the iteration count assumes that the loop condition is
> > + * relatively cheap.
> > + */
> > +#ifndef SMP_TIMEOUT_POLL_COUNT
> > +#define SMP_TIMEOUT_POLL_COUNT		200
> > +#endif
> > +
> > +/*
> > + * Platforms with ARCH_HAS_CPU_RELAX have a cpu_poll_relax() implementation
> > + * that is expected to be cheaper (lower power) than pure polling.
> > + */
> > +#ifndef cpu_poll_relax
> > +#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
> > +#endif
> > +
> > +/**
> > + * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
> > + * guarantees until a timeout expires.
> > + * @ptr: pointer to the variable to wait on.
> > + * @cond_expr: boolean expression to wait for.
> > + * @time_expr_ns: expression that evaluates to monotonic time (in ns) or,
> > + *  on failure, returns a negative value.
> > + * @timeout_ns: timeout value in ns
> > + * Both of the above are assumed to be compatible with s64; the signed
> > + * value is used to handle the failure case in @time_expr_ns.
> > + *
> > + * Equivalent to using READ_ONCE() on the condition variable.
> > + *
> > + * Callers that expect to wait for prolonged durations might want
> > + * to take into account the availability of ARCH_HAS_CPU_RELAX.
> > + *
> > + * Note that @ptr is expected to point to a memory address. Using this
> > + * interface with MMIO will be slower (since SMP_TIMEOUT_POLL_COUNT is
> > + * tuned for memory) and might also break in interesting architecture
> > + * dependent ways.
> > + */
> > +#ifndef smp_cond_load_relaxed_timeout
> > +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
> > +				      time_expr_ns, timeout_ns)		\
> > +({									\
> > +	typeof(ptr) __PTR = (ptr);					\
> > +	__unqual_scalar_typeof(*ptr) VAL;				\
> > +	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
> > +	s64 __timeout = (s64)timeout_ns;				\
> > +	s64 __time_now, __time_end = 0;					\
> > +									\
> > +	for (;;) {							\
> > +		VAL = READ_ONCE(*__PTR);				\
> > +		if (cond_expr)						\
> > +			break;						\
> > +		cpu_poll_relax(__PTR, VAL, (u64)__timeout);		\
> > +		if (++__n < __spin)					\
> > +			continue;					\
> > +		__time_now = (s64)(time_expr_ns);			\
> > +		if (unlikely(__time_end == 0))				\
> > +			__time_end = __time_now + __timeout;		\
> > +		__timeout = __time_end - __time_now;			\
> > +		if (__time_now <= 0 || __timeout <= 0) {		\
> > +			VAL = READ_ONCE(*__PTR);			\
> > +			break;						\
> > +		}							\
> > +		__n = 0;						\
> > +	}								\
> > +	(typeof(*ptr))VAL;						\
> > +})
> > +#endif
> > +  
> 
> A cluster of issues that got flagged by sashiko was around timeout_ns
> being specified as s64 and a bunch of potential edge cases around
> that.
> 
> These were mostly caused by an implicit assumption in the code that
> the timeout specified by the caller is generally reasonable. So, way
> below S64_MAX, not 0 etc.

There are plenty of ways kernel code can break things.
Provided this code doesn't itself overwrite anywhere (rather than
just loop forever or return immediately etc) I'd be tempted to
just document the valid range rather than slow everything down
with the extra tests.

	David

> 
> I think this is worth cleaning up a bit. The change is mostly around
> introducing a u32 __itertime and explicitly computing the waiting time.
> And adding a check to ensure that we start with a valid value.
> 
> This does make the implementation a little more involved. So just wanted
> to see if people have any opinions on this?
> 
> +#ifndef smp_cond_load_relaxed_timeout
> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,          \
> +                                     time_expr_ns, timeout_ns) \
> +({                                                             \
> +       typeof(ptr) __PTR = (ptr);                              \
> +       __unqual_scalar_typeof(*(ptr)) VAL;                     \
> +       u32 __count = 0, __spin = SMP_TIMEOUT_POLL_COUNT;       \
> +       s64 __timeout = (s64)(timeout_ns);                      \
> +       s64 __time_now, __time_end = 0;                         \
> +       u32 __maybe_unused __itertime;                          \
> +                                                               \
> +       for (__itertime = NSEC_PER_USEC;                        \
> +               VAL = READ_ONCE(*__PTR), __timeout > 0; ) {     \
> +               if (cond_expr)                                  \
> +                       break;                                  \
> +               cpu_poll_relax(__PTR, VAL, __itertime);         \
> +               if (++__count < __spin)                         \
> +                       continue;                               \
> +               __time_now = (s64)(time_expr_ns);               \
> +               if (unlikely(__time_end == 0))                  \
> +                       __time_end = __time_now + __timeout;    \
> +               __timeout = __time_end - __time_now;            \
> +               if (__time_now <= 0 || __timeout <= 0) {        \
> +                       VAL = READ_ONCE(*__PTR);                \
> +                       break;                                  \
> +               }                                               \
> +               __itertime = __timeout % NSEC_PER_MSEC +        \
> +                               NSEC_PER_USEC;                  \
> +               __count = 0;                                    \
> +       }                                                       \
> +       (typeof(*(ptr)))VAL;                                    \
> +})
> +#endif
> 
> Thanks
> 
> --
> ankur
> 

