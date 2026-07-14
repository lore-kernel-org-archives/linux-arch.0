Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7D03F927A;
	Tue, 14 Jul 2026 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016705; cv=none; b=sk+3ouYiacv23iWaBAfMukRDWKBPTfdrgzJZHZu8LhEyMZVAAv75XxcESnxcGMIcYwPD7jm0sfz1Q6O5v29wSQernCzNghYICdDdmZrwUWJ5OotdY+Yfh+8awYof7kyreMZTxf514tNZpOnqWZFrheI6XAJPa5JZnjvuaXRo8GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016705; c=relaxed/simple;
	bh=OZ1pbYKy2gk2DM0PoKB4jHWQTmuvMzB90+kMG0b5jzs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=f4nkrElaoy4oj8WY1kmH+N3A5+/6aZEQeIL02X/o60zGx7HK86EVfqE7rgNdMJrpkRB2+qE9uyUbbUrEADMiQB2ELwWOTPPTCUBU39gRYeLv4yqXxyhE/bR0vZ4S5tXADIQN7+G9RUE6r8q9H3A85CLvy/tEMGNGxzrOuhtKh+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKwuxLHG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKwuxLHG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2091F000E9;
	Tue, 14 Jul 2026 08:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784016702;
	bh=Tl4h+221L/w6NzOfKKil7MwlTgDffDNAmIy67lN545c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nKwuxLHGUNYZSrccadSo3REBtphiZsLibg7xJIuWEiGXolX0HG5rtmmL5eFrSu6A/
	 d8qeDobSrFiUHSBlcW1pU9YSoKlRyV75e7MKW7Hx5Oi7/O9cbnAl/+Y0vJdTYjqEDs
	 ZPZUhdWHkR4Hjd41raW9n8HUWvVCF/YlF0BW3G092Wlbnad3/dbyfdESHhM2pfyFZ+
	 WqNJkZf1etuhrvTrPGAD+hSI6qhD0CqQmyUIleGMse+4t8XTsNHqDynzMjkYPG3vKY
	 NpHmsX5euPQD0r7DAdmFiwmbiA6ThvQs5d/oQKLMLnYQo2dZvqciNjXZTY0938s7Fv
	 G80ftPN+eOSeA==
Content-Type: multipart/mixed; boundary="===============2756016215755141306=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4ef45450ea43d0a7932e003ca291e9ec4cc2642102b7d8116d4c8f241f67a9c0@mail.kernel.org>
In-Reply-To: <20260714073041.40250-2-ankur.a.arora@oracle.com>
References: <20260714073041.40250-2-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v14 01/15] asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@linaro.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,rdunlap@infradead.org,david.laight.linux@gmail.com,broonie@kernel.org,joao.m.martins@oracle.com,boris.ostrovsky@oracle.com,konrad.wilk@oracle.com,ashok.bhat@arm.com,ankur.a.arora@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 14 Jul 2026 08:11:41 +0000 (UTC)

--===============2756016215755141306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index b99cb57dfccc..d1e9ed15bbfc 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -273,6 +273,85 @@ do {									\
>  })
>  #endif
>
> +/*
> + * Number of times we iterate in the loop before doing the time check.
> + * Note that the iteration count assumes that the loop condition is
> + * relatively cheap.
> + */
> +#ifndef SMP_TIMEOUT_POLL_COUNT
> +#define SMP_TIMEOUT_POLL_COUNT		200
> +#endif
> +
> +/*
> + * cpu_poll_relax() stitches up two kinds of primitives: ones that provide
> + * a momentary blip in the pipeline (ex. cpu_relax() on x86).
> + * The second support waiting for @ptr value to change, coupled with a
> + * with a precise (or imprecise) timeout.

This isn't a bug, but could this sentence be tightened?  The phrase
"with a" is repeated across the line wrap, and "The second support"
reads a little off, e.g. "The second kind supports waiting for @ptr to
change, coupled with a (precise or imprecise) timeout".

> + *
> + * cpu_poll_relax() keeps them together, because its utility is in minimizing
> + * expensive operations while polling on @ptr waiting for it to change.
> + * The arguments to cpu_poll_relax() are only needed for the waiting
> + * primitives.
> + *
> + * Also note that platforms with a suitable cpu_poll_relax() are expected
> + * to define ARCH_HAS_CPU_RELAX.
> + */
> +#ifndef cpu_poll_relax
> +#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
> +#endif
> +

[ ... ]

> +#ifndef smp_cond_load_relaxed_timeout
> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
> +				      time_expr_ns, timeout_ns)		\
> +({									\
> +	typeof(ptr) __PTR = (ptr);					\
> +	__unqual_scalar_typeof(*(ptr)) VAL;				\
> +	u32 __count = 0, __spin = SMP_TIMEOUT_POLL_COUNT;		\
> +	s64 __timeout = (s64)timeout_ns;				\
> +	s64 __time_now, __time_end = 0;					\
> +									\
> +	for (;;) {							\
> +		VAL = READ_ONCE(*__PTR);				\
> +		if (cond_expr)						\
> +			break;						\
> +		cpu_poll_relax(__PTR, VAL, (u64)__timeout);		\
> +		if (++__count < __spin)					\
> +			continue;					\

The loop passes the full relative __timeout to cpu_poll_relax() on every
iteration and resets __count to 0 each cycle after the time-check.

For the asm-generic default this is harmless, since cpu_poll_relax()
expands to cpu_relax() and ignores its arguments.

But for an event-based wait that honours the timeout argument (for
example an arm64 WFE override), wouldn't each of the
SMP_TIMEOUT_POLL_COUNT iterations be allowed to block for up to the
entire remaining __timeout before the next time-check, delaying the
check and causing large overshoot?

This came up in review of an earlier version, where the suggestion was
to pass a bounded per-iteration timeout rather than the full remaining
value.  Would it be worth carrying that bound here so the arch overrides
land on a well-defined per-iteration wait?

> +		__time_now = (s64)(time_expr_ns);			\
> +		if (unlikely(__time_end == 0))				\
> +			__time_end = __time_now + __timeout;		\
> +		__timeout = __time_end - __time_now;			\
> +		if (__time_now <= 0 || __timeout <= 0) {		\
> +			VAL = READ_ONCE(*__PTR);			\
> +			break;						\
> +		}							\
> +		__count = 0;						\
> +	}								\
> +	(typeof(*(ptr)))VAL;						\
> +})
> +#endif


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29315652884
--===============2756016215755141306==--
