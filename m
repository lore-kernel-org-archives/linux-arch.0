Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69642E8B6B;
	Thu,  2 Jul 2026 02:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782958317; cv=none; b=H+ZH2QU1U5qpObscs07rT13yn9uXe2OSkFQMlgtcqvGeOMzYW3ShJuihg+xDaZg1HgY6kEjFYHCKLBjIZwPQJScmgp/vA/ZrYRzgs8qsptZ+ILNjDc3K1Ol08e7htqBMniYhlbfZYZOHhtb5YT3EYZ66HxqkQSGlq3/HlBUgfeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782958317; c=relaxed/simple;
	bh=+/6kqHOBHSJnm3HKR5zkZvO0Pei8wRETfdwkMhmkxDI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZRdAtqQAglD1S9d2X9bqoG3TSm+fbAlnrZ1azG1zqUn9lD2B2CkCoR7DnxP9CtFj3Xfo0SFL/LdO0cxyxWntZnoRxl2SefNX7Xn+dNrIBusGA+MDzLYSdYxXwZj0NQb0nrR0MeCINI7P51hQedZdc0L3P2uFPEScHifOquhNEPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnhhggMG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnhhggMG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F581F00A3A;
	Thu,  2 Jul 2026 02:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782958315;
	bh=22emMlIsPtDrhqmZ4A8+AHkM26C/CxzEvHf32koa6ZE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=AnhhggMGcmGV9OElKHa7vlVrgQFcxDdyStdOySnJQe8g8PtnwExNxBsde62x5riKZ
	 CivR8hFUzCpLGfZ7WLs6NF9WmyLyZVbD0awEEmQlEELORxx/SVjAAA5JfVcO62Fvll
	 qUjmNu9SLSLuhXKGl57T1A5PBcBtq4/r+Ra20RI7z284AgQe+Px1wIq7N/mvPb3dhA
	 Dy2B7Bzu5aSAu6ohriAzsvGoei7VPPZBJ5XOHdyilsU1LITPaoDIzyJK8YABsB4HRF
	 XzNzrFlDOwYhPWaxbWiKr4qwuM0eZtnAj7n3ngaXICd2ZSSEPruMpMaqtVEgYsRCC+
	 R6Hnln1KH11Bw==
Content-Type: multipart/mixed; boundary="===============0253007402283867756=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <457d2616d79d9e1a2a3fe06ab548cde2028a979433bd95bdc5859da4d7760e79@mail.kernel.org>
In-Reply-To: <20260702013334.140905-2-ankur.a.arora@oracle.com>
References: <20260702013334.140905-2-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v13 01/15] asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@linaro.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,rdunlap@infradead.org,david.laight.linux@gmail.com,broonie@kernel.org,joao.m.martins@oracle.com,boris.ostrovsky@oracle.com,konrad.wilk@oracle.com,ashok.bhat@arm.com,ankur.a.arora@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  2 Jul 2026 02:11:55 +0000 (UTC)

--===============0253007402283867756==
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

[ ... ]

> +#ifndef cpu_poll_relax
> +#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
> +#endif

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

This same point came up during review of v11. David Laight noted that
__timeout here is a relative value, and that passing it straight to
cpu_poll_relax() is only safe when cpu_poll_relax() ignores its timeout
argument, as the generic cpu_relax() fallback does.

For an arm64 WFE/WFET style cpu_poll_relax() that actually waits on the
supplied timeout, would this spin roughly SMP_TIMEOUT_POLL_COUNT *
timeout_ns before the first time-check?

> +		if (++__count < __spin)					\
> +			continue;					\
> +		__time_now = (s64)(time_expr_ns);			\
> +		if (unlikely(__time_end == 0))				\
> +			__time_end = __time_now + __timeout;		\

__time_end is only initialized here, after the first cpu_poll_relax()
call has already run with the full relative __timeout, so the initial
wait is not counted against the timeout window.

Would it be worth converting the relative timeout to an absolute end-time
once up front, or at least documenting that the effective timeout can be
roughly doubled for such an implementation?

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
> +


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28559763019
--===============0253007402283867756==--
