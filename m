Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C4139CD05;
	Mon, 31 Aug 2026 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211027; cv=none; b=FQckjBj6WOoTwkKid2xh6h7kSo9+jS860Srgd6f86btB/J7yS//7+18KXrH/ITTnKETL72HafKOzysZFex0eu20c8b0e8I4Y44hFGqp7oonPlczD6T2KllDFEym9mD8at77Cgz0k1vph9J6vloBSh1Nzeljiapb3sHh3Q4dEZhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211027; c=relaxed/simple;
	bh=a85KVon7CsKywryGey5VQrAomWHtJnt7kBqWgORftCQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=K60bBmOW6AtmER32WLQSGmacLoiSDv+xnNMM1ngIYjk3YtfXV2B9CBC7XNW2cNZk6eUS6bCv+T4GgQaY1j725SPgf5IWBrtfQHl0za3UlZGSqY+gKyvIDvlbhFUHRITtGCV8FIg82qctyqcTkxN57F9mX7Gm12Vk56JfcifKEZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGCEE2Rk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGCEE2Rk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E4A1F000E9;
	Mon, 31 Aug 2026 21:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211026;
	bh=Gf5UfaqraRajzUlSqAbExhi7YqgCg+VWMqoQKEm7Za4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eGCEE2RkxAWzElnprzbSiS3AjtuxX6BqSVep+Y1nes+FzY2VHHCHh98jhfeP9juKi
	 HZuQkUqF8vhU/XxguwTd7UHvowB7Aqe4HSQeGC7sFSV31mG/rlLLkpD3NS1AXjyVDH
	 NDX/0AxXslSrMTsC566hYNrzaf/c1UTGlhiKvhgR+1bVWHIJSitRfLecpkKn8wWygQ
	 zIy7FlszZNGuplKd9lcN43JjYnVgIDFW5P/GtXn8SIs9c+TsSfUCiYa4L5LjhueX3H
	 s8OJFaRpd8dvjTdrAdhln9kazvcRImdBtjfcyA5QGD8kYoMtTp5lL3qckgMVGkAWQg
	 Fy3h5CV1kVPBg==
Content-Type: multipart/mixed; boundary="===============8970126971584631980=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d98e7c48eb83be367357f40747d9489ac50c85c184979866a37359998548dbc2@mail.kernel.org>
In-Reply-To: <20260831202251.305046-7-ankur.a.arora@oracle.com>
References: <20260831202251.305046-7-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v15 06/16] asm-generic: barrier: Add smp_cond_load_acquire_timeout()
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@linaro.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,rdunlap@infradead.org,david.laight.linux@gmail.com,broonie@kernel.org,joao.m.martins@oracle.com,boris.ostrovsky@oracle.com,konrad.wilk@oracle.com,ashok.bhat@arm.com,ankur.a.arora@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 21:17:04 +0000 (UTC)

--===============8970126971584631980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index 8c37de192944..8b166acfba12 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -379,6 +379,54 @@ do {									\
>  })
>  #endif
>
> +/**
> + * smp_cond_load_acquire_timeout() - (Spin) wait for cond with ACQUIRE ordering
> + * until a timeout expires.
> + * @ptr: pointer to the variable to wait on.
> + * @cond_expr: boolean expression to wait for.
> + * @time_expr_ns: monotonic expression that evaluates to time in ns or,
> + *  on failure, returns a negative value.

The documentation says @time_expr_ns "on failure, returns a negative value",
but the implementation in __smp_cond_load_relaxed_timeout() exits when
__scl_time_now <= 0, treating zero as a failure too. Should the
documentation say "zero or a negative value" to match what
smp_cond_load_relaxed_timeout() documents (barrier.h:317-318)?

> + * @timeout_ns: timeout value in ns
> + * (Both of the above are assumed to be compatible with s64.)
> + *
> + * Equivalent to using smp_cond_load_acquire() on the condition variable with
> + * a timeout.
> + */
> +#ifndef smp_cond_load_acquire_timeout
> +#define smp_cond_load_acquire_timeout(ptr, cond_expr,			\
> +				      time_expr_ns, timeout_ns)		\
> +({									\
> +	__unqual_scalar_typeof(*(ptr)) VAL;				\
> +	VAL = smp_cond_load_relaxed_timeout(ptr, cond_expr,		\
> +					     time_expr_ns,		\
> +					     timeout_ns);		\
> +	/*								\
> +	 * We arrive here once the loop condition is hit, on timeout,	\
> +	 * or, if we hit both the timeout and the loop condition.	\
> +	 *								\
> +	 * For the first case, we come here having already evaluated	\
> +	 * the control dependency.					\
> +	 * In the last case -- low probability, possible in the last	\
> +	 * iteration, especially on architectures with waiting		\
> +	 * cpu_poll_relax() -- the control dependency has not been	\
> +	 * evaluated.							\
> +	 *								\
> +	 * So, force it to be re-evaluated before			\
> +	 * smp_acquire__after_ctrl_dep() to provide ACQUIRE ordering	\
> +	 * for both.							\
> +	 *								\
> +	 * The other case is of pure timeout, where again we don't have \
> +	 * the advantage of having the control dependency. Given that	\
> +	 * this is the slowpath, we go with a full smp_load_acquire().	\
> +	 */								\
> +	if (cond_expr)							\
> +		smp_acquire__after_ctrl_dep();				\
> +	else								\
> +		VAL = smp_load_acquire(ptr);				\

The macro evaluates cond_expr one extra time here, after the
smp_cond_load_relaxed_timeout() call has already returned. This means
cond_expr is silently required to be side-effect free and a pure function
of VAL.

The kernel-doc says the macro is "Equivalent to using
smp_cond_load_acquire() on the condition variable with a timeout"
(barrier.h:392-393), but in smp_cond_load_acquire() cond_expr is only
evaluated immediately after a fresh READ_ONCE inside the loop. If cond_expr
also depends on state other than VAL, or has side effects, the two
evaluations can disagree:

  VAL = smp_cond_load_relaxed_timeout(ptr, cond_expr, ...);  /* succeeded, cond was true */
  if (cond_expr)                                             /* now false */
          smp_acquire__after_ctrl_dep();
  else
          VAL = smp_load_acquire(ptr);                       /* successful result discarded */

When that happens the successful wait's value is thrown away and replaced
by a fresh read, and any side effects inside cond_expr run one extra time.

This pattern is not hypothetical for the smp_cond_load_acquire() family.
In-tree conditions that are not pure functions of VAL include:

  arch/arm64/mm/mmu.c:
    smp_cond_load_acquire(&idmap_kpti_bbml3_flag, VAL == num_online_cpus());

  include/asm-generic/ticket_spinlock.h:
    atomic_cond_read_acquire(&lock->val, ticket == (u16)VAL);

  kernel/bpf/rqspinlock.c:
    res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));

No current caller in the series is broken by this - every new user passes
a condition that is a pure function of VAL. But should the requirement be
documented, or should the equivalence claim in the kernel-doc be weakened?

> +	(typeof(*(ptr)))VAL;						\
> +})
> +#endif
> +
>  /*
>   * pmem_wmb() ensures that all stores for which the modification
>   * are written to persistent storage by preceding instructions have


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33438155296
--===============8970126971584631980==--
