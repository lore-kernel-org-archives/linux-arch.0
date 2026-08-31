Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E440385539;
	Mon, 31 Aug 2026 21:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211907; cv=none; b=hk8rLjRX30JySylEoi0UNNyreSClcj9ZwSLWwfIwIzzFEe9mpHCLY6QwR2+eGT6eJ+xGA1+ctsItmeQGR20Rw6F4f305NhY9+Xo20p9ZtwNMXt7NZY5zkW2MNQnAJms8zjndX73kruh3XihuwRaUT9upr3obdhhx8jaxX5iDgyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211907; c=relaxed/simple;
	bh=ZE4RQgArKc8SQwnA1HD4OD1RFHfbeEcEZ9iqk04zcPY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=J3BW7cAa7plSPrKpS65AtCo0WpV2KjmXW+qlmk8DV/sVA8Gwr57iU4SfxTImopKacJ1iy9S/YrrSX4atWNCcc3EBUULp5blu0ah/q59dDs2dGWOXPKB8c/EdzlNJLVjIao/yRKCvhWtBPeMlG2RXF2/dVI+U60fhjn3Nf0uwgt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EK7N2jzC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EK7N2jzC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2851F000E9;
	Mon, 31 Aug 2026 21:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211906;
	bh=oMQj1CO7FeLw5Q/x4SXoEK72/eOkUjphrW+XFi+9DSo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EK7N2jzCrtLimig81ZkOt9TOso8+dgSC8Jo2f1XZdJs3mOsKmqnAGtOAJ9ExpWYfC
	 Lq6YCVhVJ0iOXApkzPVqDuOYp81AZsoziox5jbT0U/mSsnLoc7e5x/PPJ++FjyJyec
	 vj78sOBp1JoyOdERiIebGytxXPmkMwndGrQ/yWaJRoD9QqYzU0gKf0Qvvs7SaTpDZs
	 1fqkQjjkWIwM9sjkwLehB1QHJJ1zsFOf39rRX26Uh9Sp71kPZsgbgHZkTCAZyMvvgv
	 EseCEwjVpUnYVeXEcpD8W3F91ukdGV2+cozl7sGqTR03gXL+EkjYKAEql5aiayVvb5
	 oKLCRrNRiDbUQ==
Content-Type: multipart/mixed; boundary="===============4967962990189229906=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c09ae02e72c39f6b963a9a2e6f28597abecf5e9a57a7cdf4c8a531843e9503e6@mail.kernel.org>
In-Reply-To: <20260831202251.305046-11-ankur.a.arora@oracle.com>
References: <20260831202251.305046-11-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v15 10/16] bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@linaro.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,rdunlap@infradead.org,david.laight.linux@gmail.com,broonie@kernel.org,joao.m.martins@oracle.com,boris.ostrovsky@oracle.com,konrad.wilk@oracle.com,ashok.bhat@arm.com,ankur.a.arora@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 21:31:45 +0000 (UTC)

--===============4967962990189229906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> index 1b249c6f0674..9e8f19afd7b0 100644
> --- a/kernel/bpf/rqspinlock.c
> +++ b/kernel/bpf/rqspinlock.c

[ ... ]

> @@ -269,6 +267,18 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
>   */
>  #define RES_RESET_TIMEOUT(ts, _duration) ({ (ts).timeout_end = 0; (ts).duration = _duration; })
>
> +/*
> + * Limit how often we invoke clock_deadlock() while spin-waiting in
> + * smp_cond_load_acquire_timeout() or atomic_cond_read_acquire_timeout().
> + *
> + * We only override the default value for architectures without a waiting
> + * implementation.
> + */
> +#ifndef CPU_POLL_RELAX_WAITS
> +#undef SMP_TIMEOUT_POLL_COUNT
> +#define SMP_TIMEOUT_POLL_COUNT	(16*1024)
> +#endif
> +

Does this CPU_POLL_RELAX_WAITS check correctly detect the waiting
implementation at runtime for arm64?

On arm64, CPU_POLL_RELAX_WAITS is defined unconditionally at
arch/arm64/include/asm/barrier.h:233, but cpu_poll_relax() picks its
implementation at runtime:

  #define cpu_poll_relax(ptr, val, timeout_ns) do {                  \
          if (alternative_has_cap_unlikely(ARM64_HAS_WFXT))          \
                  __cmpwait_relaxed_timeout(ptr, val, timeout_ns);   \
          else if (arch_timer_evtstrm_available())                   \
                  __cmpwait_relaxed(ptr, val);                       \
          else                                                       \
                  cpu_relax();                                       \
  } while (0)

So on every arm64 build SMP_TIMEOUT_POLL_COUNT stays at 1 ('Wait mode. No
need to poll.' per include/asm-generic/barrier.h:280-281) and the 16k
override is skipped. On arm64 hardware that has neither FEAT_WFXT nor an
available arch-timer event stream, cpu_poll_relax() degrades to a bare
cpu_relax(), and __smp_cond_load_relaxed_timeout() then evaluates
time_expr_ns on every loop iteration:

    cpu_poll_relax(__PTR, VAL, (u64)__scl_timeout);      /* == cpu_relax() */
    if (++__scl_count < __scl_spin)                      /* __scl_spin == 1 */
            continue;
    __scl_time_now = (s64)(time_expr_ns);                /* clock_deadlock() */

That means one noinline clock_deadlock() call with ktime_get_mono_fast_ns()
per cpu_relax() for the whole 250 ms / 500 ms wait, in both rqspinlock wait
loops (rqspinlock.c:427 and :590). Before this patch the same platform
amortized the clock read 1-in-65536 (the u16 'spin' wrap in the amortized
RES_CHECK_TIMEOUT), and the arm64 private copy removed earlier in the
series (f90a6cd43b71) amortized it 1-in-200 with a dedicated
non-event-stream path, whose comment called this case out explicitly: 'it
will not happen when event stream support is unavailable, time_expr check
is amortized.'

The commit message asserts 'We only do this for architectures lacking a
waiting implementation of cpu_poll_relax()', which is true at compile time
but not at run time for arm64 without WFXT/evtstrm. Gating on something
that reflects the runtime choice (or clamping __scl_spin when the waiting
path is not taken) would restore the amortization.

[ ... ]

>      Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>      Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>
>      Note:
>        - when overriding the SMP_TIMEOUT_POLL_COUNT value check for
>          CPU_POLL_RELAX_WAITS instead of directly checking for CONFIG_ARM64.

The commit message states:

>      Finally, redefine SMP_TIMEOUT_POLL_COUNT to be 16k to be similar to
>      the spin-count used in the amortized version.

Is the 16k value correct? The amortized version's spin count is 64k, not
16k. RES_CHECK_TIMEOUT_AMORTIZED gates on 'if (!(ts).spin++)'
(kernel/bpf/rqspinlock.c:244) and 'spin' is 'u16' (struct
rqspinlock_timeout, rqspinlock.c:80-85), so clock_deadlock() ran once per
65536 evaluations. The new SMP_TIMEOUT_POLL_COUNT of 16*1024 therefore
samples the clock 4x more often than the code it is said to match.

The direction is harmless, but the stated justification for the constant is
off by 4x, and it is the only rationale a reviewer has for the value.

Also, the macro excerpt quoted in the changelog does not match the tree:

        __time_now = (time_expr_ns);
        if (__time_now <= 0 || __time_now >= __time_end) {

The actual code (include/asm-generic/barrier.h:351-357) uses
__scl_-prefixed names and tests '__scl_timeout <= 0' after recomputing
'__scl_timeout = __scl_time_end - __scl_time_now'. It is equivalent, but
quoting code that is not in the tree makes the equality argument harder to
check.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33438155296
--===============4967962990189229906==--
