Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB639B94A;
	Mon, 31 Aug 2026 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211023; cv=none; b=ru1BPinhZy+icxl3gXuaCWvUnmc4FklQJYqTsDkD6N5tJBkk4ra+KhN0cQLOTP7TAla7nP2Xv14kTWaSnbIF1dCtJFFGJID8Dutdlx+LEN5aj1QSNdKbHFkbSfOn/d+pX3YqTfzYyA5KYxAXT5e527kHMRYoPIv+V0FxzmhKPXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211023; c=relaxed/simple;
	bh=MOZFRdAKP9ovrqela7gM8aRNxcle0gEo+iz/t0jhX5s=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VZVamI6ijVHZYuLuCwGC5q/fhVt0egMfvXcbfa8etxPglXBFppGe06RoJQV77/vxBRRUkd/4E3RZu1uUMD06e48p2CxYt80zBvIgF3GAolP93oZL5MSuse/VQ7whdptAWoEyUEwyfL6bM3e+5WNS/imTV5vf52JU3gsErs/0rM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqIibbFC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqIibbFC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B178D1F000E9;
	Mon, 31 Aug 2026 21:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211020;
	bh=sgGJaUb4R+xJg+MMxTj0+TmMU4rJr/qTBBhHZsUa1cE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TqIibbFC5uAZ5mj/s3rM8OUWL7vzYPOXwenGkRH5taeITWsXJ7h0bTzddY9F7EW8o
	 ry/sQC9tHrlfC1Tji2J+SEt6wsd+Wj6MJh4X0oD+KYAe4Ugeho5oN8b/WnayhKtPYB
	 u1LOzrqeMsbLtIa5hkbQu7EiZaB5Z23v6vdMNU1tFKSWfCLgMH8yUP44Gtb62TKDJc
	 wtZPeMpHvdwPctVTYWb88mqKZn+CRiQP1xhtifD+qtV+ZFCsihezBRubA8rhpyALKL
	 nez5zV4rBu2mGMCAUK0uWQMWw1krMeYu7JWePGLfXLT7+uSmnhwP+446mp6Mnl0gD+
	 gBtQOCPSSD2Lw==
Content-Type: multipart/mixed; boundary="===============4990838912714265687=="
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f47a36669d06226dec908ca89ff9d04bdfd594844394b09ef45c4291283532ea@mail.kernel.org>
In-Reply-To: <20260831202251.305046-5-ankur.a.arora@oracle.com>
References: <20260831202251.305046-5-ankur.a.arora@oracle.com>
Subject: Re: [PATCH v15 04/16] arm64: support WFET in smp_cond_load_relaxed_timeout()
From: bot+bpf-ci@kernel.org
To: ankur.a.arora@oracle.com,linux-kernel@vger.kernel.org,linux-arch@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-pm@vger.kernel.org,bpf@vger.kernel.org
Cc: arnd@arndb.de,catalin.marinas@arm.com,will@kernel.org,peterz@infradead.org,akpm@linux-foundation.org,mark.rutland@arm.com,harisokn@amazon.com,cl@gentwo.org,ast@kernel.org,rafael@kernel.org,daniel.lezcano@linaro.org,memxor@gmail.com,zhenglifeng1@huawei.com,xueshuai@linux.alibaba.com,rdunlap@infradead.org,david.laight.linux@gmail.com,broonie@kernel.org,joao.m.martins@oracle.com,boris.ostrovsky@oracle.com,konrad.wilk@oracle.com,ashok.bhat@arm.com,ankur.a.arora@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 21:16:58 +0000 (UTC)

--===============4990838912714265687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> arm64: support WFET in smp_cond_load_relaxed_timeout()
>
> To handle WFET use __cmpwait_timeout() similarly to __cmpwait(). These
> call out to the respective __cmpwait_case_timeout_##sz(),
> __cmpwait_case_##sz() functions.

This isn't a bug, but could the changelog say why the WFET path is
preferred over the event-stream path, and note how the deadline is
derived (and on which counter base), rather than describing which macros
call which?

> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index d186a4558776..d1f4f571adaa 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h

[ ... ]

> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> index 6cf3cd6873f5..7985ae5ceb0f 100644
> --- a/arch/arm64/include/asm/cmpxchg.h
> +++ b/arch/arm64/include/asm/cmpxchg.h

[ ... ]

> @@ -235,20 +237,52 @@ __CMPWAIT_CASE( ,  , 64);
>
>  #undef __CMPWAIT_CASE
>
> +#define __CMPWAIT_TIMEOUT_CASE(w, sfx, sz)				\
> +static inline void __cmpwait_case_timeout_##sz(volatile void *ptr,	\
> +					       unsigned long val,	\
> +					       u64 timeout_ns)		\
> +{									\
> +	unsigned long tmp;						\
> +	u64 ecycles = __delay_cycles() +				\
> +			nsecs_to_cycles(timeout_ns);			\
> +	asm volatile(							\
> +	"	sevl\n"							\
> +	"	wfe\n"							\
> +	"	ldxr" #sfx "\t%" #w "[tmp], %[v]\n"			\
> +	"	eor	%" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"	\
> +	"	cbnz	%" #w "[tmp], 2f\n"				\
> +	"	msr s0_3_c1_c0_0, %[ecycles]\n"				\
> +	"2:"								\
> +	: [tmp] "=&r" (tmp), [v] "+Q" (*(u##sz *)ptr)			\
> +	: [val] "r" (val), [ecycles] "r" (ecycles));			\
> +}

This isn't a bug, but since only the final wait instruction differs
from __CMPWAIT_CASE (the sevl/wfe/ldxr/eor/cbnz prologue and the
operand lists are identical), would folding the two into one macro that
takes the wait instruction (and the optional deadline operand) read
better, in the style of __XCHG_CASE()? And is the 1f -> 2f label
renumbering needed?

> +
> +__CMPWAIT_TIMEOUT_CASE(w, b, 8);
> +__CMPWAIT_TIMEOUT_CASE(w, h, 16);
> +__CMPWAIT_TIMEOUT_CASE(w,  , 32);
> +__CMPWAIT_TIMEOUT_CASE( ,  , 64);
> +
> +#undef __CMPWAIT_TIMEOUT_CASE

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33438155296
--===============4990838912714265687==--
